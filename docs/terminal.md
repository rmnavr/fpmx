
# Utils for terminal

Calling... 
```hy
(import  fptk.term.colors *) 
(import  fptk.term.dotplot *) 

; or simply:
(require fptk.loader [load_fptk])
(load_fptk "term")
```

...will expose following functions:
* `clrz`
* `clrz_term_test`
* `dotPlot`

# Coloring

fptk offers simple adapter `clrz` for `termcolor.colored` function
Unlike original `termcolor.colored`, in `clrz` you can provide color instructions in arbitrary order.

You can also color-check your terminal using `clrz_term_test`.

```python
# Examples:

clrz('text', ['blue', 'on_red', 'reverse'])
clrz('text', ['blue'])
clrz('text', ['on_red'])

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

## Plotting in terminal

Function `dotPlot` uses Braille dots to print simple dot-plots (individual points are NOT drawn as connected).

Example usage:
```
    (dotPlot [[1 2] [3 4] [3 7]]
             :xsize 10 ; size is measured in term chars
             :ysize 5  ; size is measured in term chars
             :xmin  None ; None means it will be auto-calculated
             :xmax  None
             :ymin  0.
             :ymax  10.)
```


Example drawing:
```
 __________
⎟⢠⠋⡇    ⡎⢣ ⎜
⎟⡜ ⢸   ⢸ ⠈⡆⎜
⎟⠁  ⡇  ⡇  ⢣⎜
⎟   ⢱ ⢰⠁  ⠸⎜
⎟   ⠈⣆⡞    ⎜
 ‾‾‾‾‾‾‾‾‾‾
```

