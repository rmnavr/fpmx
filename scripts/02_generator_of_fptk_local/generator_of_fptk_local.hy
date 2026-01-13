
    (import  _fptk_local *)
    (require _fptk_local *)
    (import  os)
    (import  shutil)
    (import  send2trash [send2trash])

    (import  termcolor [colored])
    (defn clrz [text] (colored text "blue" None))

; [F] get version in setup.py ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ str
        extract_version
        [ #^ str version_header
          #^ str file_content
        ]
        (re_find (sconcat version_header r"\s*=\s*'(.*?)'")
                 file_content
                 re.DOTALL))

; _____________________________________________________________________________/ }}}1
; [F] generate readme content ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ str
        generate_readme_content
        [ #^ str version
        ]
        (sconcat "\n" "This is local version of github.com/rmnavr/fptk lib.\n"
                      "\n"
                      "Purpose of local version is to have stable fptk \n"
                      "inside other projects until fptk reaches stable relsease.\n"
                      "\n"
                      "This file was generated from local git version: " version
                      "\n"))

; _____________________________________________________________________________/ }}}1
; [F] patch inner imports ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ None
        rewrite_file_with_new_lib_name
        [ #^ str filename ;  'maybeM.hy'
          #^ str old      ; r'fptk'
          #^ str new      ;  '_fptk_local'
        ]
        "replaces 'fptk' everywhere to '_fptk_local', old should be regexed strings"
        (setv content_org (read_file filename))
        (setv content_new (re_sub old new content_org))
        (write_file content_new filename))

; _____________________________________________________________________________/ }}}1

; [F] CONFIG ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $SETUP_PY             "../../setup.py")
    (setv $SETUP_VERSION_HEADER "proj_version")

    (setv $SOURCE_FOLDER        "../../src/fptk")
    (setv $LOCALS_FOLDER        "../../_etc/local_versions")

    ; v.1 = Normal:
    (setv $LOCAL_FOLDER_NAME    "fptk_local")
    (setv $REPLACEMENTS         [ [r"fptk\."       "fptk_local."]
                                  [r"hy\.R\.fptk/" "hy.R.fptk_local/"]
                                ])

    ; v.2 = For wy:
    ; (setv $LOCAL_FOLDER_NAME    "wy.utils.fptk_local")
    ; (setv $REPLACEMENTS         [ [r"fptk\."       "wy.utils.fptk_local."]
    ;                               [r"hy\.R\.fptk/" "hy.R.wy/utils/fptk_local/"]
    ;                             ])

    ; those files will be also patched with replacements
    (setv $FILES_TO_COPY        [ "__init__.py"
                                  "lenses.hy"
                                  "loader.hy"
                                  "core/__init__.py"
                                  "core/__init__macros.hy"
                                  "core/funcs.hy"
                                  "core/from_hyrule.hy"
                                  "core/macros.hy"
                                  "monads/maybeM.hy"
                                  "monads/resultM.hy"
                                  "strict/types.hy"
                                  "strict/maybeM.hy"
                                  "strict/resultM.hy"
                                ])

; _____________________________________________________________________________/ }}}1

    (setv _fptk_version   (extract_version $SETUP_VERSION_HEADER (read_file $SETUP_PY)))
    (setv _target_folder  (sconcat $LOCALS_FOLDER "/" _fptk_version "/" $LOCAL_FOLDER_NAME))

    (setv _sources (lmapm (sconcat $SOURCE_FOLDER "/" it) $FILES_TO_COPY))
    (setv _targets (lmapm (sconcat _target_folder "/" it) $FILES_TO_COPY))
    (setv _source_target_files_pairs (zip _sources _targets))

    (setv _target_readme  (sconcat _target_folder "/README.md"))
    (setv _readme_content (generate_readme_content _fptk_version))

    ; remove local_version_v0.5.0 or smth if exists already (in case this script reruns)
    (when (os.path.exists _target_folder)
          (send2trash _target_folder)
          (print f"-- folder removed : {(clrz _target_folder)}"))

    (try ; ✠ make dirs
         (lmapm (os.makedirs (os.path.dirname it) :exist_ok True) _targets)
         (print f"-- created required subdirs in target folder")
         ; ✠ write readme file for local:
         (write_file _readme_content _target_readme)
         (print f"-- readme file written     : {(clrz _target_readme)}")
         ; ✠ copy and patch files:
         (for [[source target] _source_target_files_pairs]
              (shutil.copy2 source target)
              (rewrite_file_with_new_lib_name target #* (first  $REPLACEMENTS)) ; fptk.
              (rewrite_file_with_new_lib_name target #* (second $REPLACEMENTS)) ; hy.R.fptk/
              (print f"-- copied and patched file : {(clrz target)}"))
         ;
         (except [e Exception] (print e)))

