
; Info ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; Issues:
    ; - (colored "pups" #(70 220 70)) works in hy.exe,
    ;   but in ipython gives bad colors (but ipython supports all colors, wtf!)

; _____________________________________________________________________________/ }}}1
; Import and Export ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import typing [List])
    (import funcy [last])
    (require fpmx.prelude.from_hyrule [of])
    (import termcolor [colored])

    (export :objects [clrz clrz_term_test])

; _____________________________________________________________________________/ }}}1

; [C] Available fore/back/attr options ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $FORES
        [ "black" "red" "green" "yellow" "blue"
          "magenta" "cyan" "white" "light_grey"
          "dark_grey" "light_red" "light_green"
          "light_yellow" "light_blue" "light_magenta" "light_cyan"])

    (setv $BACKS
        [ "on_black" "on_red" "on_green" "on_yellow"
          "on_blue" "on_magenta" "on_cyan" "on_white"
          "on_light_grey" "on_dark_grey" "on_light_red" "on_light_green"
          "on_light_yellow" "on_light_blue" "on_light_magenta" "on_light_cyan"])

    (setv $ATTRS
        [ "bold" "dark" "underline" "blink" "reverse" "concealed" "strike"])

    (setv $ALL (+ $FORES $BACKS $ATTRS))

; _____________________________________________________________________________/ }}}1
; [F] clrz ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ str clrz
        [ #^ (of List str) instructions
          #^ str text
          * #^ bool [force_color False]]
        " Example:
          >> clrz('text', ['blue', 'on_red', 'reverse'])

          Order in list is not important, however only last option
          from same group will be used:
          >> clrz(['blue', 'red'], 'some text')
          >> ... will draw with red ...

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
        "
        (setv bad_instructions (- (set instructions) (set $ALL)))
        (when bad_instructions
             (raise (ValueError f"Incorrect colors in clrz function: {bad_instructions}\nCall help(clrz) to see correct colors")))
        ;
        (setv fore (last (list (filter (fn [it] (in it $FORES)) instructions )))); may be None
        (setv back (last (list (filter (fn [it] (in it $BACKS)) instructions )))); may be None
        (setv attrs (list (filter (fn [it] (in it $ATTRS)) instructions ))); may be []
        (return (colored text fore back :attrs attrs :force_color force_color)))

; _____________________________________________________________________________/ }}}1
; [F] crlz_term_test ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn clrz_term_test []
        (setv fores
            (map (fn [it] (+ (clrz [it] it) " " ))
                  $FORES))
        (setv backs
            (map (fn [it] (+ (clrz [it] it) " " ))
                  $BACKS))
        (setv attrs
            (map (fn [it] (+ (clrz [it] it) " " ))
                  $ATTRS))
        (print "=== Foreground colors ===")
        (print (+ #* (list fores )))
        (print "\n=== Background colors ===")
        (print (+ #* (list backs )))
        (print "\n=== Attributes ===")
        (print (+ #* (list attrs ))))

; _____________________________________________________________________________/ }}}1
