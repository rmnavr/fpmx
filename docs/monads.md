
# fptk monads

fptk implements monad types:
* [Maybe](#Maybe)
* [Result](#Result)

They are implemented in two variants with the same interface and namings:
- *normal* 
- *strict* — compatible with pydantic typecheck (thus importing monads also imports pydantic)

The reason both variants exist is due to pydantic requiring extra time to load (~150 ms on my machine).

Import statement:
```hy
; normal:
(import fptk.monads.maybeM *)  ; or load only what is required
(import fptk.monads.resultM *) ; or load only what is required

; strict:
(import fptk.strict.maybeM *)  ; or load only what is required
(import fptk.strict.resultM *) ; or load only what is required
```

<!-- Maybe ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Maybe

Module `fptk.monads.maybeM` (or `fptk.strict.maybeM`) exposes objects:
* class: `Maybe`
* factory functions: `Just`, `Nothing`
* functions: `justQ`, `nothingQ`, `mapM`, `bindM`, `unwrapM`, `unwrapM_or`

Notice that `Just` and `Nothing` are functions, not classes.
Real just/nothing implementation is intentionally hidden from user.

User API:
```hy
; check if object r is of Maybe type
(= (type r) Maybe)
(isinstance r Maybe)

; use Maybe in annotations:
(defn f [#^ (of Maybe int) x #^ Maybe y] (print x y))
; strict variant can also be pydantic validated:
(defn [validate_call :validate_return True]
      #^ None f [#^ (of Maybe int) x #^ Maybe y]
      (print x y))

; create Maybe objects:
(Just 3)      
Nothing

; check if object m is Just/Nothing (will give error if used not on Maybe type):
(justQ    m)
(nothingQ m)

(mapM m pureF1 pureF2 ...)  ; Apply pure functions to value stored in Just
                            ; or do nothing for Nothing
                            ; It is user's responsibility to ensure pureFi are indeed pure

(bindM m monadicF1 monadicF2 ...)   ; Apply functions of signagure [f :: val -> Maybe]
                                    ; to value stored in Just or do nothing for Nothing

; unwrappers will give errors when trying to apply them on non-Maybe type
(unwrapM    m)          ; returns contained Just value or throws error when not Just
(unwrapM_or m default)  ; returns contained Just value or falls back to default
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Result ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Result

Module `fptk.monads.resultM` (or `fptk.strict.resultM`) exposes objects:
* class: `Result`
* factory functions: `Success`, `Failure`
* functions: `successQ`, `failureQ`, `mapR`, `bindR`, `unwarpR`, `unwrapS`, `unwrapS_or`, `unwrapE`, `unwrapE_or`

Notice that `Success` and `Failure` are functions, not classes.
Real success/failure implementation is intentionally hidden from user.

User API:
```hy
; check if object r is of Result type
(= (type r) Result)
(isinstance r Result)

; use Result in annotations:
(defn f [#^ (of Result int str) x #^ Result y] (print x y))
; strict variant can also be pydantic validated:
(defn [validate_call :validate_return True]
      #^ None f [#^ (of Result int str) x #^ Result y]
      (print x y))

; create Result objects:
(Success 3)      
(Failure "err")  

; check if object m is Success/Failure (will give error if used not on Result type):
(successQ m)
(failureQ m)

(mapR r pureF1 pureF2 ...)  ; Apply pure functions to value stored in Success
                            ; or do nothing for Failure;
                            ; It is user's responsibility to ensure pureFi are indeed pure

(bindR r monadicF1 monadicF2 ...)   ; Apply functions of signagure [f(val) -> Result]
                                    ; to value stored in Success or do nothing for Failure

; unwrappers will give errors when trying to apply them on non-Result type
(unwrapR    r)          ; returns contained value, no matter if it is Success or Failure
(unwrapS    r)          ; returns contained Success value or throws error when not Success
(unwrapS_or r default)  ; returns contained Success value or falls back to default
(unwrapE    r)          ; returns contained Failure value or throws error when not Failure
(unwrapE_or r default)  ; returns contained Failure value or falls back to default
```

<!-- __________________________________________________________________________/ }}}1 -->

