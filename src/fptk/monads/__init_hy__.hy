    
    ; this reimports file exists because resultM.wy is
    ; not convenient for cur docgen

; [GROUP] Monad: Result ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

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

