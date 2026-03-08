
    (require fptk.loader [load_fptk])
    (load_fptk "core" "term")
    (import termcolor [colored])

    (assertm eq (clrz "Pups" ["red"])
               (colored "Pups" "red"))

    (assertm eq (clrz "Pups" ["on_blue" "red"])
               (colored "Pups" "red" "on_blue"))

    (assertm eq (clrz "Pups" ["reverse"])
               (colored "Pups" None None ["reverses"]))

    (assertm gives_error_typeQ (clrz "Pups" "bad_color") ValueError)