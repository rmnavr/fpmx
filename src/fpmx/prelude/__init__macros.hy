
    (require fpmx.prelude.from_hyrule [
        of                  #_ "[GROUP] G06: Typing             | | example: (of List int) which is equiv to py-code: List[int]"
        comment             #_ "[GROUP] G93: Misc               | |"
        ncut                #_ "[GROUP] G05: Getters            | |"
        case                #_ "[GROUP] G09: FP                 | |"
        unless              #_ "[GROUP] G09: FP                 | |"
        lif                 #_ "[GROUP] G09: FP                 | |"
        branch              #_ "[GROUP] G09: FP                 | |"
        ->                  #_ "[GROUP] G09: FP                 | |"
        ->>                 #_ "[GROUP] G09: FP                 | |"
        as->                #_ "[GROUP] G09: FP                 | |"
        doto                #_ "[GROUP] G09: FP                 | | mutating"
        do_n                #_ "[GROUP] G09: FP                 | (do_n   n #* body) -> None | expands to ~ (do body body body ...)"
        list_n              #_ "[GROUP] G09: FP                 | (list_n n #* body) -> List |"
    ])

    (require fpmx.prelude.macros [
        def::               #_ "[GROUP] G06: Typing             | | example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]"
        f::                 #_ "[GROUP] G06: Typing             | | define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))"
        fm                  #_ "[GROUP] G09: FP                 | (fm (* it 3)) | anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'"
        f>                  #_ "[GROUP] G09: FP                 | (f> (* it 3) 4) | anonymous function with fm syntax, immediately applicates args"
        mapm                #_ "[GROUP] G09: FP                 | | same as map, but expects fm-syntax for func"
        lmapm               #_ "[GROUP] G09: FP                 | | same as lmap, but expects fm-syntax for func"
        filterm             #_ "[GROUP] G08: APL                | (filterm f xs)  | same as filter, but expects fm-syntax for func"
        lfilterm            #_ "[GROUP] G08: APL                | (lfilterm f xs) | list version of lfilterm"
        =>                  #_ "[GROUP] G09: FP                 | | unification of dot-macro and ->"
        =>>                 #_ "[GROUP] G09: FP                 | | unification of dot-macro and ->>"
        p:                  #_ "[GROUP] G09: FP                 | | aplicator, pipe of partials"
        pluckm              #_ "[GROUP] G05: Getters            | (pluckm n xs) (pluckm key ys) (pluckm .attr zs) | accepts fpmx-style .arg syntax"
        lpluckm             #_ "[GROUP] G05: Getters            | | list version of pluckm"
        getattrm            #_ "[GROUP] G05: Getters            | (getattrm Object 'attr') (getattrm Object .attr) | accepts fpmx-style .attr syntax"
        timing              #_ "[GROUP] G91: Benchmarking       | (timing expr1 expr2 ...) -> #(float, Any) | returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)"
        assertm             #_ "[GROUP] G92: Testing            | (assertm op arg1 arg2) | tests if (op arg1 arg2), for example (= 1 1)"
        gives_error_typeQ   #_ "[GROUP] G92: Testing            | | example: (assertm gives_error_typeQ (get [1] 2) IndexError)"
     ])

     ; lns macros are defined in macros.hy, yes, but not imported into prelude

