
    (defmacro load_fptk [#* args]
        (setv actions [])
        (when (in '"core" args)
              (actions.append `(import  fptk_local.core *)) 
              (actions.append `(require fptk_local.core *)))
        ;
        (when (in '"lenses" args)
              (actions.append `(import  fptk_local.lenses *))
              (actions.append `(require fptk_local.lenses *)))
        ;
        (when (in '"strict_types" args)
              (actions.append `(import  fptk_local.strict.types *)))
        (when (in '"strict_monads" args)
              (actions.append `(import  fptk_local.strict.monads *)))
        (when (in '"strict_resultM" args)
              (actions.append `(import  fptk_local.strict.monads.resultM *)))
        (when (in '"strict_maybeM" args)
              (actions.append `(import  fptk_local.strict.monads.maybeM *)))
        ;
       `(do ~@ actions))

        
