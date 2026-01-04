
# FPTK Doc Genrator

**FPTK Doc Generator** auto-generates 2 different documents:
* **Long-table** — one-liners list for `/_devdocs`
* **Stort-table** — official doc placed in `/docs`, consists of 2 parts:
  1. short cheatsheet-table
  2. help-cards for each entity
  > Short table does NOT output `(comment "lib | kind | name | sgntr | descr ")` entities.

Run `doc_generator.hy` file to generate both documents.

# Required format in source files

The only sourced file is `/src/core/funcs.hy`.

## Inside [GROUP] VimCells

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

## Inside [MACRO] VimCell

One particular VimCell with `[MACRO] cell_header` contains 2 big `(require ...)` statements.
Macros are searched for in those 2 big statements.

Recognized format (example):
```
    (require fptk.core.macros [
        of  #_ "[GROUP] Typing: Base  | signature | description"
        ->  #_ "[GROUP] FP: Threading | signature | description"
    ])

    ;; word [GROUP] is obligatory
```

Group names found in [MACRO] VimCells are then united with group names found in [GROUP] VimCells.

