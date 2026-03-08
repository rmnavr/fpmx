
# FPMX Doc Genrator

**FPMX Doc Generator** auto-generates 2 different documents:
* **One-liners-table (OLT)** — in format of *.hy
* **MD-table (MDT) ** — in format of *.md, consists of 2 parts:
  1. cheatsheet-table of hoverable fpmx entities
  2. help-cards for each entity (that contain short info + their «help» description)
  > Unlike OLT, MDT does NOT output `(comment "lib | kind | name | sgntr | descr ")` entities.

Run `doc_generator.hy` file to generate both documents.

# Required format in source files

Two files are sourced for data:
- `/src/prelude/funcs.hy` — looking into `[GROUP] 01 Title: subtitle` VimCells 
- `/src/prelude/__init__macros.hy` — looking for macros in 2 big require statements

<!-- Ordering ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Ordering

Group should have strictly following format:
```hy
    ;; for VimCells headers in funcs.hy:
    [GROUP] 05 Typing: Base

    ;; for macros description in __init__macros.hy:
    #_ "[GROUP] 05 Typing: Base  | signature | description"
```

Number (`05` in the example) is used to define groups/subgroups sorting in generated docs.
Please use the same `order-name-subname` group naming across `funcs.hy` and `__init__macros.hy`.

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Parsing: funcs.hy ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Parsing `funcs.hy`

VimCells properly named as `[GROUP] 01 Title: subtitle` will be searched for:
```
    (import math) #_ "description"`
    
    #_ "description"
    (setv x (+ 1 2))
    
    #_ "signature | description"
    (defn [optional_decorator] some_func [x y] ...)
    
    ;; parser will be able to see only one entity per import:
    (import funcy [partial])        #_ "signature | description"
    (import operator [ne :as neq])  #_ "signature | description"
    
    ;; parser will be able to see only one entity per require ('of' in this case):
    (require hyrule [of])           #_ "signature | description"

    (comment "source_lib | kind_str | name | signature  | description ")
    (comment "hy         | func     | get  | (get xs n) | basic getter")
    ;; for kind_str I really only use "builtin" and "macro", although this can be arbitrary string
```

Rules:
- comments inside parsed VimCells should start with `;;`, not `;` (this is parser issue I'm too lazy to solve)
- signature/description use `|` as separator between them; when not found — comment will be seen as description-only
- comment `#_ "..."` is overall optional

<!-- __________________________________________________________________________/ }}}1 -->
<!-- Parsing: __init__macros.hy ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Parsing `__init__macros.hy`

Macros are searched for in 2 big require statements in `__init__macros.hy`.

Recognized format (example):
```
    (require fpmx.prelude.macros [
        of  #_ "[GROUP] 05 Typing: Base  | signature | description"
        ->  #_ "[GROUP] 06 FP: Threading | signature | description"
    ])

    ;; word [GROUP] is obligatory
```

Group names found here are then united with group names found in `funcs.hy`.

<!-- __________________________________________________________________________/ }}}1 -->

