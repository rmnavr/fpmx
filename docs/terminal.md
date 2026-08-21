
# Utils for terminal

Loading module:
```hy
; via loader:
(require fpmx.loader [load_fpmx])
(load_fpmx "term")

; which is the same as:
(import fpmx.term.colors *) 
(import fpmx.term.dotplot *) 
```

This will expose following functions:
* `clrz`
* `clrz_term_test`
* `dotPlot`

<!-- colors ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

# Coloring

fpmx offers simple adapter `clrz` for `termcolor.colored` function
Unlike original `termcolor.colored`, in `clrz` you can provide color instructions in arbitrary order.

You can also color-check your terminal using `clrz_term_test`.

```python
# Examples:

clrz(['blue', 'on_red', 'reverse'], 'text')
clrz(['blue'], 'text')
clrz(['on_red'], 'text', force_color=True)

clrz_term_test()
```

Available instructions are the same as for original `termcolor.colored`:
```
FG            | BG               | Attrs
--------------+------------------+----------
black         | on_black         | bold
red           | on_red           | dark
green         | on_green         | underline
yellow        | on_yellow        | blink
blue          | on_blue          | reverse
magenta       | on_magenta       | concealed
cyan          | on_cyan          | strike
light_grey    | on_light_grey    |
dark_grey     | on_dark_grey     |
light_red     | on_light_red     |
light_green   | on_light_green   |
light_yellow  | on_light_yellow  |
light_blue    | on_light_blue    |
light_magenta | on_light_magenta |
light_cyan    | on_light_cyan    |
white         | on_white         |
```

`force_color` option (`False` by default) is inherited from termcolor.
When `True`, it will spit ANSI chars into text files, when `False` it will write normal text only (no ANSI chars).

<!-- __________________________________________________________________________/ }}}1 -->
<!-- plotting ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1 -->

## Plotting in terminal

Function `dotPlot` uses Braille dots to produce simple dot-plots (individual points are NOT drawn as connected).
Returned value is string.

Example usage:
```hy
(setv plot 
    (dotPlot [[1 2] [3 4] [3 7]]
             :xsize 10 ; size is measured in term chars
             :ysize 5  ; size is measured in term chars
             :frame True ; adds rectangle frame with min-max ranges
             :xmin  None ; None means it will be auto-calculated
             :xmax  None
             :ymin  0.
             :ymax  10.)) ; returns multiline string

(print plot)
```

Example drawing of Sin function (github renders Braille not as monospace lol, but in real terminal all should look aligned):
```
 __________
⎟⢠⠋⡇    ⡎⢣ ⎜
⎟⡜ ⢸   ⢸ ⠈⡆⎜
⎟⠁  ⡇  ⡇  ⢣⎜
⎟   ⢱ ⢰⠁  ⠸⎜
⎟   ⠈⣆⡞    ⎜
 ‾‾‾‾‾‾‾‾‾‾
```


<!-- __________________________________________________________________________/ }}}1 -->

