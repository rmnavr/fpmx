
# fptk monads

fptk implements monad types:
* [Maybe](#Maybe)
* [Result](#Result)

Monads aim to be compatible with pydantic typecheck.

<!-- Maybe ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Maybe

Module `fptk.monads.maybeM` exposes objects:
* Class: `Maybe`
* Factory functions: `Just`, `Nothing`
* Functions: `justQ`, `nothingQ`, `mapM`, `bindM`, `unwrapM`, `unwrapM_or`

## User API

To check if your `m` is of Maybe type, you can use `(= (type m) Maybe)`.
But you can't use `(= (type m) Just)`, since Just is actually a function, not a class.
Use `(justQ m)` instead.

Creating Maybe type:
```hy
    (Just 3) ; Create Maybe object with Just container (with 3 placed inside it)
    Nothing  ; Create Maybe object with special "nothing" container

    ; From a user POV Maybe type itself must be used only in annotations,
    ; that can be optionally validated by pydantic's validate_call like for example:
    (defn [validate_call] f [#^ (of Maybe int) x] (print x))

    ; output can be validated by pydantic too:
    (defn [(validate_call :validate_return True)]
          #^ (of Maybe int) f [#^ int x] (Just x))
```

Utilities:
```hy
    (justQ    m) -> bool  ; Checks if Maybe contains (Just ...)
    (nothingQ m) -> bool  ; Checks if Maybe contains Nothing

    (mapM m pureF1 pureF2 ...)  ; Apply pure functions to value stored in Just
                                ; or do nothing for Nothing
                                ; It is user's responsibility to ensure pureFi are indeed pure

    (bindM m monadicF1 monadicF2 ...)   ; Apply functions of signagure [f :: val -> Maybe]
                                        ; to value stored in Just or do nothing for Nothing

    (unwrapM    m)          ; returns contained Just value or throws error when not Just
    (unwrapM_or m default)  ; returns contained Just value or falls back to default
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Result ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Result

Module `fptk.monads.resultM` exposes objects:
* class: `Result`
* factory functions: `Success`, `Failure`
* functions: `successQ`, `failureQ`, `mapR`, `bindR`, `unwrapR`, `unwrapR_or`, `unwrapE`, `unwrapE_or`


## User API

To check if your `m` is of Result type, you can use `(= (type m) Result)`.
But you can't use `(= (type m) Success)`, since Success is actually a function, not a class.
Use `(successQ m)` instead.

Creating Result type:
```hy
    (Success 3)      ; Create Result type with Success container (with 3 placed inside it)
    (Failure "err")  ; Create Result type with Failure container (with "err" placed inside it)

    ; internally Success and Failure are factory functions, not classes

    ; From a user POV Result type itself must be used only in annotations,
    ; that can be optionally validated by pydantic's validate_call like for example:
    (defn [validate_call] f [#^ (of Result int str) x] (print x))

    ; output can be validated by pydantic too:
    (defn [(validate_call :validate_return True)]
          #^ (of Result int str) f [#^ int x] (Success x))
```

Utilities:
```hy
    (successQ r) -> bool  ; Checks if Result contains Success
    (failureQ r) -> bool  ; Checks if Result contains Failure

    (mapR r pureF1 pureF2 ...)  ; Apply pure functions to value stored in Success
                                ; or do nothing for Failure;
                                ; It is user's responsibility to ensure pureFi are indeed pure

    (bindR r monadicF1 monadicF2 ...)   ; Apply functions of signagure [f :: val -> Result]
                                        ; to value stored in Success or do nothing for Failure

    (unwrapR    r)          ; returns contained Success value or throws error when not Success
    (unwrapR_or r default)  ; returns contained Success value or falls back to default
    (unwrapE    r)          ; returns contained Failure value or throws error when not Failure
    (unwrapE_or r default)  ; returns contained Failure value or falls back to default

    ; If you need to access contained value no matter if it is Success or Failure, you can use:
    r.value
```

Dev usage:
```hy
    ; If you really need to access container _Success (or _Failure) 
    ; (although API is intentionally built to discourage such a usecase), use:
    r.result
```

<!-- __________________________________________________________________________/ }}}1 -->


