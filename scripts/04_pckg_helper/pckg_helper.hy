    
    (import  os)
    (import  subprocess)
    (import _fptk_local *)
    (require _fptk_local *)

; [F] run shell command ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn run_shell_command
        [ #^ str  command
          #^ bool [printQ True]
        ]
        (setv result
              (subprocess.run command
                              :shell          True
                              :check          True
                              :text           True
                              :capture_output True))
        (when printQ
            (print result.stdout)
            (print result.stderr)))

; _____________________________________________________________________________/ }}}1
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

; util: color ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; 7 = inverse, 4 = underline, 1 = bold
    (defn colorize [n string] (sconcat "[" (str n) "m" string "[0m"))

; _____________________________________________________________________________/ }}}1
; [F] Run tests ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; && chains cmd commands (2nd is run only if 1st was successful)

    (defn run_test [file]
        (try (run_shell_command (sconcat "cd " $FPMX_TESTS_DIR " && " $HYCMD " " file))
             (print (colorize 4 (sconcat "Test " file " - finished")))
             (except [Exception]
                     (print "ERROR: failed trying to run test:" file)
                     (sys.exit 1))))

; _____________________________________________________________________________/ }}}1
; Write version marker ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn write_version_marker []
        (setv found_prev (lfilter (fm (re_test $TIMESTAMP it))
                                  (os.listdir $FPMX_DIR)))
        (setv found_prev (lmap (partial sconcat $FPMX_DIR "/") found_prev))
        (when (fnot zerolenQ found_prev)
              (print (colorize 4 "found prev:") found_prev)
              (lmap os.remove found_prev))

        (setv version (extract_version $VERSION_HEADER (read_file $SETUP_PY)))
        (setv filename (sconcat $FPMX_DIR "/" $TIMESTAMP version))
        (print (colorize 4 "writing new:") filename)
        (write_file "" filename))

; _____________________________________________________________________________/ }}}1

; CONFIG ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $HYCMD            "hy")
    (setv $FPMX_DIR         "../../src/fpmx")

    (setv $VERSION_HEADER   "proj_version")
    (setv $SETUP_PY         "../../setup.py")
    (setv $TIMESTAMP        "_fpmx_ver_")

    (setv $FPMX_TESTS_DIR   "../../tests")
    (setv $FPMX_TESTS       [ "test_macros_import.hy"
                              "test_main.hy"
                              "test_monads.hy"
                              "test_term.hy"])

    (setv $DOCGEN_DIR       "../01_doc_generator")
    (setv $DOCGEN           "doc_generator.hy")

    (setv $FPMXLOCAL_DIR    "../02_generator_of_fpmx_local")
    (setv $FPMXLOCAL        "generator_of_fpmx_local.hy")

    (setv $NSMG_DIR         "../03_non_strict_monads_codegen")
    (setv $NSMG             "nsmg.hy")

; _____________________________________________________________________________/ }}}1
    
    (print "")
    (print "Version found in setup.py:" (colorize 4 (extract_version $VERSION_HEADER (read_file $SETUP_PY))))
    (print "")

    ; STEP 1 (monad codegen, requires `wy` in cmd)

        (print (colorize 7 "[Step 1/4] Generating non-strict monads code (NSMG):"))
        (try (run_shell_command f"cd {$NSMG_DIR} && {$HYCMD} {$NSMG}")
             (print (colorize 4 "NSMG - finished"))
             (except [Exception] (print "ERROR: failed trying to run NSMG")
                                 (sys.exit 1)))

    ; STEP 2 (tests)

        (print (colorize 7 "[Step 2/4] Running tests:"))
        (lmap run_test $FPMX_TESTS) 

    ; STEP 3 (docgen)

        (print "")
        (print (colorize 7 "[Step 3/4] Doc generation for functions:"))

        (try (run_shell_command f"cd {$DOCGEN_DIR} && {$HYCMD} {$DOCGEN}")
             (print (colorize 4 "Docgen - finished"))
             (except [Exception] (print "ERROR: failed trying to run docgen")
                                 (sys.exit 1)))

    ; STEP 4 (fpmx local)

        (print "")
        (print (colorize 7 "[Step 4/4] Generating fpmx_local:"))

        (try (run_shell_command f"cd {$FPMXLOCAL_DIR} && {$HYCMD} {$FPMXLOCAL}")
             (print (colorize 4 "Generating _fpmx_local - finished"))
             (except [Exception] (print "ERROR: failed trying to generate _fpmx_local")
                                 (sys.exit 1)))

    ; STEP4 (adding version marker)
    ;   (print "")
    ;   (print (colorize 7 "[Step 4/4] Generating version marker file in fpmx dir (and removing previous)"))
    ;   (write_version_marker)

