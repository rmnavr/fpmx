
    (import fptk.core *) (require fptk.core *)
    (import pydantic [ConfigDict])

    ; non-strict:
    (import fptk.monads.resultM *)
    (import fptk.monads.maybeM *)

    ; strict:
    (import fptk.strict.types *)
    ; import fptk.strict.resultM *
    ; import fptk.strict.maybeM *

; Maybe: basics ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (assertm eq (justQ (Just 3)) True)
    (assertm eq (justQ Nothing ) False)
    (assertm eq (nothingQ (Just 3)) False)
    (assertm eq (nothingQ Nothing ) True)

    (assertm eq (unwrapJ (Just 3)) 3)
    (assertm eq (unwrapJ_or Nothing 4) 4)

    ; 10/(2.5*2) = 2.0
    (assertm eq
        (mapM (Just 2.5) (partial mul 2) (partial div 10))
        (Just 2.0))

    (defn [validateF] #^ (of Maybe float)
        maybe_divide [#^ float x #^ float y]
        (if (neq y 0)
             (return (Just (div x y)))
             (return Nothing)))

    (assertm eq (maybe_divide 1 2) (Just 0.5))
    (assertm eq (maybe_divide 1 0) Nothing)

; _____________________________________________________________________________/ }}}1
; Result: basics ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn [validateF] #^ (of Result float str)
        safe_divide [#^ float x #^ float y]
        (if (neq y 0)
             (return (Success (div x y)))
             (return (Failure f"{x}/{y}, div by 0, bruh"))))

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

    (assertm eq
        (mapR (safe_divide 1 0) double (partial mul 7))
        (Failure f"1.0/0.0, div by 0, bruh"))

    (assertm gives_error_typeQ (mapR 3 double (partial mul 7)) TypeError)

    (assertm eq; (8/4)/4 = 0.5
        (bindR (Success 8) (pflip safe_divide 4) (pflip safe_divide 4))
        (Success 0.5))

    (setv x (Success 14))
    (setv y (Failure "pups_err"))
    (assertm eq (unwrapS x) 14)
    (assertm eq (unwrapF y) "pups_err")
    (assertm eq (unwrapF_or x "def_err") "def_err")
    (assertm eq (unwrapS_or y 0) 0)

; _____________________________________________________________________________/ }}}1
; Result: typing ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

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

