;: WARNING! THIS FILE IS CODEGENED! Edit source strict-version of it instead.

; Import/Export ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import dataclasses [dataclass]); [NSMG_LOG: This line was replaced]
    ; [NSMG_LOG: This line was cleared]

    (require fpmx.prelude.from_hyrule [of unless])
    (import typing [TypeVar Generic Union Tuple List])
    (import enum [Enum])

    (export :objects [MaybeWriter WJust WNothing wJustQ wNothingQ])

; _____________________________________________________________________________/ }}}1

; Error msgs ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defclass ERR [Enum]
        (setv NON_MONAD (fn [%obj] (TypeError f"Transformer checks (wJustQ/wNothingQ) work only on MaybeWriter types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv FMAP (fn [%obj] (TypeError f"fmap works only on MaybeWriter types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_M (fn [%obj] (TypeError f"bind works only on MaybeWriter types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_F (fn [%f %ret] (TypeError f"bind works only with transformer functions (those that return MaybeWriter). Instead: {%f}, which tried to return {%ret} of type {(type %ret)} was provided.")))
        (setv UNWRAP (fn [%obj] (TypeError f"Can't unwarp {%obj} since it is WNothing (while WJust was expected)"))))

; _____________________________________________________________________________/ }}}1
; Classes ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv J (TypeVar "J"))
    (setv W (TypeVar "W"))
    ; example: (of MaybeWriter int str) for log of form ["smth1" "smth2"]

    (defclass [dataclass] _WJust [(of Generic J W)]; [NSMG_LOG: This line was replaced]
        #^ J value
        #^ (of List W) log_
        ;
        (defn __str__ [self] f"Just: val = {self.value}, log = {self.log_}")
        (defn __repr__ [self] (self.__str__)))

    (defclass [dataclass] _WNothing [(of Generic W)]; [NSMG_LOG: This line was replaced]
        #^ (of List W) log_
        (defn __str__ [self] f"Nothing: log = {self.log_}")
        (defn __repr__ [self] (self.__str__)))

    (defclass [dataclass] MaybeWriter [(of Generic J W)]; [NSMG_LOG: This line was replaced]
        #^ (of Union (of _WJust J W) (of _WNothing W)) container
        (defn __str__ [self] f"<MaybeWriter.{self.container}>")
        (defn __repr__ [self] (self.__str__))
        ;
        (defn ask [self]
            (return self.container.log_))
        ;
        (defn tell [self log_]
            "won't do anything when Nothing is inside"
            (when (isinstance self.container _WNothing) (return self))
            (setv new_mw self)
            (setv new_mw.container.log_ (+ new_mw.container.log_ log_))
            (return new_mw))
        ;
        (defn fmap [self func #* transformers]
            "won't add logs if Nothing monad is encountered anywhere"
            (for [&t transformers] (unless (isinstance &t MaybeWriter) (raise (ERR.FMAP &t ))))
            (for [&t transformers]
                (when (isinstance &t.container _WNothing)
                       (return (MaybeWriter :container (_WNothing :log_ self.container.log_)))))
            (when (isinstance self.container _WNothing) (return self))
            ;
            (setv new_val (func self.container.value #* (lfor &t transformers &t.container.value)))
            (setv new_log (+ [] self.container.log_ #* (lfor &t transformers &t.container.log_)))
            ; extra [] to avoid unary usage of '+'
            (return (MaybeWriter :container (_WJust :value new_val :log_ new_log))))
        ;
        (defn bind [self func #* transformers]
            "if any of transformers is Nothing, logs are not concatenated;
             but if func returns Nothing, all logs are still concatenated
            "
            (for [&t transformers] (unless (isinstance &t MaybeWriter) (raise (ERR.BIND_M &t ))))
            (for [&t transformers]
                (when (isinstance &t.container _WNothing)
                       (return (MaybeWriter :container (_WNothing :log_ self.container.log_)))))
            (when (isinstance self.container _WNothing) (return self))
            ;
            (setv new_mw (func self.container.value #* (lfor &t transformers &t.container.value)))
            (unless (isinstance new_mw MaybeWriter) (raise (ERR.BIND_F func new_mw )))
            ;
            (setv new_mw.container.log_
                (+ self.container.log_
                  #* (lfor &t transformers &t.container.log_)
                  new_mw.container.log_))
            (return new_mw))
        ;
        (defn unwrap [self]
            (if (isinstance self.container _WJust)
                 (return #(self.container.value self.container.log_))
                 (raise (ERR.UNWRAP self))))
        ;
        (defn unwrap_or [self default]
            (if (isinstance self.container _WJust)
                 (return #(self.container.value self.container.log_))
                 (return #(default self.container.log_)))))

    (defn WJust [value #^ List log_] (MaybeWriter :container (_WJust    :value value :log_ log_)))
    (defn WNothing [      #^ List log_] (MaybeWriter :container (_WNothing              :log_ log_)))

; _____________________________________________________________________________/ }}}1
; wJustQ/wNothingQ ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ bool wJustQ [#^ MaybeWriter mw]
        (unless (isinstance mw MaybeWriter) (raise (ERR.NON_MONAD mw )))
        (isinstance mw.container _WJust))

    (defn #^ bool wNothingQ [#^ MaybeWriter mw]
        (unless (isinstance mw MaybeWriter) (raise (ERR.NON_MONAD mw )))
        (isinstance mw.container _WNothing))

; _____________________________________________________________________________/ }}}1