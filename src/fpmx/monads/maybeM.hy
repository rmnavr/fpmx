;: WARNING! THIS FILE IS CODEGENED! Edit source strict-version of it instead.

; Import/Export ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import dataclasses [dataclass]); [NSMG_LOG: This line was replaced]
    ; [NSMG_LOG: This line was cleared]

    (import typing [TypeVar Generic Union])
    (import enum [Enum])
    (import funcy [rcompose lmap partial])
    (require fpmx.prelude.from_hyrule [of unless])

    (export :objects [Maybe Just Nothing justQ nothingQ liftM liftM2 liftM3 bindM bindM2 bindM3 unwrapJ unwrapJ_or])

; _____________________________________________________________________________/ }}}1

; Classes ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv J (TypeVar "J"))

    (defclass [dataclass] _Just [(of Generic J)]; [NSMG_LOG: This line was replaced]
        #^ J value
        (defn __str__ [self] (+ "Just: " (str self.value)))
        (defn __repr__ [self] (self.__str__)))

    (defclass [dataclass] _Nothing []; [NSMG_LOG: This line was replaced]
        (defn __str__ [self] "Nothing")
        (defn __repr__ [self] (self.__str__)))

    (defclass [dataclass] Maybe [(of Generic J)]; [NSMG_LOG: This line was replaced]
        #^ (of Union (of _Just J) _Nothing) container
        (defn __str__ [self] (+ "<Mb." (str self.container) ">"))
        (defn __repr__ [self] (self.__str__)))

    (defn Just [value] (Maybe :container (_Just :value value)))
    (setv Nothing (Maybe :container (_Nothing)))

; _____________________________________________________________________________/ }}}1

; utils: error msgs ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defclass ERR [Enum]
        (setv NON_MONAD (fn [%obj] (TypeError f"Maybe-monad operations (like justQ/unwarpJ/...) work only on Maybe types. Instead {%obj} of type {(type %obj)} was provided.")))
        (setv LIFT (fn [%obj] (TypeError f"liftM works only on Maybe types. Instead {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_M (fn [%obj] (TypeError f"bindM works only on Maybe types. Instead {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_F (fn [%f %ret] (TypeError f"bindM works only with monadic functions (those that return Maybe). Instead {%f}, which tried to return {%ret} of type {(type %ret)} was provided.")))
        (setv UNWRAP (fn [%obj] (TypeError f"Can't unwarp {%obj} since it is Nothing"))))

; _____________________________________________________________________________/ }}}1
; utils: justQ/nothingQ ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ bool justQ [#^ Maybe maybeM]
        (unless (isinstance maybeM Maybe) (raise (ERR.NON_MONAD maybeM )))
        (isinstance maybeM.container _Just))

    (defn #^ bool nothingQ [#^ Maybe maybeM]
        (unless (isinstance maybeM Maybe) (raise (ERR.NON_MONAD maybeM )))
        (isinstance maybeM.container _Nothing))

; _____________________________________________________________________________/ }}}1
; utils: mapM/bindM ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ Maybe liftM [#^ Maybe maybeM #* fs]
        (unless (isinstance maybeM Maybe) (raise (ERR.LIFT maybeM )))
        (when (isinstance maybeM.container _Nothing) (return Nothing)); avoids nothingQ to not trigger it's additional check
        (return (Just ((rcompose #* fs) maybeM.container.value ))))

    (defn #^ Maybe liftM2 [#^ Maybe maybeM1 #^ Maybe maybeM2 func]
        (unless (isinstance maybeM1 Maybe) (raise (ERR.LIFT maybeM1 )))
        (unless (isinstance maybeM2 Maybe) (raise (ERR.LIFT maybeM2 )))
        (when (isinstance maybeM1.container _Nothing) (return Nothing))
        (when (isinstance maybeM2.container _Nothing) (return Nothing))
        (return (Just (func maybeM1.container.value maybeM2.container.value ))))

    (defn #^ Maybe liftM3 [#^ Maybe maybeM1 #^ Maybe maybeM2 #^ Maybe maybeM3 func]
        (unless (isinstance maybeM1 Maybe) (raise (ERR.LIFT maybeM1 )))
        (unless (isinstance maybeM2 Maybe) (raise (ERR.LIFT maybeM2 )))
        (unless (isinstance maybeM3 Maybe) (raise (ERR.LIFT maybeM3 )))
        (when (isinstance maybeM1.container _Nothing) (return Nothing))
        (when (isinstance maybeM2.container _Nothing) (return Nothing))
        (when (isinstance maybeM3.container _Nothing) (return Nothing))
        (return (Just (func maybeM1.container.value maybeM2.container.value maybeM3.container.value ))))

    ; ======================================

    (defn #^ Maybe bindM [#^ Maybe maybeM #* fs]
        (unless (isinstance maybeM Maybe) (raise (ERR.BIND_M maybeM )))
        (setv _fs (lmap (fn [it] (partial _bindM1 it)) fs))
        ( (rcompose #* _fs) maybeM))

    (defn #^ Maybe _bindM1 [func #^ Maybe maybeM]
        (when (isinstance maybeM.container _Nothing) (return Nothing)); no isMaybe check is needed since bindM covers it
        (setv new_maybe (func maybeM.container.value))
        (unless (isinstance new_maybe Maybe) (raise (ERR.BIND_F func new_maybe )))
        (return new_maybe))

    (defn #^ Maybe bindM2 [#^ Maybe maybeM1 #^ Maybe maybeM2 func]
        (unless (isinstance maybeM1 Maybe) (raise (ERR.BIND_M maybeM1 )))
        (unless (isinstance maybeM2 Maybe) (raise (ERR.BIND_M maybeM2 )))
        (when (isinstance maybeM1.container _Nothing) (return Nothing))
        (when (isinstance maybeM2.container _Nothing) (return Nothing))
        ;
        (setv new_maybe (func maybeM1.container.value maybeM2.container.value))
        (unless (isinstance new_maybe Maybe) (raise (ERR.BIND_F func new_maybe )))
        (return new_maybe))

    (defn #^ Maybe bindM3 [#^ Maybe maybeM1 #^ Maybe maybeM2 #^ Maybe maybeM3 func]
        (unless (isinstance maybeM1 Maybe) (raise (ERR.BIND_M maybeM1 )))
        (unless (isinstance maybeM2 Maybe) (raise (ERR.BIND_M maybeM2 )))
        (unless (isinstance maybeM3 Maybe) (raise (ERR.BIND_M maybeM3 )))
        (when (isinstance maybeM1.container _Nothing) (return Nothing))
        (when (isinstance maybeM2.container _Nothing) (return Nothing))
        (when (isinstance maybeM3.container _Nothing) (return Nothing))
        ;
        (setv new_maybe (func maybeM1.container.value maybeM2.container.value maybeM3.container.value))
        (unless (isinstance new_maybe Maybe) (raise (ERR.BIND_F func new_maybe )))
        (return new_maybe))

; _____________________________________________________________________________/ }}}1
; utils: unwrapping ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ J unwrapJ [#^ (of Maybe J) maybeM]
        "throws error on Nothing"
        (unless (isinstance maybeM Maybe) (raise (ERR.NON_MONAD maybeM )))
        (if (isinstance maybeM.container _Just)
             (return maybeM.container.value)
             (raise (ERR.UNWRAP maybeM))))

    (defn unwrapJ_or [#^ (of Maybe J) maybeM default]
        (unless (isinstance maybeM Maybe) (raise (ERR.NON_MONAD maybeM )))
        (if (isinstance maybeM.container _Just)
             (return maybeM.container.value)
             (return default)))

; _____________________________________________________________________________/ }}}1