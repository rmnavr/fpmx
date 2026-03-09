
    (import fpmx.prelude *) (require fpmx.prelude *)

    (import fpmx.strict.types [validateF BaseModel])
    (import pydantic [ConfigDict])

; Maybe ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn test_maybe [Maybe Just Nothing justQ nothingQ liftM liftM2 liftM3 bindM bindM2 bindM3 unwrapJ unwrapJ_or]
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
        (assertm eq (unwrapJ (Just 3)) 3)
        (assertm gives_error_typeQ (unwrapJ 3) TypeError)
        (assertm gives_error_typeQ (unwrapJ Nothing) TypeError)
        ;
        (assertm eq (unwrapJ_or Nothing 4) 4)
        (assertm eq (unwrapJ_or (Just 3) 4) 3)
        (assertm gives_error_typeQ (unwrapJ_or 3 4) TypeError)
        ; Test lifts:
        (assertm eq (liftM  (Just 3) (partial plus 10)) (Just 13))
        (assertm eq (liftM2 (Just 3) (Just 4) plus) (Just 7))
        (assertm eq (liftM3 (Just 3) (Just 4) (Just 5) (partial plus 100)) (Just 112))
        ;
        (assertm gives_error_typeQ (liftM 3 plus) TypeError)
        (assertm gives_error_typeQ (liftM2 (Just 2) 3 plus) TypeError)
        (assertm gives_error_typeQ (liftM3 (Just 2) (Just 2) 3 plus) TypeError)
        ; Test binds:
        (assertm eq (bindM  (Just 3) (pflip maybe_divide 3)) (Just 1))
        (assertm eq (bindM  (Just 0) (pflip maybe_divide 0)) Nothing)
        (assertm eq (bindM2 (Just 3) (Just 3) maybe_divide) (Just 1))
        (assertm eq (bindM2 (Just 3) (Just 0) maybe_divide) Nothing)
        (assertm eq (bindM3 (Just 3) (Just 3) (Just 1) maybe_divide_x_on_yz) (Just 1))
        (assertm eq (bindM3 (Just 3) (Just 3) (Just 0) maybe_divide_x_on_yz) Nothing)
        (assertm eq (bindM3 (Just 3) (Just 0) (Just 3) maybe_divide_x_on_yz) Nothing)
        ;
        (assertm gives_error_typeQ (bindM 3 (pflip maybe_divide 3)) TypeError)
        (assertm gives_error_typeQ (bindM2 (Just 2) 3 maybe_divide) TypeError)
        (assertm gives_error_typeQ (bindM3 (Just 2) (Just 2) 3 maybe_divide_x_on_yz) TypeError)
        (assertm gives_error_typeQ (bindM  (Just 1) plus) TypeError)
        (assertm gives_error_typeQ (bindM2 (Just 1) (Just 1) plus) TypeError)
        (assertm gives_error_typeQ (bindM3 (Just 1) (Just 1) (Just 1) plus) TypeError)
        ; Test combos:
        (assertm eq
            (-> (Just 3)
                 (liftM (partial plus 4)); 7
                 (liftM2 (Just 5) plus); 12
                 (bindM3 (Just 2) (Just 3) maybe_divide_x_on_yz)
                 (unwrapJ_or "how"))
            2))

    ; ==============================================================

    (import fpmx.monads.maybeM *)
    (test_maybe #* [Maybe Just Nothing justQ nothingQ liftM liftM2 liftM3 bindM bindM2 bindM3 unwrapJ unwrapJ_or])


; _____________________________________________________________________________/ }}}1
; Result ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn test_result [Success Failure Result successQ failureQ mapR bindR unwrapR unwrapS unwrapS_or unwrapF unwrapF_or]
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
            (mapR (Success 2.5) (partial mul 2) (partial div 10))
            (Success 2.0))
        ;
        (assertm eq
            (mapR (safe_divide 1 0) double (partial mul 7))
            (Failure f"1.0/0.0, div by 0, bruh"))
        ;
        (assertm gives_error_typeQ (mapR 3 double (partial mul 7)) TypeError)
        ;
        (assertm eq; (8/4)/4 = 0.5
            (bindR (Success 8) (pflip safe_divide 4) (pflip safe_divide 4))
            (Success 0.5))
        ;
        (setv x (Success 14))
        (setv y (Failure "pups_err"))
        (assertm eq (unwrapS x) 14)
        (assertm eq (unwrapF y) "pups_err")
        (assertm eq (unwrapF_or x "def_err") "def_err")
        (assertm eq (unwrapS_or y 0) 0))

    ; ==============================================================

    (import fpmx.monads.resultM *)
    (test_result #* [Success Failure Result successQ failureQ mapR bindR unwrapR unwrapS unwrapS_or unwrapF unwrapF_or])

    (import fpmx.strict.resultM *)
    (test_result #* [Success Failure Result successQ failureQ mapR bindR unwrapR unwrapS unwrapS_or unwrapF unwrapF_or])

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


