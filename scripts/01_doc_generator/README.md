
# FPMX Doc Genrator

**FPMX Doc Generator** auto-generates 2 different documents:
* **Long-table** — one-liners list for `/_devdocs`
* **Stort-table** — official doc placed in `/docs`, consists of 2 parts:
  1. short cheatsheet-table
  2. help-cards for each entity
  > Short table does NOT output `(comment "lib | kind | name | sgntr | descr ")` entities.

Run `doc_generator.hy` file to generate both documents.

# Required format in source files

Two files are sourced for data:
- `/src/prelude/funcs.hy` — looking into [GROUP] VimCells for functions and such
- `/src/prelude/__init__macros.hy` — looking for macros in 2 big require statements

<!-- GROUP ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Functions — inside [GROUP] VimCells

VimCells with `[GROUP] cell_header` will be search for:
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
    ;; for kind_str I really only use "base" and "macro", although this is arbitrary string
```

Rules:
- comments inside parsed VimCells should start from `;;`, not `;` (this is parser issue I'm too lazy to solve)
- signature/description use `|` as separator between them; when not found — comment will be seen as description-oly
- comment `#_ "..."` is overall optional

<!-- __________________________________________________________________________/ }}}1 -->
<!-- MACRO ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Inside [MACRO] VimCell

Macros are searched for in 2 big require statements (in `__init__macros.hy`).

Recognized format (example):
```
    (require fpmx.prelude.macros [
        of  #_ "[GROUP] Typing: Base  | signature | description"
        ->  #_ "[GROUP] FP: Threading | signature | description"
    ])

    ;; word [GROUP] is obligatory
```

Group names found here are then united with group names found in [GROUP] VimCells.

<!-- __________________________________________________________________________/ }}}1 -->

