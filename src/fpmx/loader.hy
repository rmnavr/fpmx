
    (defmacro load_fpmx [#* args]
        (setv actions [])
        ;
        (setv _all_options [ '"prelude" '"lenses"
                                                    '"maybeM"        '"resultM"        '"writerMaybeT"
                             '"strict_types" '"strict_maybeM" '"strict_resultM" '"strict_writerMaybeT"
                             '"term"])
        (setv _unrecognized_options (list (- (set args) (set _all_options))))
        (setv _msg `(+ "fpmx loader didn't recognize following modules: " (str ~_unrecognized_options) "\n\n"
                      "Available modules: " (str ~_all_options)))
        (when (> (len _unrecognized_options) 0)
              (actions.append `(raise (ValueError ~_msg))))
        ; prelude:
        (when (in '"prelude" args)
              (actions.append `(import  fpmx.prelude *)) 
              (actions.append `(require fpmx.prelude *)))
        ; lenses:
        (when (in '"lenses" args)
              (actions.append `(import  fpmx.lenses *))
              (actions.append `(require fpmx.lenses *)))
        ; pydantic:
        (when (in '"strict_types" args)
              (actions.append `(import  fpmx.strict.types *)))
        ; strict monads:
        (when (in '"strict_maybeM" args)
              (actions.append `(import  fpmx.strict.maybeM *)))
        (when (in '"strict_resultM" args)
              (actions.append `(import  fpmx.strict.resultM *)))
        (when (in '"strict_writerMaybeT" args)
              (actions.append `(import  fpmx.strict.maybeWriterT *)))
        ; non-strict monads:
        (when (in '"maybeM" args)
              (actions.append `(import  fpmx.monads.maybeM *)))
        (when (in '"resultM" args)
              (actions.append `(import  fpmx.monads.resultM *)))
        (when (in '"writerMaybeT" args)
              (actions.append `(import  fpmx.monads.maybeWriterT *)))
        ; terminal:
        (when (in '"term" args)
              (actions.append `(import  fpmx.term.colors *))
              (actions.append `(import  fpmx.term.dotplot *)))
        ;
       `(do ~@ actions))

