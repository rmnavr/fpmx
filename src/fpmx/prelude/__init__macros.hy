
    (require fpmx.prelude.from_hyrule [
        of                  #_ "[GROUP] 50 Typing: all              | | example: (of List int) which is equiv to py-code: List[int]"
        comment             #_ "[GROUP] 93 Misc: misc               | |"
        ncut                #_ "[GROUP] 40 Getters: basic           | |"
        case                #_ "[GROUP] 70 FP: control flow         | |"
        unless              #_ "[GROUP] 70 FP: control flow         | |"
        lif                 #_ "[GROUP] 70 FP: control flow         | |"
        branch              #_ "[GROUP] 70 FP: control flow         | |"
        do_n                #_ "[GROUP] 73 FP: function composition | (do_n   n #* body) -> None | expands to ~ (do body body body ...)"
        list_n              #_ "[GROUP] 73 FP: function composition | (list_n n #* body) -> List |"
        ->                  #_ "[GROUP] 73 FP: function composition | |"
        ->>                 #_ "[GROUP] 73 FP: function composition | |"
        as->                #_ "[GROUP] 73 FP: function composition | |"
        doto                #_ "[GROUP] 73 FP: function composition | | mutating"
    ])

    (require fpmx.prelude.macros [
        def::               #_ "[GROUP] 50 Typing: all              | | example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]"
        f::                 #_ "[GROUP] 50 Typing: all              | | define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))"
        fm                  #_ "[GROUP] 71 FP: lambdas              | (fm (* it 3)) | anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'"
        f>                  #_ "[GROUP] 71 FP: lambdas              | (f> (* it 3) 4) | anonymous function with fm syntax, immediately applicates args"
        mapm                #_ "[GROUP] 71 FP: lambdas              | | same as map, but expects fm-syntax for func"
        lmapm               #_ "[GROUP] 71 FP: lambdas              | | same as lmap, but expects fm-syntax for func"
        filterm             #_ "[GROUP] 71 FP: lambdas              | (filterm f xs)  | same as filter, but expects fm-syntax for func"
        lfilterm            #_ "[GROUP] 71 FP: lambdas              | (lfilterm f xs) | list version of lfilterm"
        =>                  #_ "[GROUP] 73 FP: function composition | | unification of dot-macro and ->"
        =>>                 #_ "[GROUP] 73 FP: function composition | | unification of dot-macro and ->>"
        p:                  #_ "[GROUP] 73 FP: function composition | | aplicator, pipe of partials"
        pluckm              #_ "[GROUP] 42 Getters: attrs and bulk  | (pluckm n xs) (pluckm key ys) (pluckm .attr zs) | accepts fpmx-style .arg syntax"
        lpluckm             #_ "[GROUP] 42 Getters: attrs and bulk  | | list version of pluckm"
        getattrm            #_ "[GROUP] 42 Getters: attrs and bulk  | (getattrm Object 'attr') (getattrm Object .attr) | accepts fpmx-style .attr syntax"
        timing              #_ "[GROUP] 91 Misc: benchmarking       | (timing expr1 expr2 ...) -> #(float, Any) | returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)"
        assertm             #_ "[GROUP] 92 Misc: testing            | (assertm op arg1 arg2) | tests if (op arg1 arg2), for example (= 1 1)"
        gives_error_typeQ   #_ "[GROUP] 92 Misc: testing            | | example: (assertm gives_error_typeQ (get [1] 2) IndexError)"
     ])

     ; lns macros are defined in macros.hy, yes, but not imported into prelude

