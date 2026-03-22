
# fpmx monads

<!-- Intro ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

fpmx implements:

* Monads:
  * [Maybe](#Maybe)
  * [Result](#Result)
* Monad Transformers:
  * [WriterMaybe](#WriterMaybe)

Monads and transformers are implemented in two variants with the same interface and namings:
- *normal*
- *strict* — compatible with pydantic typecheck (thus importing monads also imports pydantic)
> The reason both variants exist is due to pydantic requiring extra time to load (~150 ms on 2025-year laptop)

## User API

With regard to monad implementation fpmx places code clarity over math correctness.

This entails following design decisions:
* `fmap`, `bind` and similar are implemented as a stand-alone functions rather than methods,
  with each monad having unique function name (`fmapM` for `Maybe`, `fmapR` for `Result`, etc.).
* unwrapper functions like `unwrapJ` (for `Just`) are used instead of attribute access like `monad.value`
* instead of implementing `fmap2`, `fmap3` and similar, all `fmap`s and `bind`s are variadic
* Most functions perform type-check internally — they will throw errors when incorrect monad/transformer is provided
* Transformers are NOT compositions of their underlying monads.
  For example, `WriterMaybe` is a self-contained object, rather than a 'sum' of `Writer` and `Maybe` monad.
  This is why transformer's `fmap` and `bind` has some serious deviation from their canonical implementation.

This way you cannot for example `fmapM` or `unwrapJ` on Result monad, thus enforcing type correctness.

## Import

How to import:
```hy
; normal:
(import fpmx.monads.maybeM *)
(import fpmx.monads.resultM *)
(import fpmx.monads.writerMaybeT *)

; strict:
(import fpmx.strict.maybeM *)
(import fpmx.strict.resultM *)
(import fpmx.strict.writerMaybeT *)

; or via loader:

; normal:
(require fpmx.loader [load_fpmx])
(load_fpmx "maybeM" "resultM" "writerMaybeT")
; strict:
(require fpmx.loader [load_fpmx])
(load_fpmx "strict_maybeM" "strict_resultM" "strict_writerMaybeT")
```

<!-- __________________________________________________________________________/ }}}1 -->

<!-- Maybe ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Maybe

Maybe monad can contain eather (Just value) or Nothing.

Notice that `Just` and `Nothing` are functions, not classes.

User API:
```hy
Maybe       ; class
(Just 3)    ; create Just 3
Nothing     ; create Nothing

(justQ    m) ; check if object m is Just    (will give error if used not on Maybe type)
(nothingQ m) ; check if object m is Nothing (will give error if used not on Maybe type)

(fmapM m0 pureF m1 m2 ...)    ; Apply pure function to values stored in Just
                              ; or return Nothing if any of monad is Nothing.
                              ;
                              ; It is user's responsibility to ensure pureF is indeed pure

(bindM m0 monadicF m1 m2 ...) ; Apply function of signagure :: val0 -> val1 -> ... -> Maybe
                              ; to values stored in Just or return Nothing if any of mi is Nothing

(unwrapJ    m)          ; returns contained Just value or throws error when not Just
(unwrapJ_or m default)  ; returns contained Just value or falls back to default
```

Multiple args example:
```
(fmapM (Just 3) (fn [x y] (+ x y)) (Just 4)) ; returns (Just 7)
(fmapM (Just 3) (fn [x y] (+ x y)) Nothing)  ; returns Nothing
```

Annotations:
```hy
; Maybe itself is supposed to be used only in annotations:
(defn f [#^ (of Maybe int) x #^ Maybe y]
    (print x y))
; strict variant can also be pydantic validated:
(defn [validate_call :validate_return True]
    #^ None f [#^ (of Maybe int) x #^ Maybe y]
    (print x y))

; if needed to check if object m is of Maybe type:
(= (type m) Maybe)
(isinstance m Maybe)
```
<!-- __________________________________________________________________________/ }}}1 -->
<!-- Result ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Result

Result monad can contain eather (Success value) or (Failure value) .

Notice that `Success` and `Failure` are functions, not classes.

User API:
```hy
Result          ; class
(Success 3)     ; create Success 3
(Failure "err") ; create Failure "err"

(successQ m) ; check if object m is Success (will give error if used not on Result type)
(failureQ m) ; check if object m is Failure (will give error if used not on Result type)

(fmapR m0 pureF m1 m2 ...)    ; Apply pure function to values stored in Success
                              ; or return first encountered Failure.
                              ;
                              ; It is user's responsibility to ensure pureF is indeed pure

(bindR m0 monadicF m1 m2 ...) ; Apply function of signagure :: val0 -> val1 -> ... -> Result
                              ; to values stored in Success or return first encountered Failure

(unwrapS    m)          ; returns contained Success value or throws error when not Success
(unwrapS_or m default)  ; returns contained Success value or falls back to default
(unwrapF    m)          ; returns contained Failure value or throws error when not Failure
(unwrapF_or m default)  ; returns contained Failure value or falls back to default
```

Multiple args example:
```
(fmapR (Success 3) (fn [x y] (+ x y)) (Success 4))     ; returns (Success 7)
(fmapR (Success 3) (fn [x y] (+ x y)) (Failure "err")) ; returns (Failure "err")
```

Annotations:
```hy
; use Result in annotations:
(defn f [#^ (of Result int str) x #^ Result y]
    (print x y))
; strict variant can also be pydantic validated:
(defn [validate_call :validate_return True]
    #^ None f [#^ (of Result int str) x #^ Result y]
    (print x y))

; if needed to check if object r is of Result type
(= (type r) Result)
(isinstance r Result)
```
<!-- __________________________________________________________________________/ }}}1 -->
<!-- WriterMaybe ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# WriterMaybe

WriterMaybe transformer can contain eather (WJust value log_) or (WNothing log_).
Where `log_` has to be of list type.
> `log_` has `_` at the end to avoid collision with fpmx.prelude logarythm `log` function

Notice that `WJust` and `WNothing` are functions, not classes.

User API:
```hy
WriterMaybe ; class
(WJust 3 [])       ; create WJust with value 3 and empty log
(WNothing ["err"]) ; create WNothing with log ["err"]

(wJustQ    t) ; check if object t is WJust    (will give error if used not on WriterMaybe type)
(wNothingQ t) ; check if object t is WNothing (will give error if used not on WriterMaybe type)

(askWM  t)       ; returns log of t
(tellWM t log_)  ; adds log_ to existing log of t

(fmapWM t0 pureF t1 t2 ...)    ; Apply pure function to values stored in WJust,
                               ; or return WNothing if WNothing is encountered.
                               ;
                               ; How logs are appended:
                               ; 1) When t0 is WNothing, use log from t0
                               ; 2) When t0 is WJust, but some (first found) ti is WNothing,
                               ;    append logs: t0, ti
                               ; 3) When all ti are WJust, append logs: t0, t1, t2, ...
                               ;
                               ; It is user's responsibility to ensure pureF is indeed pure

(bindWM t0 monadicF t1 t2 ...) ; Apply function of signagure :: val0 -> val1 -> ... -> WriterMaybe
                               ; to values stored in WJust.
                               ; Or return WNothing if WNothing is encountered.
                               ;
                               ; How logs are appended:
                               ; 1) When t0 is WNothing, use log from t0
                               ; 2) When t0 is WJust, but some (first found) ti is WNothing,
                               ;    append logs: t0, ti
                               ; 3) When all ti are WJust, append logs: t0, t1, t2, ..., log_from_monadicF
                               ;
                               ; When result of monadicF is WNothing, it does NOT change
                               ; logs append logic stated above.

(unwrapWJ    m)          ; returns #(value log_) of WJust (throws error when not WJust)
(unwrapWJ_or m default)  ; returns #(value log_) of WJust or #(default log_) for WNothing
```

Multiple args example:
```
(fmapWM (WJust 3 ["hey"]) (fn [x y] (+ x y)) (WJust 4 []))   ; returns (WJust 7 "hey")
(fmapWM (WJust 3 ["hey"]) (fn [x y] (+ x y)) (WNothing []))  ; returns (WNothing "hey")
```
<!-- __________________________________________________________________________/ }}}1 -->


