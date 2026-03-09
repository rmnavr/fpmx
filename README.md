
<!-- Intro ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# fpmx — [F]unctional [P]rogramming [M]ath e[X]tension for hy-lang

**fpmx** is a language extension for Hy and Python designed to bridge the gap between
the expressiveness of functional/math languages and the industrial power of Python ecosystem.
It brings the ergonomics of *Mathematica*, *APL*, *Haskell*, and similar languages
directly to the Hy/Python runtime.

With a curated suite of over 250 pure functions, syntactic macros, and basic types,
fpmx transforms Hy into a native environment for mathematical computation by 
eliminating the friction of imperative-first languages.

# Architecture and Modules

fpmx is designed as a two-tier system to balance API stability with FP/math experimentation:
- **fpmx.prelude** — the stable heart of the library optimized for everyday use.
  It includes functions, macros and types that define the **fpmx** experience.
  By importing the prelude namespace (`(import fpmx.prelude *) (require fpmx.prelude *)`),
  you gain immediate access to a "batteries-included" functional vocabulary without constant context switching,
  thus allowing you to focus on logic and mathematical flow rather than boilerplate.
  > This is the recommended entry point for all projects
- **fpmx.extras** — a collection of modules that contain specialized,
  domain-specific, or experimental features.
  These modules allow for extensions into niche FP/math territories
  without bloating the prelude or compromising its stability.

<!-- __________________________________________________________________________/ }}}1 -->

<!-- Prelude: Intro ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Prelude module

The fpmx prelude provides a functional vocabulary for expressing math and FP ideas
through a suite of pure functions (with obvious non-pure exceptions like `read_file` and similar).

For quick overview of all full Prelude vocabulary please refer to: 
[Prelude cheatcheet table](docs/00_prelude_cheatsheet_table_view.md) 


<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Principles ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Key principles

Following the *Mathematica* tradition,
fpmx provides a rich set of boolean predicates (ending in Q for «Query»):
```hy
(zeroQ x)        ; checks if x == 0
(negativeQ x)    ; checks if x < 0
(zerolenQ xs)    ; cehcks if len(xs) == 0
(numberQ x)      ; checks if x is int or float
(iterableQ xs)   ; checks if xs is iterable
(noneQ x)        ; checks if x is None
...
```

Following *funcy* tradition, most sequence functions offer both lazy and eager list variants
(e.g., `map` vs `lmap`) allowing you to optimize for memory or speed as needed:
```hy
(cycle 'AB')         ; generator: 'A', 'B', 'A', ...
(lcycle 'AB' 3)      ; ['A' 'B' 'A']
(lfilter pred seq)   ; list version of filter
(lreversed sequence) ; list version of reversed
...
```

To make code more readable by removing ambiguity of standard `*` and `+` dunder operators, 
fpmx offers duplicated names for them:
```hy
(mul a b c ...)  ; «*» operator as function
(smul a b c ...) ; «*» operator as function, but underlines usage on string like (* 3 "a")
(lmul a b c ...) ; «*» operator as function, but underlines usage on lists like (* 3 [1])

(plus a b ...)   ; «+» operator as function

; to «plus» strings and lists, specialized functions are advised:
(sconcat ...)    ; concatenate strings 
(lconcat ...)    ; eager concatenation of lists
```

To avoid manual writing of `(import typing [List]`) in every module,
fpmx by default reimports several most commonly used types like
`List`, `Dict`, `Tuple`, `Union`, `dataclass` and several others.

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Math ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Math ergonomics

Set of basic math utility functions is included in Prelude:

```hy
; shortcuts for common operations:
(inc x)  ; x + 1 
(dec x)  ; x - 1 
(half x) ; x / 2
...

; rounding:
(round_to 9.1 1.5)    ; rounds to multiple (of 1.5 in this case)
(floor x)             ; reimport of math.floor
(clip x lower upper)  ; clips x to fit in [lower <= x <= upper] limits
(approx_eq x y)       ; renaming of math.is_close
...

; basic math funcitons:
(sqrt x) ; square root of x
(exp x)  ; exponent function
(ln x)   ; natural logarythm
...

; trigonometry:
(sin x)  ; reimport of math.sin
(atan x) ; artangent of x
pi       ; float pi=3.14...
...

; random:
(randint 3 7)       ; random integer in range
(randfloat 1.0 3.5) ; random float in range
...
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Operators as funtctions ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Operators as functions

To make standard operators like `*` and `+` usable in functional composition (see further),
fpmx provides their function variants, which do not shaddow builtin Python namespace:
```hy
(and_ a b c ...)    ; «and» as function
(xor a b c ...)     ; xor as function
(matmul a b c ...)  ; @ operator as function
(div x y)           ; / operator as function
(plus x y z)        ; + operator as function
(mul x y z)         ; * operator as function
(neq a b)           ; «non-equal», same as != operator
(leq0 a)            ; «less or equal than 0»
...
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Strings ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Strings manipulation

fpmx offers functional wrappers for regex (to avoid their manual compilation):
```hy
(re_sub r"\d" "-" "smth1smth1smth")   ; returns "smth-smth-smth"
(re_find r"\s*\d\d\" "here 20 comes") ; returns " 20"
...
```

fpmx also has several usefull utilities for strings:
```hy
(str_join ["a" "b"] :sep "-")    ; returns string "a-b"
(enlengthen 10 "smth" :char "-") ; returns string "smth------"
...
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Getters ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Buffed getters 

fpmx offers enhanced getters (and several setters) for making index/attr accessing more ergonomic:
```hy
; Named indexed getters, which are common in FP languages:
(setv xs ["a" "b" "c" "d"]
(first xs)  ; returns "a"
(fourth xs) ; returns "d"
(last xs)   ; returns "d"
...

; Sequential getters:
(drop 2 [1 2 3 4 5])           ; returns [3 4 5]
(drop -2 [1 2 3 4 5])          ; returns [1 2 3]
(take 2 [1 2 3 4 5])           ; returns [1 2]
(pick [0 2] ["a" "b" "c" "d"]) ; returns ["a" "c"]
...

; Getter that will return None rather than throw error (unlike basic 'get' macro):
(nth 3 xs)  ; will return None if xs[3] does not exist

; Bulk getters:
(lpluck 0 [[0 1] [2 3] [4 5])  ; returns [0 2 4] (e.g. first elem of each sublist)
(lpluck_attr "x" points)       ; gets point.x for every point from points (returns list)
...
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: FP IO wrappers ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Functional wrappers for IO

Instead of imperative context switching with standard Python `with` form,
fpmx offers functional wrappers for basic IO:
```hy
(read_file "1.txt" :encoding "utf-8")
(write_to_file text "1.txt" :mode "w")
(file_existsQ f) ; checks if file or folder f exists
...
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: APL ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Sequence processing

fpmx greately extends Python basic FP-vocabulary:
```hy
; enhancing zip/map/reduce family:
(starmap ...)    ; reimport of itertools.starmap
(reductions ...) ; returns sequence of intermediate results of functools.reduce function
...

; cutting and grouping:
(lpartition 2 [0 1 2 3 4 5]) ; returns [[0 1] [2 3] [4 5]]
(lbisect_by trueQ [True True False False False]) ; returns #([True True] [False False False])
...

; filtering:
(fltr1st floatQ [1 2 3.0 4 5]) ; will return 3.0 (or None if float were not present)
(lfilter_split floatQ [1 2.0 3.0 4]) ; will return #([2.0 3.0] [1 4])
...
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: FP ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Functional composition

fpmx offers set of utility functions that provide true "function-first" experience in Hy/Python:
```hy
; nested function application:
(setv nested_fs (compose f1 f2 f3))
(nested_fs x)  ; will essentially run f1(f2(f3(x)))

; partial application:
(lmap (partial plus 3) [1 2 3]) ; returns [4 5 6]

; flipping arguments for 2-args functions:
(lmap (partial div 10) [1 2 3]) ; returns [10.0 5.0 3.33333]
(lmap (pflip   div 10) [1 2 3]) ; returns [0.1 0.2 0.3]
```

However functional composition truly shines in fpmx threading macros (see below).

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Macros ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Prelude Macros

fpmx has special syntax for lambdas, which removes neccessity to manualy name arguments:
```hy
(fm (print it))     ; (fn [it] (print it))          ; «it» is recognized as solo-argument 
(fm (print %1 %2))  ; (fn [%1 %2] (print %1 %2))    ; %1 and %2 are recognized as arguments

; macros mapm/filterm, their list-variants, and several others use same syntax:
(lmapm (* %1 %2) [1 2 3] [4 5 6])
(filterm (eq it 3) [1 2 3])
```

fpmx macros `=>` and `=>>` combine hy `.` and hyrule `->`/`->>` macros.
This solves the problem of combining getters with threaders:
```hy
; consider list of points (Point is dataclass with :x and :y fields):
(setv pts [(Point :x 1 :y 2) (Point :x 3 :y 4)])

; We want to extract .x of first point (=1) and double it (return 2)

; The best we can do in traditional hy syntax is:
(-> pts (get 0) (getattrm "x") double)  
; or:
(double (. pts [0] x)

; But fpmx => macro makes it even prettier:
(=> pts [0] .x (double))  
```

Also, asa special treat for Haskellers — fpmx offers function annotation macro `def::`:
```hy
; basic usage:
(def:: int -> int => float
    [decorator] div_ints [x y] (return ...))
; function div_ints will have annotation: div_ints(x: int, y: int) -> float

; showcase of annotating args and kwarks, plus skipping some annotations with «@»:
(def:: @ -> int -> / -> int -> #* int -> #** dict => int
       f6 [a b / c #* args #** kwargs] (+ a b c))
       ; «a»-arg will have no annotation due to «@»
```

And as for basic ergonomics, fpmx reimports some of general-usage macros from hyrule (like `case`, `unless`, `->` and others).

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Prelude: Other ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Misc Prelude functionality

1-based indexing variants of basic getters and ranges for mathematical alignment
(fpmx does not expect 1-based indexing approach anywhere except those few specific functions):
```hy
(get_ x 1)    ; gets x[0]
(range_ 1 3)  ; generator: 1, 2, 3
(lrange_ 1 3) ; [1 2 3]
...
```

Also:
- `lprint` to print each elem of list on the new line
- `cur_time` for returning current time

<!-- __________________________________________________________________________/ }}}1 -->

<!-- Extra ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Extras

fpmx has following evolving extra modules:
* `fpmx.strict.types`:
  * requires [pydantic](https://github.com/pydantic/pydantic) library
  * offers some helper classes for strict type checking
* `fpmx.monads` and their `fpmx.strict` equivalents
  * contains Maybe and Result monads 
  * strict monads can be pydantic type-checked
  * strict monads require [pydantic](https://github.com/pydantic/pydantic) library
* `fpmx.lenses`
  * offers macros for nicer lens syntax
  * requires [lenses](https://github.com/ingolemo/python-lenses) library
    (which is Haskell-inspired lib for working with deeply nested structures)
* `fpmx.term`
  * terminal utils: plotting, coloring, etc.

Modules that require pydantic may be slower to load,
this is one of the reasons for excluding them from Prelude.

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Loading ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Using fpmx

fpmx has special loader that loads everything from requested modules.

Importing everything from Prelude only:
```hy
(require fpmx.loader [load_fpmx])
(load_fpmx "prelude")

; which is internally the same as:
(import  fpmx.prelude *) ; load funcs/types
(require fpmx.prelude *) ; load macroses
```

Importing every fpmx module:
```hy
(require fpmx.loader [load_fpmx])
(load_fpmx "prelude"
           "lenses"
           "strict_types" "strict_maybeM" "strict_resultM"
           "maybeM" "resultM"
           "term")

; which is internally the same as:
(import  fpmx.prelude *)
(require fpmx.prelude *)

(import  fpmx.lenses *)
(require fpmx.lenses *)

(import  fpmx.monads.maybeM *)
(import  fpmx.monads.resultM *)

(import  fpmx.strict.types *)
(import  fpmx.strict.maybeM *)   ; this will actually override non-strict maybeM
(import  fpmx.strict.resultM *)  ; this will actually override non-strict resultM

(import  fpmx.term.colors *) 
(import  fpmx.term.dotplot *) 
```

<!-- __________________________________________________________________________/ }}}1 -->

<!-- Documentation ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Documentation

## Prelude

All 250 functions/types/macros are layed out in 2 different formats
(*table form* is preffered for the user, however you might find *one-liners form* more convenient):
- [Cheatsheet for end user (table form)](docs/00_prelude_cheatsheet_table_view.md) 
- [Cheatsheet for developer (one-liners form)](docs/01_prelude_cheatsheet_list_view.hy) 

To dive deeper into fpmx macros see:
- [Prelude macros in more details](docs/02_prelude_macros.md) 

## Extra modules

- [strict typing](docs/strict_typing.md)
- [monads (strict and non-strict variants)](docs/monads.md)
- [fpmx lenses](docs/lenses.md)
- [utils for terminal](docs/terminal.md)

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Dependencies ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Dependencies

Tested with versions:
* Prelude requires:
  * [hy](https://github.com/hylang/hy) 1.0.0
  * [funcy](https://github.com/Suor/funcy/) 2.0
  * termcolor 3.2.0
* Extras also require:
  * [lenses](https://github.com/ingolemo/python-lenses) 1.2
  * [pydantic](https://github.com/pydantic/pydantic) 2.12.3

> fpmx does NOT directly depend on hyrule lib, since it internally replicates some of it's macros (like `->`, `case` and others).
> This was done to increase fpmx startup speed.

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Project status ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Project status

Prelude functionality is at 90% of reaching stable release (some API-breaking changes may still happen).

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Installation ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Installation

```
pip install git+https://github.com/rmnavr/fpmx.git@main
```

<!-- __________________________________________________________________________/ }}}1 -->

