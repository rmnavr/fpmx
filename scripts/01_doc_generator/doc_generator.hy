
; doc_gen needs to use ACTUAL fpmx version, because it needs to extract help strings
; Imports ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (require fpmx.loader [load_fpmx])
    (load_fpmx "prelude" "lenses")

    (import pyparsing :as pp)

    (import io)
    (import contextlib)
    (import re)

; _____________________________________________________________________________/ }}}1

; CLASSES ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; FPMX Group from VimCells as raw text, like from "[GROUP] 04 APL: Filtering"
    (defclass [dataclass] FGroup []
        ( #^ str name); APL
        ( #^ str subname); Filtering
        ( #^ int order); 04
        ( #^ str raw_content))

    (defclass FEntityKind [Enum]
        (setv IMPORT_MODULE 0); (import math)
        (setv IMPORT_FROM_MODULE 1); (import funcy [list])
        (setv IMPORT_FROM_MODULE_AS 2); (import funcy [list :as tree])
        (setv REQUIRE_MACRO 3); (require hyrule [->]), also used by MACRO-exclusive regex
        (setv NON_IMPORT_INFO 4); (comment ...)
        (setv DEFINED_SETV 5); (setv x (+ 1 2))
        (setv DEFINED_FUNC 6); (defn inc [x] (+ x 1))
        (defn __repr__ [self] (return self.name))
        (defn __str__ [self] (return self.name)))

    ; "FPMX Entity — function, macros, etc."
    (defclass [dataclass] FEntity []
        ( #^ FEntityKind kind)
        ( #^ str kind_str #_ "used only for non-import-info, typically I use: 'macro' or 'base', but it is arbitrary"); empty string otherwise
        ( #^ str org_name #_ "used only for :as imports"); empty string otherwise
        ( #^ str name #_ "rpartial")
        ( #^ str parent_module #_ "funcy")
        ( #^ str signature #_ "rpartial(f, *args)")
        ( #^ str descr #_ "partially applicates"))

    ; used for creating DEFINED_FUNC/DEFINED_SETV as parent module name
    (setv $FPMX_NAME "fpmx")

    (defclass [dataclass] DFGroup []; Deconstructed FPMX Group
        ( #^ str name)
        ( #^ str subname)
        ( #^ int order)
        ( #^ (of List FEntity) fentities))

; _____________________________________________________________________________/ }}}1
; Parser for [GROUP] ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

; FIND GROUPS:
; ■ hy atoms ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv ALPHAS    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
    (setv WSYMBOLS  (+ "_" "$.-=+&*<>!/|:" "%^?"))
    (setv MSYMBOLS  "#`'~@\\,")
    (setv NUMS      "0123456789")

    (setv LPAR      (+ (pp.Optional "#") (pp.Literal "(")))
    (setv RPAR      (pp.Literal ")"))

    (setv LBRCKT    (pp.Literal "["))
    (setv RBRCKT    (pp.Literal "]"))

    (setv LCRB      (+ (pp.Optional "#") (pp.Literal "{")))
    (setv RCRB      (pp.Literal "}"))

    ; =========================================================

    (setv NUMBER (| (pp.Combine (+ (pp.Optional "-")
                                   (pp.Word NUMS)
                                   (pp.Optional ".")
                                   (pp.Optional (pp.Word NUMS))
                                   (pp.Optional (+ (pp.oneOf "e E")
                                                   (pp.Optional (pp.oneOf "- +"))
                                                   (pp.Word NUMS)))))
                    (pp.Combine (+ (pp.Word ".") (pp.Word NUMS)))))

    (setv UNPACKER     (| (pp.Literal "#**") (pp.Literal "#*")))
    (setv WORD         (pp.Word (+ ALPHAS WSYMBOLS) (+ ALPHAS NUMS WSYMBOLS ":")))
    (setv KEYWORD      (pp.Combine (+ ":" (pp.Word (+ ALPHAS "_") (+ ALPHAS "_" NUMS)))))
    (setv QSTRING      (pp.Combine (+  (pp.Optional (pp.oneOf "r f b"))
                                       (pp.QuotedString   :quoteChar "\""
                                                          :escChar "\\"
                                                          :multiline True
                                                          :unquoteResults False))))
    (setv OCOMMENT     (pp.Combine (+  (pp.Literal ";;")
                                       (pp.SkipTo (pp.lineEnd)))))

    ; ==========================
    ; ATOM    = words and similar
    ; EXPR    = bracketed
    ; CONTENT = 0+ words or bracketed

    (setv ICOMMENT     (pp.Forward))
    (setv ANNOTATION   (pp.Forward))
    (setv QEXPR        (pp.Forward)); [ ... ]
    (setv SEXPR        (pp.Forward)); ( ... ) #( ... )
    (setv CEXPR        (pp.Forward)); { ... } #{ ... }

    (setv ATOM         (|  OCOMMENT
                           ICOMMENT
                           ANNOTATION
                           QSTRING
                           KEYWORD
                           WORD
                           UNPACKER
                           NUMBER
                           (pp.oneOf MSYMBOLS)))

    (setv EXPR         (| QEXPR SEXPR CEXPR))

    (setv CONTENT      (pp.Group (pp.ZeroOrMore (| EXPR ATOM))))
    (<<   QEXPR        (pp.Group (+ LBRCKT CONTENT RBRCKT)))
    (<<   SEXPR        (pp.Group (+ LPAR   CONTENT RPAR)))
    (<<   CEXPR        (pp.Group (+ LCRB   CONTENT RCRB)))

    (<<   ICOMMENT     (pp.Group (+ (pp.Literal "#_") (| EXPR ATOM))))
    (<<   ANNOTATION   (pp.Group (+ (pp.Literal "#^") (| EXPR ATOM))))

; ________________________________________________________________________/ }}}2
; ■ strings utils ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    ; «"pups"» -> «pups»
    (defn #^ str remove_quotes [#^ str input_string]
        (setv string input_string)
        (when (= "\"" (first string)) (setv string (drop  1 string)))
        (when (= "\"" (last  string)) (setv string (drop -1 string)))
        string)

    (defn #^ str
        pad_string
        [ #^ str  string
          #^ int  required_len
          #^ str  [fill_char " "]
          #^ bool [pad_right False]
        ]
        "returns string with len >= required_len"
        (setv n_required (max 0 (- required_len (len string))))
        (if (= pad_right False)
            (setv outp (sconcat string (* fill_char n_required)))
            (setv outp (sconcat (* fill_char n_required) string)))
        (return outp))


; ________________________________________________________________________/ }}}2
; ■ split descr ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    ; [t]oken [o]riginal [r]esult [n]ame
    (defn t_orn [name token] (-> token pp.originalTextFor (.setResultsName name)))

    (setv $SEPARATOR "|")

    ; for normal:          «f(xs) | smth» -> ("f(xs)", "smth")
    ; for non-import-info: «module | kind | name | signature | descr»
    (defn #^ FEntity split_descr [#^ FEntity fentity]
        (setv org_descr fentity.descr)
        (setv result (lmap strip (org_descr.split $SEPARATOR)))
        ; normal case:
        (when (= (len result) 2)
              (setv fentity.signature (first  result))
              (setv fentity.descr     (second result)))
        ; non-import-info case:
        (when (= (len result) 5)
              (setv fentity (FEntity :kind          FEntityKind.NON_IMPORT_INFO
                                     :kind_str      (second result)
                                     :org_name      ""
                                     :name          (third  result)
                                     :parent_module (first  result)
                                     :signature     (fourth result)
                                     :descr         (nth  4 result))))
        (return fentity))

; ________________________________________________________________________/ }}}2
; ■ find groups (defined by VimCells) ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_GROUP (+ "; [GROUP]"
                        (t_orn "_NUMBER" NUMBER)
                        (t_orn "_NAME" (pp.OneOrMore (pp.Word (+ ALPHAS "_-/")))) ":"
                        (t_orn "_SUBNAME" (pp.OneOrMore (pp.Word (+ ALPHAS "_-/"))))
                        (pp.OneOrMore "‾") "\\ {" "{{" "1"
                        (t_orn "_CONTENT" CONTENT)
                        ";" (pp.OneOrMore "_") "/ }}" "}1"))

    (defn #^ (of List FGroup)
        find_fgroups [#^ str code]
        (setv _groups (FPMX_GROUP.search_string code))
        (lmap
            (fm
              (FGroup :name %1._NAME
                     :subname %1._SUBNAME
                     :order %1._NUMBER
                     :raw_content %1._CONTENT))
            _groups))

; ________________________________________________________________________/ }}}2

; FIND FENTITIES IN GROUP:
; lmap everywhere is honestly not required, since normally only 1 elem is expected (but hey)
; ■ find import_module ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_IM (+ LPAR "import"
                     (t_orn "_NAME" WORD)
                     RPAR
                     (pp.Optional (+ (pp.Literal "#_") (t_orn "_DESCR" QSTRING)))))

    (defn #^ (of List FEntity)
        process_IMs [#^ str code]
        (setv _IMs (FPMX_IM.search_string code))
        (lmap (fm (FEntity :kind          FEntityKind.IMPORT_MODULE
                           :kind_str      ""
                           :org_name      ""
                           :name          %1._NAME
                           :parent_module ""
                           :signature     ""
                           :descr         (remove_quotes %1._DESCR)))
              _IMs))

; ________________________________________________________________________/ }}}2
; ■ find import_from_module ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_IFM (+ LPAR "import"
                      (t_orn "_PARENT_MODULE" WORD)
                      LBRCKT
                      (t_orn "_NAME" WORD)
                      RBRCKT
                      RPAR
                      (pp.Optional (+ (pp.Literal "#_") (t_orn "_DESCR" QSTRING)))))

    (defn #^ (of List FEntity)
        process_IFMs [#^ str code]
        (setv _IFMs (FPMX_IFM.search_string code))
        (setv pipe
            (rcompose (fm (FEntity :kind          FEntityKind.IMPORT_FROM_MODULE
                                   :kind_str      ""
                                   :org_name      ""
                                   :name          %1._NAME
                                   :parent_module %1._PARENT_MODULE
                                   :signature     ""
                                   :descr         (remove_quotes %1._DESCR)))
                      split_descr))
        (lmap pipe _IFMs))

; ________________________________________________________________________/ }}}2
; ■ find import_from_module_as ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_IFMA (+ LPAR "import"
                       (t_orn "_PARENT_MODULE" WORD)
                       LBRCKT
                       (t_orn "_ORG_NAME" WORD)
                       ":as"
                       (t_orn "_NAME" WORD)
                       RBRCKT
                       RPAR
                       (pp.Optional (+ (pp.Literal "#_") (t_orn "_DESCR" QSTRING)))))

    (defn #^ (of List FEntity)
        process_IFMAs [#^ str code]
        (setv _IFMAs (FPMX_IFMA.search_string code))
        (setv pipe
            (rcompose (fm (FEntity :kind          FEntityKind.IMPORT_FROM_MODULE_AS
                                   :kind_str      ""
                                   :org_name      %1._ORG_NAME
                                   :name          %1._NAME
                                   :parent_module %1._PARENT_MODULE
                                   :signature     ""
                                   :descr         (remove_quotes %1._DESCR)))
                      split_descr))
        (lmap pipe _IFMAs))

; ________________________________________________________________________/ }}}2
; ■ find require_macro ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_RM  (+ LPAR "require"
                      (t_orn "_PARENT_MODULE" WORD)
                      LBRCKT
                      (t_orn "_NAME" WORD)
                      RBRCKT
                      RPAR
                      (pp.Optional (+ (pp.Literal "#_") (t_orn "_DESCR" QSTRING)))))

    (defn #^ (of List FEntity)
        process_RMs [#^ str code]
        (setv _RMs (FPMX_RM.search_string code))
        (setv pipe
            (rcompose (fm (FEntity :kind          FEntityKind.REQUIRE_MACRO
                                   :kind_str      ""
                                   :org_name      ""
                                   :name          %1._NAME
                                   :parent_module %1._PARENT_MODULE
                                   :signature     ""
                                   :descr         (remove_quotes %1._DESCR)))
                      split_descr))
        (lmap pipe _RMs))


; ________________________________________________________________________/ }}}2
; ■ find non_import_info ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_NII (+ LPAR "comment" (t_orn "_DESCR" QSTRING) RPAR))

    (defn #^ (of List FEntity)
        process_NIIs [#^ str code]
        (setv _NIIs (FPMX_NII.search_string code))
        (setv pipe
            (rcompose (fm (FEntity :kind          FEntityKind.NON_IMPORT_INFO
                                   :kind_str      ""
                                   :org_name      ""
                                   :name          ""
                                   :parent_module ""
                                   :signature     ""
                                   :descr         (remove_quotes %1._DESCR)))
                      split_descr))
        (lmap pipe _NIIs))

; ________________________________________________________________________/ }}}2
; ■ find defined_setv ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_DS   (+ (pp.Optional (+ (pp.Literal "#_") (t_orn "_DESCR" QSTRING)))
                       LPAR "setv"
                       (t_orn "_NAME" WORD)
                       CONTENT))

    (defn #^ (of List FEntity)
        process_DSs [#^ str code]
        (setv _DSs (FPMX_DS.search_string code))
        (lmap (fm (FEntity :kind          FEntityKind.DEFINED_SETV
                           :kind_str      ""
                           :org_name      ""
                           :name          %1._NAME
                           :parent_module $FPMX_NAME
                           :signature     ""
                           :descr         (remove_quotes %1._DESCR)))
              _DSs))

; ________________________________________________________________________/ }}}2
; ■ find defined_func ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_DF   (+ (pp.Optional (+ (pp.Literal "#_") (t_orn "_DESCR" QSTRING)))
                       LPAR "defn"
                       (pp.Optional QEXPR)      ; decorator
                       (pp.Optional ANNOTATION) ; return type
                       (t_orn "_NAME" WORD)     ; name
                       CONTENT
                       RPAR))

    (defn #^ (of List FEntity)
        process_DFs [#^ str code]
        (setv _DFs (FPMX_DF.search_string code))
        (setv pipe
            (rcompose (fm (FEntity :kind          FEntityKind.DEFINED_FUNC
                                   :kind_str      ""
                                   :org_name      ""
                                   :name          %1._NAME
                                   :parent_module $FPMX_NAME
                                   :signature     ""
                                   :descr         (remove_quotes %1._DESCR)))
                      split_descr))
        (lmap pipe _DFs))

; ________________________________________________________________________/ }}}2
; ■ find fentities (assembly) ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{2

    (setv FPMX_ALL (| (t_orn "_IM"   FPMX_IM  )
                      (t_orn "_IFM"  FPMX_IFM )
                      (t_orn "_IFMA" FPMX_IFMA)
                      (t_orn "_RM"   FPMX_RM  )
                      (t_orn "_NII"  FPMX_NII )
                      (t_orn "_DF"   FPMX_DF  )
                      (t_orn "_DS"   FPMX_DS  )))

    (defn #^ (of List FEntity)
        find_fentities
        [#^ FGroup fgroup]
        (setv _ALL (FPMX_ALL.search_string fgroup.raw_content))
        (setv _fentities
            (lfor &elem _ALL
                ; «first» extracts found string (to send raw code further)
                (cond (!= &elem._IM   "") (process_IMs   (first &elem))
                      (!= &elem._IFM  "") (process_IFMs  (first &elem))
                      (!= &elem._IFMA "") (process_IFMAs (first &elem))
                      (!= &elem._RM   "") (process_RMs   (first &elem))
                      (!= &elem._NII  "") (process_NIIs  (first &elem))
                      (!= &elem._DS   "") (process_DSs   (first &elem))
                      (!= &elem._DF   "") (process_DFs   (first &elem)))))
        (flatten _fentities))

; ________________________________________________________________________/ }}}2

    (def:: FGroup => DFGroup
        deconstruct_fgroup
        [ fgroup]
        (DFGroup :name fgroup.name
                :subname fgroup.subname
                :order (int fgroup.order)
                :fentities (find_fentities fgroup)))

; _____________________________________________________________________________/ }}}1
; Regex  for [MACRO] ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: str -> str => (of List DFGroup)
        find_macros [code searched_module_name]
        "will search for macros inside (require `module_name` [...])"
        ;
        (setv _whole_expression
            (re_find
                (sconcat r"\(require\s+" searched_module_name r"\s+\[.*?\]\)")
                code
                :flags (| re.DOTALL))); make . match also newline
        ;
        (setv _macro_exprs
            (re_all
                ; --1--                         --2---   --3--    --4--        --5--        --6--
                r"(\S+)\s+#_\s+\"\s*\[GROUP\]\s*(\d\d)\s*(.*?):\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\""
                _whole_expression))
        ; create dfgroups consisting of one fentity:
        (setv _dfgs
            (lmapm
                (DFGroup :name (third it)
                        :subname (fourth it)
                        :order (int (second it ))
                        :fentities
                        [ (FEntity :kind FEntityKind.REQUIRE_MACRO
                                  :kind_str ""
                                  :org_name ""
                                  :name (first it)
                                  :parent_module searched_module_name
                                  :signature (nth_ 5 it)
                                  :descr (nth_ 6 it))])
                _macro_exprs))
        ; group them by group-name:
        (unite_dfgroups _dfgs))

    ; helper
    (def:: (of List DFGroup) => (of List DFGroup)
        unite_dfgroups [dfgroups]
        "when found dfgroups with same [order+name+subname], their fentities are unified into one new dfgroup"
        (setv _exploded_dfgroups
            (->> dfgroups
                (lmapm
                    (lzip
                        (lmul [it] (len it.fentities))
                        it.fentities))
                (lcat))); [ (dfgA, f1A), (dfgA, f2A), (dfgB, f1B), ... ]
        ;
        (setv _grouped_by_name
            (lpartition_by
                (fm (. it [0] order))
                (sorted _exploded_dfgroups :key (fm (. it [0] order)))))
                                                ; [ [[dfgA, f1A], [dfgA, f2A]], [[...]], ... ]
        ;
        (lmapm
            (DFGroup :name (. it [0] [0] name)
                    :subname (. it [0] [0] subname)
                    :order (. it [0] [0] order)
                    :fentities (lpluck 1 it))
            _grouped_by_name))

; _____________________________________________________________________________/ }}}1

; One-liners table («long»):
; fentity to str ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ str fentity2str [ #^ FEntity fe ]
        (setv pad1 (fm (pad_string %1 15)))
        (setv pad2 (fm (pad_string %1 24)))
        ;
        (case fe.kind
              ;
              FEntityKind.IMPORT_MODULE
              (sconcat "FULL MODULE           | " (pad2 fe.name) (build_postfix fe))
              ;
              FEntityKind.IMPORT_FROM_MODULE
              (sconcat "FROM: " (pad1 fe.parent_module) " | " (pad2 fe.name) (build_postfix fe))
              ;
              FEntityKind.IMPORT_FROM_MODULE_AS
              (sconcat "FROM: " (pad1 fe.parent_module) " | " (pad2 (sconcat fe.name " (<-" fe.org_name ")")) (build_postfix fe))
              ;
              FEntityKind.REQUIRE_MACRO
              (sconcat "MACR: " (pad1 fe.parent_module) " | " (pad2 fe.name) (build_postfix fe))
              ;
              FEntityKind.NON_IMPORT_INFO
              (sconcat "INFO: " (pad1 fe.parent_module) " | " (pad2 (sconcat fe.name " /" fe.kind_str "/")) (build_postfix fe))
              ;
              FEntityKind.DEFINED_SETV
              (sconcat "SETV: " (pad1 fe.parent_module) " | " (pad2 fe.name) (build_postfix fe))
              FEntityKind.DEFINED_FUNC
              (sconcat "DEFN: " (pad1 fe.parent_module) " | " (pad2 fe.name) (build_postfix fe))))

    ; helper
    (defn #^ str build_postfix [ #^ FEntity fe ]
        (setv signature (if (= fe.signature "")
                            ""
                            (sconcat " :: " fe.signature " ")))
        (setv descr     (if (= fe.descr "")
                            ""
                            (sconcat " ; " fe.descr) ))
        (return (sconcat signature descr)))

; _____________________________________________________________________________/ }}}1
; assembly ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: (of List DFGroup) => str
        generate_long_table [dfgroups]
        "expects dfgroups to be already order-sorted"
        (->> dfgroups
            (lpartition_by (fm it.name))
            (lmap dfgroups_with_same_name_2str_list)
            (flatten)
            (str_join :sep "\n")
            (flip sconcat "\n")))

    ; helper
    (def:: (of List DFGroup) => (of List str)
        dfgroups_with_same_name_2str_list [dfgroups]
        "«name» here is exacly .name (e.g. not .subname or smth)"
        (setv _line0 (sconcat "=== " (. dfgroups [0] name) " ==="))
        (setv _midlines (lmap dfgroup2str_list dfgroups))
        (setv _lineFinal "")
        (return (lconcat [_line0] _midlines [_lineFinal])))

    ; helper of helper
    (def:: DFGroup => (of List str)
        dfgroup2str_list [dfgroup]
        (lconcat
            [(sconcat ";: " dfgroup.subname ":")]
            (lmap (p: fentity2str rstrip) dfgroup.fentities))); rstrip removes possible spaces on the right (to not invoke «next line» in *.md)

; _____________________________________________________________________________/ }}}1

; Md table («short») (consists of: ¹ cheatsheet-table, ² md-blocks group):
; helper selectors ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: (of List FEntity) => (of List FEntity)
        only_funcs_fentities
        [ fes]
        (lreject
            (fm (eq_any it.kind [ FEntityKind.NON_IMPORT_INFO
                                  FEntityKind.REQUIRE_MACRO  ]))
            fes))

    (def:: (of List FEntity) => (of List FEntity)
        only_macro_fentities
        [ fes]
        (lfilter
            (fm (eq it.kind FEntityKind.REQUIRE_MACRO))
            fes))

; _____________________________________________________________________________/ }}}1
; constructors ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: DFGroup => str
        dfgroup_to_short_table_line
        [ dfgroup]
        ;
        (setv column0 (sconcat dfgroup.name))
        (setv column1 (sconcat dfgroup.subname))
        ;
        (setv fentities dfgroup.fentities)
        (setv column2; functions
            (str_join :sep " "
                     (lmap fentity_to_hoverable (only_funcs_fentities fentities))))
        (setv column3; macros
            (str_join :sep " "
                     (lmap fentity_to_hoverable (only_macro_fentities fentities))))
        ;
        (return f"| {column0} | {column1} | {column2} | {column3} |"))

    ; helper
    (def:: FEntity => str
        fentity_to_hoverable
        [ fentity]
        (setv title fentity.name)
        (setv tooltip
            (cond
                (and (eq fentity.signature "") (eq fentity.descr ""))
                ""
                (eq fentity.signature "")
                fentity.descr
                (eq fentity.descr "")
                (sconcat ":: " fentity.signature " ::")
                True
                (sconcat ":: " fentity.signature " :: " fentity.descr)))
        (setv target_link
            (if (in fentity.name $ASCII_NAMES_TABLE)
                 (sconcat "#" (get $ASCII_NAMES_TABLE fentity.name 1))
                 (sconcat "#" fentity.name)))
        (return f"<span title=\"{tooltip}\">[`{title}`]({target_link})</span>"))

; _____________________________________________________________________________/ }}}1
; assembly ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: (of List DFGroup) => str
        generate_chsh_table
        [ dfgroups]
        (=>> dfgroups
            (lmap dfgroup_to_short_table_line)
            (str_join :sep "\n")
            (sconcat $SHORT_TABLE_HEADER "\n")))

; _____________________________________________________________________________/ }}}1
; MD blocks (each block consists of: ¹ ##title, ² short-card, ³ help-string):
; helpers ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: str => str
        capture_help
        [ function_name]
        (setv output (io.StringIO))
        (with [s (contextlib.redirect_stdout output)]
             (help function_name))
        (return (output.getvalue)))

; _____________________________________________________________________________/ }}}1
; constructors ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: FEntity => str
        fentity_to_md_title
        [ fentity]
        ;
        (setv title
            (if (in fentity.name $ASCII_NAMES_TABLE)
                 (sconcat "## " (get $ASCII_NAMES_TABLE fentity.name 0))
                 (sconcat "## " fentity.name)))
        ;
        (setv card (fentity2card fentity))
        ;
        (try
            (if (in fentity.name $SUPPRESS_HELP)
                 (setv help_string None)
                 (setv help_string (=> (globals) [fentity.name] capture_help strip)))
            (except [e Exception] (setv help_string None)))
        ;
        (if (noneQ help_string)
             (return f"{title}\n\n{$BACKLINK}\n\n```hy\n{card}\n```")
             (return f"{title}\n\n{$BACKLINK}\n\n```hy\n{card}\n```\n\n```hy\n{help_string}\n```")))

    (def:: FEntity => str
        fentity2card
        [ fe]
        (setv line1
            (if (eq fe.kind FEntityKind.IMPORT_FROM_MODULE_AS)
                 f"Name: {fe.name} (= {fe.parent_module}.{fe.org_name})"
                 f"Name: {fe.name}"))
        (setv line2
            (case fe.kind
                 FEntityKind.IMPORT_MODULE
                 "Kind: Full Module"
                 FEntityKind.NON_IMPORT_INFO
                 f"Kind: Info only | {fe.parent_module} | {fe.name} /{fe.kind_str}/"
                 ;
                 FEntityKind.IMPORT_FROM_MODULE
                 f"Kind: Reimport from [{fe.parent_module}]"
                 FEntityKind.IMPORT_FROM_MODULE_AS
                 f"Kind: Reimport"
                 FEntityKind.REQUIRE_MACRO
                 f"Kind: Macro from [{fe.parent_module}]"
                 FEntityKind.DEFINED_SETV
                 "Kind: FPMX original"
                 FEntityKind.DEFINED_FUNC
                 "Kind: FPMX original"))
        (setv tail (build_card_tail fe))
        (return (sconcat line1 "\n" line2 tail)))

    (def:: FEntity => str
        build_card_tail
        [ fentity]
        (cond
            (and (eq fentity.signature "") (eq fentity.descr ""))
            ""
            (eq fentity.signature "")
            (sconcat "\nInfo: " fentity.descr)
            (eq fentity.descr "")
            (sconcat "\nSgnt: " fentity.signature)
            True
            (sconcat "\nSgnt: " fentity.signature
                    "\nInfo: " fentity.descr)))

; _____________________________________________________________________________/ }}}1
; assembly ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (def:: (of List DFGroup) => str
        generate_md_blocks
        [ dfgroups]
        "fgroup.name(s) are not used"
        (=>> dfgroups
            (lpluckm .fentities)
            (flatten)
            (lreject (fm (eq it.kind FEntityKind.NON_IMPORT_INFO)))
            (lmap fentity_to_md_title)
            (str_join :sep "\n\n")))

; _____________________________________________________________________________/ }}}1

; Run:
; CONST STRs (for short table) ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $SHORT_TABLE_HEADER
         "
| Group | Subgroup | Functions/Types | Macros |
|-------|----------|-----------------|--------|")

    (setv $HEADER1 "fpmx-prelude-cheatsheet")
    (setv $HEADER2 "Detailed descriptions")
    (setv $BACKLINK f"[go up](#{$HEADER1})")

; _____________________________________________________________________________/ }}}1
; GLOB VARS  (for short table) ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; for this functions help-card will not be printed
    ; (like because for StrictNumber it will give help on Union, which is useless)
    (setv $SUPPRESS_HELP
        [ "listQ" "tupleQ" "setQ" "iteratorQ" "iterableQ" "number"])
            ; "StrictNumber" "validateF" "Result" "Maybe" "Nothing"

    ; typically function named 'partial' should be layed out in
    ; the doc under 'partial' header;
    ; but for macro '->' md-format of links fails, so need to
    ; use headers which md-format will be able to work with
    (setv $ASCII_NAMES_TABLE
        { ; md header         ; link
            "->" #("hyruleThreading1" "hyruleThreading1")
            "->>" #("hyruleThreading2" "hyruleThreading2")
            "as->" #("hyruleThreading3" "hyruleThreading3")
            "doto" #("hyruleThreading4" "hyruleThreading4")
            "=>" #("FPMXThreading1" "FPMXThreading1")
            "=>>" #("FPMXThreading2" "FPMXThreading2")
            "f>" #("LambdaWithAppl" "LambdaWithAppl")
            "p:" #("PipeOfPartials" "PipeOfPartials")
            "f::" #("Annotator1" "Annotator1")
            "def::" #("Annotator2" "Annotator2")})

; _____________________________________________________________________________/ }}}1
; RUN ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $SOURCE1 "../../src/fpmx/prelude/funcs.hy")
    (setv $SOURCE2 "../../src/fpmx/prelude/__init__macros.hy")
    (setv $TARGET_SHORT_FILE "../../docs/00_prelude_cheatsheet_table_view.md")
    (setv $TARGET_LONG_FILE "../../docs/01_prelude_cheatsheet_list_view.hy")
    (setv _code_funcs (read_file $SOURCE1))
    (setv _code_macros (read_file $SOURCE2))

    ; extract all data from code into DFGroups:
    (setv _dfgroups
        (unite_dfgroups; this is where sorting of group-names becomes alphabetical -> TODO: don't force this sorting
            (lconcat
                (=>> _code_funcs find_fgroups (lmap deconstruct_fgroup)); <- can also find macros among other things, yes
                (find_macros _code_macros "fpmx.prelude.from_hyrule"); \ <- searches for macros in big require statements
                (find_macros _code_macros "fpmx.prelude.macros")))); /

    ; perform some pretty renamings
    (setv _dfgroups
        (-> _dfgroups
           (l> (Each) .fentities (Each) .parent_module (Filter (partial eq "fpmx.prelude.from_hyrule")) (set "fpmx/hyrule"))
           (l> (Each) .fentities (Each) .parent_module (Filter (partial eq "fpmx.prelude.macros")) (set "fpmx"))))

    ; List of one-liners:
    (setv _oneliners_table (generate_long_table _dfgroups))
    (write_to_file f"\n{_oneliners_table}" $TARGET_LONG_FILE)

    ; MD-table:
    (setv _cheatsheet_table (generate_chsh_table _dfgroups))
    (setv _md_blocks (generate_md_blocks _dfgroups))
    (setv _mdtable_final f"# {$HEADER1}\n\n{_cheatsheet_table}\n\n# {$HEADER2}\n\n{_md_blocks}")
    (write_to_file _mdtable_final $TARGET_SHORT_FILE)

; _____________________________________________________________________________/ }}}1
