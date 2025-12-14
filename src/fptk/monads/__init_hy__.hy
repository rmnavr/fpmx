    
    ; this reimports-file exists, to make resultM.wy (and similar)
    ; convenient for cur docgen script

; [GROUP] Monad: Maybe ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import fptk.monads.maybeM  [Maybe     ]) #_ "| Maybe monad. Should be used in annotations only"
    (import fptk.monads.maybeM  [Just      ]) #_ "| Just container of Maybe monad" 
    (import fptk.monads.maybeM  [Nothing   ]) #_ "| Nothing of Maybe monad"

    (import fptk.monads.maybeM  [justQ     ]) #_ "justQ(maybeValue) -> bool | throws error when used not on Maybe type"
    (import fptk.monads.maybeM  [nothingQ  ]) #_ "justQ(maybeValue) -> bool | throws error when used not on Maybe type"

    (import fptk.monads.maybeM  [mapM      ]) #_ "mapM(maybeVal, pureF1, pureF2, ...) -> Maybe | apply pure function to value stored in Maybe, do nothing for Nothing"
    (import fptk.monads.maybeM  [bindM     ]) #_ "bindM(maybeVal, mF1, mF2, ...) -> Maybe | apply monadic (f :: val -> maybe) to Just, do nothing for Nothing"

    (import fptk.monads.maybeM  [unwrapM   ]) #_ "returns contained Just value or throws error when not Just"
    (import fptk.monads.maybeM  [unwrapM_or]) #_ "returns contained Just value or falls back to default"

; _____________________________________________________________________________/ }}}1
; [GROUP] Monad: Result ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import fptk.monads.resultM [Result    ]) #_ "| Result monad. Should be used in annotations only"
    (import fptk.monads.resultM [Success   ]) #_ "| Success container of Result monad" 
    (import fptk.monads.resultM [Failure   ]) #_ "| Failure container of Result monad"

    (import fptk.monads.resultM [successQ  ]) #_ "successQ(result) -> bool | throws error when used not on Result type"
    (import fptk.monads.resultM [failureQ  ]) #_ "failureQ(result) -> bool | throws error when used not on Result type"

    (import fptk.monads.resultM [mapR      ]) #_ "mapR(result, pureF1, pureF2, ...) -> Result | apply pure function to value stored in Success, do nothing for Failure"
    (import fptk.monads.resultM [bindR     ]) #_ "bindR(result, mF1, mF2, ...) -> Result | apply monadic (f :: val -> Result) to Success, do nothing for Failure"

    (import fptk.monads.resultM [unwrapR   ]) #_ "returns contained Success value or throws error when not Success"
    (import fptk.monads.resultM [unwrapR_or]) #_ "returns contained Success value or falls back to default"
    (import fptk.monads.resultM [unwrapE   ]) #_ "returns contained Failure value or throws error when not Failure"
    (import fptk.monads.resultM [unwrapE_or]) #_ "returns contained Failure value or falls back to default"

; _____________________________________________________________________________/ }}}1

