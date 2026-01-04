
<!-- Overview ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# full list of fptk core macros

fptk offers following macros:
* Anonymous functions recognizing `it` or `%1`, `%2`, ... as arguments:
  * `fm`
  * `f>`
  * `(l)mapm`
  * `(l)filterm`
* Getters and threading macros:
  * `=>` and `=>>` — macros combining hy `.` and `->` (or `->>`) macros
  * `p:` — pipe of partials
  * `getattrm` — macros like `getattr` but with special syntax
  * `(l)pluckm` — buffed `(l)pluck` from funcy
* Haskell-style typing annotations:
  * `f::` — macro for annotating callables
  * `def::` — macros for annotating functions via haskell-style signature
* Macros for testing:
  * `assertm`
  * `gives_error_typeQ`

<!-- __________________________________________________________________________/ }}}1 -->

# Typing
<!-- f:: ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `f::` — macros for annotating Callables

Expanded into `Callable` annotation (with args and return types).
One possible usage might be defining interfaces (if functions are used in that role).

```hy
(setv ICaller (f:: int -> int -> float => (of Tuple int str)))
; equivalent py-code: ICaller = Callable[[int, int, float], Tuple[int, str]]
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- def:: ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `def::` — macros for annotating functions via haskell-style signature

Functions defined with `def::` macro will be annotated by values derived from user-given signature.

Special symbols are recognized inside signature:
- `->` separates arguments
- `=>` marks function return type
- `@` marks no signature

Special hy/python symbols, used in args definition (`/`, `*`, `#*` and `#**`) will be successfully recognized too (see expected syntax below).
Obviously, their order in signature and their order in function args list should match.

Examples:
```hy
    ; basic example:
    (def:: int -> int => int
        f1 [a b] (+ a b))
    ; it will be expanded to:
    (defn #^ int f1
        [#^ int a #^ int b] (+ a b))

    ; zero-args function:
    (def:: => int
        f2 [] (print "hello"))

    ; skip annotations for some args:
    (def:: @ -> int => @
        f3 [x y] (+ x y))

    ; decorators list can be given before function name:
    (def:: int -> int => int
        [decorator] f4 [a b] (+ a b))

    ; complex args example:
    (def:: int -> int -> / -> int -> * -> int -> #** dict => int
        f5 [a b / c * d #** kwargs] (+ a b c d))

    ; another complex args example:
    (def:: int -> int -> / -> int -> #* int -> #** dict => int
        f6 [a b / c #* args #** kwargs] (+ a b c))

    ; syntax for skipping annotations for #* and #** args:
    (def:: @ -> @ -> / -> @ -> #* @ -> #** @ => @
        f7 [a b / c #* args #** kwargs] (+ a b c))

    ; traditional hy syntax for types applies as usual,
    ; you can even use fptk f:: macro (for example for factories, closures and such)
    (def:: (of List int) -> (of Optional float) => (f:: int => float)
        f8 [xs t] (defn innerF [n] (+ (get xs n) (if (= t None) 0 t))))

    ; You can call (help ff) to see that function indeed was annotated correctly
```

<!-- __________________________________________________________________________/ }}}1 -->

# Lambdas
<!-- fm, f>, (l)mapm, (l)filterm ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `fm`, `f>`, `(l)mapm`, `(l)filterm` — macros for writing lambdas

Those macros all have same similar arguments recognition:
- either `it` as a solo-argument
- or `%i` for multi-arguments (from `%1` to `%9`)
- those 2 approaches cannot be mixed

Macros description:
- `fm` defines lambda
- `f>` defines and immediately applicates lambda (see threading macros for more usage examples)
- `mapm` and `lmapm` are both `map` that require lambda-syntax
- `filterm` and `lfilterm` are both `filter` that require lambda-syntax

```hy
(fm (* it 2))               ; -> (fn [it] (* it 2))
(fm (* it %1 2))            ; -> will give error (can't mix "it" with "%1")

; Just as original fn, fm will also work correctly with non-() forms:
(fm abs)                    ; -> (fn [] abs)
(fm [%1 (str %2)])          ; -> (fn [%1 %2] [%1 (str %2)])

; Just as original fn, fm will also work correctly with multiforms:
(fm (print it) it)          ; -> (fn [it] (print it) it)

; fm will be able to find "it" or "%n" in formatted strings:
(fm f"value = {it}")        ; -> (fn [it] f"value = {it}")
; fm will NOT be able to find "it" or "%n" in py expression:
(fm (py "print(it)"))       ; -> (fn [] (print it))
```

```hy
; f> works only with single form, use "do" for mutliforms:
(f> (do (print it) it) 3)   ; -> ((fn [it] (print it) it) 3)
```


Macros `(l)mapm` and `(l)filterm` can only contain one form in place of function:
```hy
(mapm (pow %1 2) [1 2 3])   ; -> (map (fn [%1] (pow %1 2)) [1 2 3])
(lmapm (pow %1 2) [1 2 3])  ; -> (list (map (fn [%1] (pow %1 2)) [1 2 3]))
(filterm (> it 1) [1 2 3])  ; -> (filter (fn [it] (> it 1)) [1 2 3])
(lfilterm (> %1 1) [1 2 3]) ; -> (list (filter (fn [%1] (> %1 1)) [1 2 3]))

; this will not work:
(mapm (print it) it [1 2 3])        ; Syntax error
; use "do" instead:
(mapm (do (print it) it) [1 2 3])   ; (map (fn [it] (do (print it) (it))) [1 2 3])

; notice that fm generates 0-arg lambdas if no arg ("it" or "%1" and such) is provided,
; thus making following use of (l)mapm and (l)filterm formally correct, but useless:
(mapm abs [1 2 3])          ; -> (map (fn [] abs) [1 2 3])
; in such cases use basic map instead:
(map abs [1 2 3])
```

<!-- __________________________________________________________________________/ }}}1 -->

# Threaders and getters

Macros in this group consistently use syntax `.attr` for attribute access
and `(.method)` for method calls.
> This is in contrast with hyrule's macro `->` where both `.smth` and `(.smth)` are seen as method calls.

<!-- => and =>> ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `=>` and `=>>` — buffed threaders

Macro `=>` (`=>>`) combines functions of `.` and `->` (`=>>`) macros by:
* recognizing [NEW] syntax elements ("new" with regard to basic syntax of `->`/`->>`)
* [MOD]ifying .attr/.mth syntax of `->` (`->>`)

```hy
; - SLOT is position where arg will be placed
; - notice that when => sees "-2" it sees it as integer,
;   but "n" (even if n==-2) will be seen as function

(=>  obj
     -2                   ; [NEW] integer | expanded to: (get SLOT -2)
     "key"                ; [NEW] string  | expanded to: (get SLOT "key")
     [0 "key"]            ; [NEW] list    | expanded to: (get SLOT 0 "key")
     .attr                ; [MOD]         | expanded to: SLOT.attr
     (.mth a1 a2 ...)     ;               | expanded to: (.mth SLOT a1 a2 ...)
     function             ;               | expanded to: (function SLOT)
     (function a1 a2 ...) ;               | expanded to: (function SLOT a1 a2 ...)
     ((fn [x] (* x 2)))   ;               | expanded to: ((fn [x] (* x 2)) SLOT)
     (f> (* it 2))        ;               | expanded to: ((fn [it] (* it 2)) SLOT) | *see note below
     )

(=>> obj
     -2                   ; same as for =>
     "key"                ; same as for =>
     [0 "key"]            ; same as for =>
     .attr                ; same as for =>
     (.mth a1 a2 ...)     ; [MOD] | expanded to: (.mth SLOT a1 a2 ...) | *see note below
     function             ;       | expanded to: (function SLOT)
     (function a1 a2)     ;       | expanded to: (function a1 a2 SLOT)
     ((fn [x] (* x 2)))   ;       | expanded to: ((fn [x] (* x 2)) SLOT)
     (f> (* it 2))        ;       | expanded to: ((fn [it] (* it 2)) SLOT)
     )
```

Notice there are 2 exceptions to standard behaviours:

1. when `=>` sees `(f> ...)`:

   ```hy
   (-> obj (f> (* it 2))     ; expanded to: (f> obj (* it 2))
   ; this generates incorrect f> macro

   ; for this reason => works differently:
   (=> obj (f> (* it 2))     ; expanded to: (f> (* it 2) obj)
   ```

2. when `=>>` sees `(.mth a1 a2 ...)`:

   ```hy
   (->> obj (.mth a1 a2))    ; expanded to: (a1.mth a2 obj)
   ; this doesn't seem very usefull;
   ; moreover, following syntax achieves the same result:
   (->> obj (a1.mth a2))     ; expanded to: (a1.mth a2 obj)

   ; for this reason =>> works differently:
   (=>> obj (.mth a1 a2))    ; expanded to: (obj.mth a1 a2)
   ; you also retain original usage if needed:
   (=>> obj (a1.mth a2))     ; expanded to: (a1.mth a2 ojb)
   ```


<!-- __________________________________________________________________________/ }}}1 -->
<!-- p: ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `p:` — pipe of partials

`p:` has syntax similar to `=>>` macro, but does not need to be called immediately.
Internally piping is implemented via partial application with [funcy.partial](https://funcy.readthedocs.io/en/stable/funcs.html#partial).

```hy
; - SLOT is position where arg will be placed
; - notice that when p: sees "-2" it sees it as integer,
;   but "n" (even if n==-2) will be seen as function

(p: -2                   ; integer | equiv to: (get SLOT -2)
    "key"                ; string  | equiv to: (get SLOT "key")
    [0 "key"]            ; list    | equiv to: (get SLOT 0 "key")
    .attr                ;         | equiv to: SLOT.attr
    (.mth a1 a2 ...)     ;         | equiv to: (SLOT.mth a1 a2 ...)
    function             ;         | equiv to: (function SLOT)
    (function a1 a2)     ;         | equiv to: (function a1 a2 SLOT)
    ((fn [x] (* x 2)))   ;         | equiv to: ((fn [x] (* x 2)) SLOT)
    (f> (* it 2))        ;         | equiv to: ((fn [it] (* it 2)) SLOT)
    )
```

Working example:
```hy
(import operator)
(setv x 4)
                                     ; after application to x will produce at each step:
(setv pipe (p: operator.neg          ; -4
               ((fm it))             ; -4     // fm macro can be used with p:
               (f> it)               ; -4     // f> macro can be used with p:
               (abs)                 ; 4
               (operator.add 4)      ; 8
               str                   ; '8'
               (.__contains__ "8")   ; True   // demonstration of method call
               .__class__            ; 'bool' // demonstration of attribute access
               ))

(print (pipe x))                     ; returns <class 'bool'>
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- (l)pluckm ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `(l)pluckm` — unification of lpluck/lpluck_attr funcs from funcy lib

`pluckm` extends [funcy.pluck](https://funcy.readthedocs.io/en/stable/colls.html#pluck)
to be able to recognize `(pluckm .attr xs)` syntax for accessing attributes.

`lpluckm` is just calling list on top of `pluckm`.

```hy
; .attr syntax expands to lpluck_attr:
(pluckm .attr xs)   ; (pluck_attr "attr" xs)

; everything else is expanded to lpluck:
(pluckm (+ i 3) xs) ; (pluck (+ i 3) xs)
(pluckm "key" xs)   ; (pluck "key" xs)

; to pass attr as string, use basic pluck_attr:
(pluck_attr "attr" cs)

```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- getattrm ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `getattrm`

The only thing this macros does is allowing `.attr` syntax for getattr:

```hy
(getattrm Point "x")     ; -> (getattr Point "x")
(getattrm Point .x)      ; -> (getattr Point "x")
```

<!-- __________________________________________________________________________/ }}}1 -->

# Testing
<!-- assertm, gives_error_typeQ ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## `assertm`

```hy
assertm(op, arg1, arg2) -> bool | Error
```

Checks if `(op arg1 arg2)` returns True and also:
1. Prints source expressions when check fails
2. Will return:
   - True when checks is true
   - False when check is False
   - Error object when check was not able to be calculated

```hy
(assertm = (+ 1 2) (- 3 10))
; Error in '(= (+ 1 2) (- 3 10)) | <class 'AssertionError'> : False
; >> '(+ 1 2) = 3
; >> '(- 3 10) = -7

(assertm = (+ z1z) (- 7))
; Error in '(= (+ z1z) (- 7)) | <class 'NameError'> : name 'z1z' is not defined
; >> Can't calc '(+ z1z) | <class 'NameError'> : name 'z1z' is not defined
; >> '(- 7) = -7
```

## `gives_error_typeQ`

```hy
gives_error_typeQ(expr, error_type) -> bool
```

Returns True when calculating `expr` produces error of `error_type`.
Returns False otherwise (eather when `expr` calculates without error, or when error type does not match).

Examples:
```hy
(gives_error_typeQ (get [1 2 3] 10) IndexError)
; True

(gives_error_typeQ (get [1 2 3] 1) IndexError)
; False
```

Best used with `assertm`:
```hy
(assertm gives_error_typeQ (get [1 2 3] 1) IndexError)
; Error in '(gives_error_typeQ (get [1 2 3] 1) IndexError) | <class 'AssertionError'> : False
; >> '(get [1 2 3] 1) = 2
; >> 'IndexError = <class 'IndexError'>
```

<!-- __________________________________________________________________________/ }}}1 -->

