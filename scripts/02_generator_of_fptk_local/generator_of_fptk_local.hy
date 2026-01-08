
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
                      "inside other projects until fptk reaches stable version.\n"
                      "\n"
                      "This file was generated from local git version: " version
                      "\n"))

; _____________________________________________________________________________/ }}}1
; [F] patch inner imports ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ None
        rewrite_file_with_new_lib_name
        [ #^ str filename ; 'maybeM.hy'
          #^ str old      ; 'fptk'
          #^ str new      ; '_fptk_local'
        ] 
        "replaces 'fptk' everywhere to '_fptk_local'"
        (setv content_org (read_file filename))
        (setv content_new (re_sub old new content_org))
        (write_file content_new filename))


; _____________________________________________________________________________/ }}}1

; [F] CONFIG ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $SETUP_PY             "../../setup.py")
    (setv $SETUP_VERSION_HEADER "proj_version")

    ; 1) text "fptk" inside local .hy files will be replaced with "_fptk_local"
    ; 2) whole local version folder will also be named "/_fptk_local"
    (setv $REPLACEMENT          ["fptk" "_fptk_local"]) 

    ; files to patch with $REPLACEMENT (in local fptk, not in fptk, obviously)
    (setv $FILES_TO_PATCH       [ "__init__.py"
                                  "lenses.hy"
                                  "strict.hy"
                                  "core/from_hyrule.hy"
                                  "core/funcs.hy"
                                  "core/macros.hy"
                                  "_wy_source/monads/maybeM.wy"
                                  "_wy_source/monads/resultM.wy"
                                  "monads/__init__.py"
                                  "monads/maybeM.hy"
                                  "monads/resultM.hy"
                                ])

    (setv $SOURCE_FOLDER        "../../src/fptk")
    (setv $LOCALS_FOLDER        "../../_etc/local_versions")

    ; folders that are removed in local_version after copy:
    (setv $SUBFOLDERS_TO_REMOVE [ "__pycache__"
                                  "core/__pycache__"
                                  "monads/__pycache__"
                                ])  


; _____________________________________________________________________________/ }}}1

    (setv _fptk_version  (extract_version $SETUP_VERSION_HEADER (read_file $SETUP_PY)))
    (setv _target_folder (sconcat $LOCALS_FOLDER "/" _fptk_version "/" (second $REPLACEMENT)))
    (setv _target_folders_to_remove (lmap (partial sconcat _target_folder "/") $SUBFOLDERS_TO_REMOVE))
    (setv _target_files_to_patch    (lmap (partial sconcat _target_folder "/") $FILES_TO_PATCH))

    (setv _target_readme  (sconcat _target_folder "/README.md"))
    (setv _readme_content (generate_readme_content _fptk_version))

    (print "\n1) working on folders, writing README:")
    ; remove local_version_v0.5.0 or smth if exists already (in case this script reruns)
    (when (os.path.exists _target_folder)
          (send2trash _target_folder)
          (print f"-- folder removed : {(clrz _target_folder)}"))

    (try ; 1) copy whole fptk lib:
         (shutil.copytree $SOURCE_FOLDER _target_folder)
         (print f"-- copy done      : {(clrz $SOURCE_FOLDER)} -> {(clrz _target_folder)}")
         ; 2) write readme file for local:
         (write_file _readme_content _target_readme)
         (print f"-- file written   : {(clrz _target_readme)}")
         ; 3) remove __pycache__ folders and such:
         (for [fldr _target_folders_to_remove]
              (when (os.path.exists fldr)
                    (print f"-- removing folder: {(clrz fldr)}")
                    (send2trash fldr)))
         ; 4) patch 'fptk' to '_fptk_local' inside files:
         (print f"\n2) patching files with {(clrz (first $REPLACEMENT))} -> {(clrz (second $REPLACEMENT))}:")
         (for [file _target_files_to_patch]
              (rewrite_file_with_new_lib_name file (first $REPLACEMENT) (second $REPLACEMENT))
              (print f"-- patched file   : {(clrz file)}"))
         ;
         (except [e Exception] (print e)))


