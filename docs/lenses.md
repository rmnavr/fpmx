
<!-- Intro ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# fptk lenses

Lenses macros should be used together with [lenses](https://github.com/ingolemo/python-lenses) library.
They simplify lens definition, composition and application.

> Lenses is Haskell-inspired library for working with deeply nested immutable data.
> Lenses can be seen as buffed getters and setters.

Usage:
```
(import fptk.lenses [lens])        ; main object (lens) from original lenses library
(require fptk [lns &+ &+> l> l>=]) ; macros

; you don't need to interact with `lens` directly, but fptk-lenses macros require it to be loaded
```

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Cheetsheet ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Cheatsheet

In order to see what role fptk-lenses macros play,
below cheatsheet is given for lenses library as a whole, not just for fptk macros.

## lenses cheatsheet (for original lenses library)

Most important objects in lenses are UL (UnboundLens) and SF (StateFunction),
which will be further referred to as UL and SF.

UL/SF definition, application, composition:
```
(. lens [-2] ["key"] [idx] attr)         ; define UL
(. lens [-2] ["key"] [idx] attr (set 3)) ; define SF

((. lens [1] (get)) data)                ; SF application

(&  (. lens [1]) (. lens [2]))                       ; composing ULs
(&  (. lens [1]) (. lens [2]) (. lens [2] (set 3)))  ; composing ULs and SF (SF can be only at last position)
(&  xs (. lens [1] (get)) (. lens [2] (get)))        ; SFs application (one after another)
(&= xs (. lens (Each) (modify sqrt)))                ; SF application and rebinding xs to result

(. lens [1] (bitwise_and 5))            ; since «&» is taken, this is how bitwise_and should be done
```

SF ("final" getters/setters):
```
(. lens [1] (Each) (get))                       ; returns 1st focused elem // not the best combination with Each
(. lens [1] (Each) (collect))                   ; returns all focused elems
(. lens [1] (Each) (get_monoid))                ; returns as 1-lvl-deep list

(. lens [1] (Each) (set "here"))                ; returns full data
(. lens [1] (Each) (set_many (cycle ["here"]))) ; returns full data, sets foci to values via iterator
(. lens [1] (Each) (modify str))                ; \ returns full data, applies function to focus
(. lens [1] (Each) (modify (fn [x] (str x))))   ; /
```

Calling methods on focus:
```
(. lens [1] [2] (call "__mul__" 10)) ; returns full data, calls method of focused object
                                     ; (avoid usage of mutating methods);
(. lens [0] [2] (call___mul__ 10))   ; <- alternative syntax
; most dunders (except &) also have another syntax alternative:
(* (. lens [0] [2]) 10)

(. lens [1] (call_mut "sort" :shallow True)))   ; this is proper way to call mutating methods,
(. lens [1] (call_mut "sort" :shallow False)))  ; shallow=False will use deepcopy internaly;
(. lens [1] (call_mut_sort   :shallow True)))   ; <- alternative syntax
```

Important lens methods (short info):
```
; can work with both getters and setters:
(Each)
(Recur int)         ; recursively finds all ints
(Values)            ; \
(Item)              ; | returns tuple of key and value
(Keys)              ; /
(Filter (fn [x] (< x 100)))
(Instance str)      ; checks if focus is str
(Contains "item")   ; with (get) will return True/False, with set True/False will add/remove to data

; work only with getter:
(Fold ...)               ; getter with multiple foci
(F (fn [x] (* x 10)))    ; wrapper for getter

; work only with setter:
(Fork (lns 0 1) (lns 1))
```

Helpers:
```
(. lens [1] [2] (Fold str) (kind))  ; shows kind of UL (will not work with SF)
```

## fptk lenses macros

### lns syntax (fptk)

`lns` macro offers new syntax for lens object:

```hy
; standalone numbers, strings and variables are recognized as index access:
(lns 1 -2 (- 7) "key" idx)  ; (. lens [1] [-2] [- 7] ["key"] [idx])

; attribute access:
(lns .attr)                 ; (. lens attr)
                            ; (. lens (GetAttr "attr"))

; expressions surrounded by parentheses) are seen as is:
(lns (Each) (set 3))        ; (. lens (Each) (set 3))

; to ensure arbitrary expression is recognized as index, use square brackets:
(lns (+ i 3))               ; (. lens (+ i 3))   // will give error
(lns [(+ i 3)])             ; (. lens [(+ i 3)]) // works ok

; lns macro recognizes 4 special forms:
(lns 1 (mth> .sort))                ; (. lens (call "sort")
(lns 1 (mut> .copy :shallow True))  ; (. lens (call_mut "copy" :shallow True)
(lns 1 (dndr>  / 3))                ; (/ (. lens [1]) 3)
(lns 1 (dndr>> / 3))                ; (/ 3 (. lens [1]))
```

### Usage of fptk lenses macros

All fptk macros recognize `lns` syntax described above.

```hy
; lns-macro is used to define UL or SF in alternative syntax:
(lns 1 (Each))                          ; UL: (. lens [1] (Each))
(lns 1 (Each) (set 3))                  ; SF: (. lens [1] (Each) (set 3))

; l> is used to apply SF to data_structure,
(l>  xs 1 (Each) (modify sqrt))         ; ((. lens [1] (Each) (modify sqrt)) xs)

; l>= also rebinds result to same name:
(l>= xs 1 (Each) (modify sqrt))         ; (setv xs ((. lens [1] (Each) (modify sqrt)) xs))

; &+ can combine several ULs + obligatory getter/setter at the end:
(&+ (lns 1) (. lens [2]) (set "here"))  ; (& (. lens [1]) (. lens [2] (set "here")))

; &+> also applies composed SF:
(&+> xs (lns 1) (mut> .sort))           ; ((& (. lens [1] (call_mut "sort"))) xs)
```

<!-- __________________________________________________________________________/ }}}1 -->

