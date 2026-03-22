
    (import fpmx.prelude *) (require fpmx.prelude *)

    (import fpmx.strict.types [validateF BaseModel])
    (import pydantic [ConfigDict])

; Maybe: def test ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn test_maybe [Maybe Just Nothing justQ nothingQ fmapM bindM unwrapJ unwrapJ_or]
        ;
        (defn [validateF] #^ (of Maybe float)
            maybe_divide [#^ float x #^ float y]
            (if (neq y 0)
                 (return (Just (div x y)))
                 (return Nothing)))
        ;
        (defn [validateF] #^ (of Maybe float)
            maybe_divide_x_on_yz [#^ float x #^ float y #^ float z]
            (if (and (neq y 0) (neq z 0))
                 (return (Just (div (div x y) z)))
                 (return Nothing)))
        ;
        ; 1) Test factories and checksQ:
        (assertm eq (justQ (Just 3)) True)
        (assertm eq (justQ Nothing) False)
        (assertm gives_error_typeQ (justQ 3.0) TypeError)
        ;
        (assertm eq (nothingQ (Just 3)) False)
        (assertm eq (nothingQ Nothing) True)
        (assertm gives_error_typeQ (nothingQ 3) TypeError)
        ; Check if comparison (via =) works:
        (assertm eq (maybe_divide 1 2) (Just 0.5))
        (assertm eq (maybe_divide 1 0) Nothing)
        ; Test unwrappers:
        (assertm eq (-> (Just 3) (unwrapJ)) 3)
        ;
        (assertm eq (-> Nothing (unwrapJ_or 4)) 4)
        (assertm eq (-> (Just 3) (unwrapJ_or 4)) 3)
        ; Test lifts:
        (assertm eq (fmapM (Just 3) (partial plus 10)) (Just 13))
        (assertm eq (fmapM (Just 3) plus (Just 4)) (Just 7))
        (assertm eq (fmapM (Just 3) (partial plus 100) (Just 4) (Just 5)) (Just 112))
        ;
        (assertm eq (fmapM (Just 3) (partial plus 100) (Just 4) Nothing) Nothing)
        (assertm eq (fmapM Nothing (partial plus 100) (Just 4) (Just 5)) Nothing)
        ;
        (assertm gives_error_typeQ (fmapM (Just 2) plus 3) TypeError)
        (assertm gives_error_typeQ (fmapM (Just 2) plus (Just 2) 3) TypeError)
        ; Test binds:
        (assertm eq (bindM (Just 3) (pflip maybe_divide 3)) (Just 1))
        (assertm eq (bindM (Just 0) (pflip maybe_divide 0)) Nothing)
        (assertm eq (bindM (Just 3) maybe_divide (Just 3)) (Just 1))
        (assertm eq (bindM (Just 3) maybe_divide (Just 0)) Nothing)
        (assertm eq (bindM (Just 3) maybe_divide_x_on_yz (Just 3) (Just 1)) (Just 1))
        (assertm eq (bindM (Just 3) maybe_divide_x_on_yz (Just 3) (Just 0)) Nothing)
        (assertm eq (bindM (Just 3) maybe_divide_x_on_yz (Just 0) (Just 3)) Nothing)
        ;
        (assertm gives_error_typeQ (bindM (Just 2) maybe_divide 3) TypeError)
        (assertm gives_error_typeQ (bindM (Just 2) maybe_divide_x_on_yz (Just 2) 3) TypeError)
        (assertm gives_error_typeQ (bindM (Just 1) plus) TypeError)
        (assertm gives_error_typeQ (bindM (Just 1) plus (Just 1)) TypeError)
        (assertm gives_error_typeQ (bindM (Just 1) plus (Just 1) (Just 1)) TypeError)
        ; Test combos:
        (assertm eq
            (-> (Just 3)
                 (fmapM (partial plus 4)); 7
                 (fmapM plus (Just 5)); 12
                 (bindM maybe_divide_x_on_yz (Just 2) (Just 3)); 2
                 (unwrapJ_or "how"))
            2))

; _____________________________________________________________________________/ }}}1
; Maybe: run test ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import fpmx.monads.maybeM *)
    (test_maybe #* [Maybe Just Nothing justQ nothingQ fmapM bindM unwrapJ unwrapJ_or])
    ;
    (import fpmx.strict.maybeM *)
    (test_maybe #* [Maybe Just Nothing justQ nothingQ fmapM bindM unwrapJ unwrapJ_or])

; _____________________________________________________________________________/ }}}1

; Result: def test1 (older version) ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn test_result [ Result Success Failure successQ failureQ
                       fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ]
        ;
        (defn [validateF] #^ (of Result float str)
            safe_divide [#^ float x #^ float y]
            (if (neq y 0)
                 (return (Success (div x y)))
                 (return (Failure f"{x}/{y}, div by 0, bruh"))))
        ;
        (assertm eq (safe_divide 1 2) (Success 0.5))
        (assertm eq (safe_divide 1 0) (Failure f"1.0/0.0, div by 0, bruh"))
        (assertm eq (failureQ (safe_divide 1 2)) False)
        (assertm eq (failureQ (safe_divide 1 0)) True)
        (assertm eq (successQ (Success 3)) True)
        (assertm eq (successQ (Failure 3)) False)
        ; 10/(2.5*2) = 2
        (assertm eq
            (-> (Success 2.5) (fmapR (partial mul 2)) (fmapR (partial div 10)))
            (Success 2.0))
        ;
        (assertm eq
            (-> (safe_divide 1 0) (fmapR double) (fmapR (partial mul 7)))
            (Failure f"1.0/0.0, div by 0, bruh"))
        ;
        (assertm eq; (8/4)/4 = 0.5
            (-> (Success 8)
                 (bindR (pflip safe_divide 4))
                 (bindR (pflip safe_divide 4)))
            (Success 0.5))
        ;
        (setv x (Success 14))
        (setv y (Failure "pups_err"))
        (assertm eq (unwrapS x) 14)
        (assertm eq (unwrapF y) "pups_err")
        (assertm eq (unwrapF_or x "def_err") "def_err")
        (assertm eq (unwrapS_or y 0) 0))

; _____________________________________________________________________________/ }}}1
; Result: def test2 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn test_result2 [ Result Success Failure successQ failureQ
                       fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ]
        ;
        (setv err "some error")
        ;
        (defn [validateF] #^ (of Result float str)
            result_divide [#^ float x #^ float y]
            (if (neq y 0)
                 (return (Success (div x y)))
                 (return (Failure err))))
        ;
        (defn [validateF] #^ (of Result float str)
            result_divide_x_on_yz [#^ float x #^ float y #^ float z]
            (if (and (neq y 0) (neq z 0))
                 (return (Success (div (div x y) z)))
                 (return (Failure err))))
        ;
        ; 1) Test factories and checksQ:
        (assertm eq (successQ (Success 3)) True)
        (assertm eq (successQ (Failure err)) False)
        (assertm gives_error_typeQ (successQ 3.0) TypeError)
        ;
        (assertm eq (failureQ (Success 3)) False)
        (assertm eq (failureQ (Failure err)) True)
        (assertm gives_error_typeQ (failureQ 3) TypeError)
        ; Check if comparison (via =) works:
        (assertm eq (result_divide 1 2) (Success 0.5))
        (assertm eq (result_divide 1 0) (Failure err))
        ; Test unwrappers:
        (assertm eq (-> (Success 3)   (unwrapS)) 3)
        (assertm eq (-> (Failure err) (unwrapS_or 4)) 4)
        (assertm eq (-> (Success 3)   (unwrapS_or 4)) 3)
        ;
        (assertm eq (-> (Failure err) (unwrapF)) err)
        (assertm eq (-> (Success 1)   (unwrapF_or 4)) 4)
        (assertm eq (-> (Failure err) (unwrapF_or 4)) err)
        ; Test lifts:
        (assertm eq (-> (Success 3) (fmapR (partial plus 10))) (Success 13))
        (assertm eq (-> (Success 3) (fmapR plus (Success 4))) (Success 7))
        (assertm eq (-> (Success 3) (fmapR (partial plus 100) (Success 4) (Success 5))) (Success 112))
        ;
        (assertm eq (-> (Success 3) (fmapR (partial plus 100) (Success 4) (Failure 1))) (Failure 1))
        (assertm eq (-> (Failure 1) (fmapR (partial plus 100) (Failure 4) (Failure 5))) (Failure 1))
        ;
        (assertm gives_error_typeQ (-> (Success 2) (fmapR plus 3)) TypeError)
        (assertm gives_error_typeQ (-> (Success 2) (fmapR plus (Success 2) 3)) TypeError)
        ; Test binds:
        (assertm eq (-> (Success 3) (bindR (pflip result_divide 3))) (Success 1))
        (assertm eq (-> (Success 0) (bindR (pflip result_divide 0))) (Failure err))
        (assertm eq (-> (Success 3) (bindR result_divide (Success 3))) (Success 1))
        (assertm eq (-> (Success 3) (bindR result_divide (Success 0))) (Failure err))
        (assertm eq (-> (Success 3) (bindR result_divide_x_on_yz (Success 3) (Success 1))) (Success 1))
        (assertm eq (-> (Success 3) (bindR result_divide_x_on_yz (Success 3) (Success 0))) (Failure err))
        (assertm eq (-> (Success 3) (bindR result_divide_x_on_yz (Success 0) (Success 3))) (Failure err))
        ;
        (assertm gives_error_typeQ (-> (Success 2) (bindR result_divide 3)) TypeError)
        (assertm gives_error_typeQ (-> (Success 2) (bindR result_divide_x_on_yz (Success 2) 3)) TypeError)
        (assertm gives_error_typeQ (-> (Success 1) (bindR plus)) TypeError)
        (assertm gives_error_typeQ (-> (Success 1) (bindR plus (Success 1))) TypeError)
        (assertm gives_error_typeQ (-> (Success 1) (bindR plus (Success 1) (Success 1))) TypeError)
        ; Test combos:
        (assertm eq
            (-> (Success 3)
                 (fmapR (partial plus 4)); 7
                 (fmapR plus (Success 5)); 12
                 (bindR result_divide_x_on_yz (Success 2) (Success 3)); 2
                 (unwrapS_or "how"))
            2))

; _____________________________________________________________________________/ }}}1
; Result: run test ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import fpmx.monads.resultM *)
    (test_result #* [ Result Success Failure successQ failureQ
                        fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ])
    (test_result2 #* [ Result Success Failure successQ failureQ
                       fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ])

    (import fpmx.strict.resultM *)
    (test_result #* [ Result Success Failure successQ failureQ
                       fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ])
    (test_result2 #* [ Result Success Failure successQ failureQ
                       fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ])

    ; Continuing FOR STRICT RESULT ONLY (they are currently loaded):

    (defclass AppError [BaseModel]
        #^ int n
        #^ Exception e
        (setv model_config (ConfigDict :arbitrary_types_allowed True))
        (defn __init__ [self #^ int n #^ Exception e]
            (-> (super) (.__init__ :n n :e e)))
        (defn __str__ [self] (sconcat "<Error" (str self.n) ": " (str self.e) ">"))
        (defn __repr__ [self] (self.__str__)))

    (defn [validateF] #^ (of Result float AppError)
        safe_divide2 [x y]
        (if (neq y 0)
             (return (Success (div x y )))
             (return (Failure (AppError 1 (ValueError f"{x}/{y} is dividing over 0, wtf" ))))))

    (assertm eq (safe_divide2 1 2) (Success 0.5))

    (assertm eq
        (failureQ (safe_divide2 1 0))
        True)

; _____________________________________________________________________________/ }}}1

; WriterMaybe: def test ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn test_mw [ WriterMaybe WJust WNothing wJustQ wNothingQ
                       fmapWM bindWM askWM tellWM unwrapWJ unwrapWJ_or ]
        ;
        (setv msg2 "x*2")
        (defn [validateF] doubleMW [x] (return (WJust (* x 2) [msg2] )))
        ;
        (setv msgXY "x/y")
        (setv msgXYn "noth")
        (defn [validateF] #^ (of WriterMaybe float str)
            mw_divide [#^ float x #^ float y]
            (if (neq y 0)
                 (return (WJust (div x y) [msgXY]))
                 (return (WNothing [msgXYn]))))
        ;
        (setv msgXYZ "x/y/z")
        (setv msgXYZn "noth_")
        (defn [validateF] #^ (of WriterMaybe float str)
            mw_divide_x_on_yz [#^ float x #^ float y #^ float z]
            (if (and (neq y 0) (neq z 0))
                 (return (WJust (div (div x y) z) [msgXYZ]))
                 (return (WNothing [msgXYZn]))))
        ; 0) Test Writer-Specific
        (assertm eq (-> (WJust 3  ["1"]) (tellWM ["2"]) (askWM)) ["1" "2"])
        (assertm eq (-> (WNothing ["1"]) (tellWM ["2"]) (askWM)) ["1"])
        ;
        ; 1) Test factories and checksQ:
        (assertm eq (wJustQ (WJust 3 ["3"])) True)
        (assertm eq (wJustQ (WNothing [])) False)
        (assertm gives_error_typeQ (wJustQ 3.0) TypeError)
        (assertm eq (wNothingQ (WJust 3 ["3"])) False)
        (assertm eq (wNothingQ (WNothing [])) True)
        (assertm gives_error_typeQ (wJustQ 3.0) TypeError)
        ; Check if comparison (via =) works:
        (assertm eq (doubleMW 2) (WJust 4 [msg2]))
        ; Test unwrappers:
        (assertm eq (-> (WJust 3 ["1"]) (unwrapWJ))
                   #(3 ["1"]))
        (assertm gives_error_typeQ (-> (WNothing ["1"]) (unwrapWJ)) TypeError)
        (assertm eq (-> (WNothing ["1"]) (unwrapWJ_or 2))
                   #(2 ["1"]))
        ; Test lifts:
        (assertm eq
            (-> (WJust 3 ["riba"])
                 (fmapWM (partial plus 10)))
            (WJust 13 ["riba"]))
        ;
        (assertm eq
            (-> (WJust 3 ["riba"])
                 (fmapWM plus (WJust 4 ["ololo"]) (WJust 5 ["ololo2"])))
            (WJust 12 ["riba" "ololo" "ololo2"]))
        ;
        (assertm eq (-> (WJust 3  ["1"]) (fmapWM (partial plus 100) (WNothing ["2"]))) (WNothing ["1" "2"]))
        (assertm eq (-> (WNothing ["1"]) (fmapWM (partial plus 100) (WNothing ["2"]))) (WNothing ["1"]))
        ;
        (assertm gives_error_typeQ (-> (WJust 2 []) (fmapWM plus 3)) TypeError)
        (assertm gives_error_typeQ (-> (WJust 2 []) (fmapWM plus (WJust 2 []) 3)) TypeError)
        ; Test binds:
        (assertm eq (-> (WJust 3 ["1"]) (bindWM (pflip mw_divide 3))) (WJust 1 ["1" msgXY]))
        (assertm eq (-> (WJust 0 ["1"]) (bindWM (pflip mw_divide 0))) (WNothing ["1" msgXYn]))
        (assertm eq (-> (WJust 0 ["1"]) (bindWM (pflip mw_divide 0)) (bindWM (pflip mw_divide 0))) (WNothing ["1" msgXYn]))
        (assertm eq (-> (WJust 3 ["1"]) (bindWM mw_divide (WJust 3 ["2"]))) (WJust 1 ["1" "2" msgXY]))
        (assertm eq (-> (WJust 3 ["1"]) (bindWM mw_divide (WJust 0 ["2"]))) (WNothing ["1" "2" msgXYn]))
        (assertm eq (-> (WJust 3 ["1"]) (bindWM mw_divide (WJust 0 ["2"])) ) (WNothing ["1" "2" msgXYn]))
        (assertm eq (-> (WJust 3 ["1"]) (bindWM mw_divide_x_on_yz (WJust 3 ["2"]) (WJust 1 ["3"]))) (WJust 1  ["1" "2" "3" msgXYZ]))
        (assertm eq (-> (WJust 3 ["1"]) (bindWM mw_divide_x_on_yz (WJust 3 ["2"]) (WJust 0 ["3"]))) (WNothing ["1" "2" "3" msgXYZn]))
        (assertm eq (-> (WJust 3 ["1"]) (bindWM mw_divide_x_on_yz (WJust 0 ["2"]) (WJust 3 ["3"]))) (WNothing ["1" "2" "3" msgXYZn]))
        ;
        (assertm gives_error_typeQ (-> (WJust 2 []) (bindWM mw_divide 3)) TypeError)
        (assertm gives_error_typeQ (-> (WJust 2 []) (bindWM mw_divide_x_on_yz (WJust 2 []) 3)) TypeError)
        (assertm gives_error_typeQ (-> (WJust 1 []) (bindWM plus)) TypeError)
        (assertm gives_error_typeQ (-> (WJust 1 []) (bindWM plus (WJust 1 []))) TypeError)
        (assertm gives_error_typeQ (-> (WJust 1 []) (bindWM plus (WJust 1 []) (WJust 1 []))) TypeError)
        ; Test combos:
        (assertm eq
            (-> (WJust 3 ["1"])
                 (fmapWM (partial plus 4)); 7
                 (fmapWM plus (WJust 5 [])); 12
                 (bindWM mw_divide_x_on_yz (WJust 2 ["2"]) (WJust 3 ["3"])); 2
                 (unwrapWJ_or "how")
                 (first))
            2))

; _____________________________________________________________________________/ }}}1
; WriterMaybe: run test ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import fpmx.monads.writerMaybeT *)
    (test_mw #* [ WriterMaybe WJust WNothing wJustQ wNothingQ
                       fmapWM bindWM askWM tellWM unwrapWJ unwrapWJ_or ])

    (import fpmx.strict.writerMaybeT *)
    (test_mw #* [ WriterMaybe WJust WNothing wJustQ wNothingQ
                       fmapWM bindWM askWM tellWM unwrapWJ unwrapWJ_or ])

; _____________________________________________________________________________/ }}}1
