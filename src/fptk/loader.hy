
    (defmacro load_fptk [#* args]
        (setv actions [])
        (when (in '"core" args)
              (actions.append `(import  fptk.core *)) 
              (actions.append `(require fptk.core *)))
        ;
        (when (in '"lens" args)
              (actions.append `(import  fptk.lenses *))
              (actions.append `(require fptk.lenses *)))
        ;
        (when (in '"strict" args)
              (actions.append `(import  fptk.strict.types *)))
        (when (in '"monads" args)
              (actions.append `(import  fptk.strict.monads *)))
        (when (in '"resultM" args)
              (actions.append `(import  fptk.strict.monads.resultM *)))
        (when (in '"maybeM" args)
              (actions.append `(import  fptk.strict.monads.maybeM *)))
        ;
       `(do ~@ actions))

        
