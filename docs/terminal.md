
# Utils for terminal

Calling... 
```hy
(import  fpmx.term.colors *) 
(import  fpmx.term.dotplot *) 

; or simply:
(require fpmx.loader [load_fpmx])
(load_fpmx "term")
```

...will expose following functions:
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
clrz(['on_red'], 'text')

clrz_term_test()
```

Available instructions are the same as for original `termcolor.colored`:
```
Foregrounds:
    black red green yellow blue magenta cyan white
    light_grey dark_grey light_red light_green light_yellow
    light_blue light_magenta light_cyan

Backgrounds:
    on_black on_red on_green on_yellow on_blue on_magenta on_cyan on_white
    on_light_grey on_dark_grey on_light_red on_light_green
    on_light_yellow on_light_blue on_light_magenta on_light_cyan

Attrs:
    bold dark underline blink reverse concealed strike
```

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

