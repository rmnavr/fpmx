
    (require fpmx.loader [load_fpmx])
    (load_fpmx "prelude" "term")
    (import termcolor [colored])

; clrz ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (assertm eq (clrz "Pups" ["red"])
               (colored "Pups" "red"))

    (assertm eq (clrz "Pups" ["on_blue" "red"])
               (colored "Pups" "red" "on_blue"))

    (assertm eq (clrz "Pups" ["reverse"])
               (colored "Pups" None None ["reverse"]))

    (assertm gives_error_typeQ (clrz "Pups" "bad_color") ValueError)

; _____________________________________________________________________________/ }}}1