
    (defmacro load_fptk [#* args]
        (setv actions [])
        (when (in '"core" args)
              (actions.append `(import  fptk.core *)) 
              (actions.append `(require fptk.core *)))
        ;
        (when (in '"lenses" args)
              (actions.append `(import  fptk.lenses *))
              (actions.append `(require fptk.lenses *)))
        ;
        (when (in '"strict_types" args)
              (actions.append `(import  fptk.strict.types *)))
        (when (in '"strict_monads" args)
              (actions.append `(import  fptk.strict.monads *)))
        (when (in '"strict_resultM" args)
              (actions.append `(import  fptk.strict.monads.resultM *)))
        (when (in '"strict_maybeM" args)
              (actions.append `(import  fptk.strict.monads.maybeM *)))
        ;
       `(do ~@ actions))

        
