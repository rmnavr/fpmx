
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
        (when (in '"maybeM" args)
              (actions.append `(import  fptk.monads.maybeM *)))
        (when (in '"resultM" args)
              (actions.append `(import  fptk.monads.resultM *)))
        ;
        (when (in '"strict_types" args)
              (actions.append `(import  fptk.strict.types *)))
        (when (in '"resultM_strict" args)
              (actions.append `(import  fptk.strict.resultM *)))
        (when (in '"maybeM_strict" args)
              (actions.append `(import  fptk.strict.maybeM *)))
        ;
       `(do ~@ actions))

        
