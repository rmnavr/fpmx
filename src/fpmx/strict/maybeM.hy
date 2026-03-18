; [NSMG_INSTRUCTION: WRITE_NONSOURCE_WARNING]

; Import/Export ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import pydantic [BaseModel]); [NSMG_INSTRUCTION: REPLACE_WITH]    import  dataclasses [dataclass]
                                    ; [NSMG_INSTRUCTION: CLEAR_THIS_LINE]

    (require fpmx.prelude.from_hyrule [of unless])
    (import typing [TypeVar Generic Union])
    (import enum [Enum])
    (import funcy [rcompose lmap partial])

    (export :objects [Maybe Just Nothing justQ nothingQ])

; _____________________________________________________________________________/ }}}1

; Error msgs ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defclass ERR [Enum]
        (setv NON_MONAD (fn [%obj] (TypeError f"Maybe-monad checks (justQ/nothingQ) work only on Maybe types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv FMAP (fn [%obj] (TypeError f"fmap works only on Maybe types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_M (fn [%obj] (TypeError f"bind works only on Maybe types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_F (fn [%f %ret] (TypeError f"bind works only with monadic functions (those that return Maybe). Instead: {%f}, which tried to return {%ret} of type {(type %ret)} was provided.")))
        (setv UNWRAP (fn [%obj] (TypeError f"Can't unwarp {%obj} since it is Nothing"))))

; _____________________________________________________________________________/ }}}1
; Classes ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv J (TypeVar "J"))

    (defclass _Just [BaseModel (of Generic J)]; [NSMG_INSTRUCTION: REPLACE_WITH]    defclass [dataclass] _Just [(of Generic J)]
        #^ J value
        (defn __str__ [self] (+ "Just: " (str self.value)))
        (defn __repr__ [self] (self.__str__)))

    (defclass _Nothing [BaseModel]; [NSMG_INSTRUCTION: REPLACE_WITH]    defclass [dataclass] _Nothing []
        (defn __str__ [self] "Nothing")
        (defn __repr__ [self] (self.__str__)))

    (defclass Maybe [BaseModel (of Generic J)]; [NSMG_INSTRUCTION: REPLACE_WITH]    defclass [dataclass] Maybe [(of Generic J)]
        #^ (of Union (of _Just J) _Nothing) container
        (defn __str__ [self] (+ "<Mb." (str self.container) ">"))
        (defn __repr__ [self] (self.__str__))
        ;
        (defn fmap [self func #* monads]
            (for [&m monads] (unless (isinstance &m Maybe) (raise (ERR.FMAP &m ))))
            (when (isinstance self.container _Nothing) (return Nothing))
            (for [&m monads] (when (isinstance &m.container _Nothing) (return Nothing )))
            (return (Just (func self.container.value #* (lfor &m monads &m.container.value) ))))
        ;
        (defn bind [self func #* monads]
            (for [&m monads] (unless (isinstance &m Maybe) (raise (ERR.BIND_M &m ))))
            (for [&m monads] (when (isinstance &m.container _Nothing) (return Nothing )))
            (when (isinstance self.container _Nothing) (return Nothing))
            (setv new_maybe (func self.container.value #* (lfor &m monads &m.container.value)))
            (unless (isinstance new_maybe Maybe) (raise (ERR.BIND_F func new_maybe )))
            (return new_maybe))
        ;
        (defn unwrap [self]
            (if (isinstance self.container _Just)
                 (return self.container.value)
                 (raise (ERR.UNWRAP self))))
        ;
        (defn unwrap_or [self default]
            (if (isinstance self.container _Just)
                 (return self.container.value)
                 (return default))))

    (defn Just [value] (Maybe :container (_Just :value value)))
    (setv Nothing (Maybe :container (_Nothing)))

; _____________________________________________________________________________/ }}}1
; justQ/nothingQ ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ bool justQ [#^ Maybe maybeM]
        (unless (isinstance maybeM Maybe)
            (raise (ERR.NON_MONAD maybeM)))
        (isinstance maybeM.container _Just))

    (defn #^ bool nothingQ [#^ Maybe maybeM]
        (unless (isinstance maybeM Maybe)
            (raise (ERR.NON_MONAD maybeM)))
        (isinstance maybeM.container _Nothing))

; _____________________________________________________________________________/ }}}1
