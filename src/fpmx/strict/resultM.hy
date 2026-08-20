; [NSMG_INSTRUCTION: WRITE_NONSOURCE_WARNING]

; Import/Export ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import pydantic [BaseModel]); [NSMG_INSTRUCTION: REPLACE_WITH]    import  dataclasses [dataclass]
                                    ; [NSMG_INSTRUCTION: CLEAR_THIS_LINE]

    (require fpmx.prelude.from_hyrule [of unless])
    (import typing [TypeVar Generic Union])
    (import enum [Enum])

    (export :objects [ Result Success Failure successQ failureQ
                       fmapR bindR unwrapS unwrapS_or unwrapF unwrapF_or ])


; _____________________________________________________________________________/ }}}1

; Error msgs ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defclass ERR [Enum]
        (setv NON_MONAD (fn [%obj] (TypeError f"Result-monad checks (successQ/failureQ) work only on Result types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv FMAP (fn [%obj] (TypeError f"fmap works only on Result types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_M (fn [%obj] (TypeError f"bind works only on Result types. Instead: {%obj} of type {(type %obj)} was provided.")))
        (setv BIND_F (fn [%f %ret] (TypeError f"bind works only with monadic functions (those that return Result). Instead: {%f}, which tried to return {%ret} of type {(type %ret)} was provided.")))
        (setv UNWRAP_S (fn [%obj] (TypeError f"Can't unwarp {%obj} since it is Failure (while Success was expected)")))
        (setv UNWRAP_F (fn [%obj] (TypeError f"Can't unwarp {%obj} since it is Success (while Failure was expected)"))))

; _____________________________________________________________________________/ }}}1
; Classes ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv S (TypeVar "S"))
    (setv F (TypeVar "F"))

    (defclass _Failure [BaseModel (of Generic F)]; [NSMG_INSTRUCTION: REPLACE_WITH]    defclass [dataclass] _Failure [(of Generic F)]
        #^ F value
        ;
        (defn __str__ [self] (+ "Failure: " (str self.value)))
        (defn __repr__ [self] (self.__str__)))

    (defclass _Success [BaseModel (of Generic S)]; [NSMG_INSTRUCTION: REPLACE_WITH]    defclass [dataclass] _Success [(of Generic S)]
        #^ S value
        ;
        (defn __str__ [self] (+ "Success: " (str self.value)))
        (defn __repr__ [self] (self.__str__)))

    (defclass Result [BaseModel (of Generic S F)]; [NSMG_INSTRUCTION: REPLACE_WITH]    defclass [dataclass] Result [(of Generic S F)]
        #^ (of Union (of _Success S) (of _Failure F)) container
        (defn [property] value [self] self.container.value)
        ;
        (defn __str__ [self] (+ "<R." (str self.container) ">"))
        (defn __repr__ [self] (self.__str__)))

    (defn Failure [value] (Result :container (_Failure :value value)))
    (defn Success [value] (Result :container (_Success :value value)))

; _____________________________________________________________________________/ }}}1
; Functions ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ bool failureQ [#^ Result resultM]
        (unless (isinstance resultM Result)
            (raise (ERR.NON_MONAD resultM)))
        (isinstance resultM.container _Failure))

    (defn #^ bool successQ [#^ Result resultM]
        (unless (isinstance resultM Result)
            (raise (ERR.NON_MONAD resultM)))
        (isinstance resultM.container _Success))

    (defn fmapR [monad0 func #* monads]
        ; check arg type correctness:
        (for [&m (+ #(monad0) monads)]
            (unless (isinstance &m Result)
                     (raise (ERR.FMAP &m))))
        ; short-circuit:
        (for [&m (+ #(monad0) monads)]
            (when (isinstance &m.container _Failure)
                   (return &m)))
        (return
            (Success (func monad0.container.value #* (lfor &m monads &m.container.value)))))

    (defn bindR [monad0 func #* monads]
        ; check arg type corretness:
        (for [&m (+ #(monad0) monads)]
            (unless (isinstance &m Result)
                     (raise (ERR.BIND_M &m))))
        ; short-circuit:
        (for [&m (+ #(monad0) monads)]
            (when (isinstance &m.container _Failure)
                   (return &m)))
        ;
        (setv new_result
            (func monad0.container.value #* (lfor &m monads &m.container.value)))
        ; check return-type of 'func':
        (unless (isinstance new_result Result)
                 (raise (ERR.BIND_F func new_result)))
        ;
        (return new_result))

    (defn unwrapS [resultM]
        (if (isinstance resultM.container _Success)
             (return resultM.container.value)
             (raise (ERR.UNWRAP_S resultM))))

    (defn unwrapS_or [resultM default]
        (if (isinstance resultM.container _Success)
             (return resultM.container.value)
             (return default)))

    (defn unwrapF [resultM]
        (if (isinstance resultM.container _Failure)
             (return resultM.container.value)
             (raise (ERR.UNWRAP_F resultM))))

    (defn unwrapF_or [resultM default]
        (if (isinstance resultM.container _Failure)
             (return resultM.container.value)
             (return default)))

; _____________________________________________________________________________/ }}}1
