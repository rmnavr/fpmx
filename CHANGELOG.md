# Version 0.6.0 (Jul 2026)
- big rebranding from `fptk` to `fpmx` (all the older naming is replaced everywhere, even in this changelog lol)
- prelude updates:
  - reorganized functions classification groups
  - added `approx_eq` function
  - added `dc_field` (dataclass.field)
  - added `fifth` function
  - added `add_terminator` and `discard_terminator` options for `write_to_file` and `read_file`
  - `=>` macro now places args in correct place when used with `f>` (before — it worked as `=>>` with `f>`)
- prelude API changes:
  - removed `strip`, `lstrip`, `rsrip` and `lowercase` functions
  - renamed `randint` and `randfloat` to `rand_int` and `rand_float`
  - renamed `file_existsQ` to more apropriate name `path_existsQ`
  - swapped args order in `write_to_file` to write_to_file(file, text, ...)
- monads:
  - big reorganization of monads
  - `WriterMaybe` transformer introduced
- term module:
  - added `color` option for dotPlot
  - `clrz` now throws full list of allowable colors when incorrect color was given
  - added `force_color` option for `clrz`

## 0.5.1.dev5
- `term` module added, including `clrz` and `dotPlot` functions
- functions `dmul` and `dadd` are removed as redundant (just use `plus` and `mul`)
- function `round_to` added

## 0.5.1.dev4
- Renamed monads unwrappers:
  - Maybe: unwrapM -> unwrapJ 
  - Result: unwrapE -> unwrapF 

# Version 0.5.0
- Big restructure to significantly increase startup time
  - removed hyrule dependency
  - split into 2 big parts: core (prelude) and extra (strict/monads, lenses)

## 0.4.5.dev:
- added Maybe monad (works similar to Result monad)
- fixed incorrectly reversed application order of funcs in resultM
- `f>` is back lol and `=>`/`p:` has special recognition for it (while `=>>` basic recognition works ok)

# Version 0.4.4 (14 Nov 2025)
- changed `timing` from function `timing(f, #* args, #** kwargs)`
  to macro `(timing expr1 expr2 ...)`
- added math functions:
  `floor`, `ceil`, `clip`, `lt0`, `leq0`, `gt0`, `geq0`
- upd lrange_ to also work on floats
- added `=>` and `=>>` macros, upd `p:` macro, removed `f>` macro
- added `def::` macro

# Version 0.4.0 (20 Oct 2025)
- changed order of args for oflenQ: from `oflenQ(xs,n)` to `oflenQ(n,xs)`
- removed `with_execution_time`, replaced with simplier `timing`
- removed `curry`, `rcurry` and `autocurry` (because `partial` is enough for fpmx needs)
- added `resultM` module
- renamed `write_file` to `write_to_file`
- fpmx source is now splitted into several files (tests/scripts upd accrodingly)
- completely removed auto full import of all modules (like re, os, etc.)

# Version 0.x.x (11 Oct 2025)
- refactored to submodules

# Version 0.x.x (30 Jul 2025)
- added many iterator funcs and also tests for them
- lmulticut_by: full functionality and test
- upd: enlengthen
- removed funcs on strings (ends_with, subsitute or smth)
  that can be replaced with regex funcs with similar functionality

