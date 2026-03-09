
    ; 1) generates nonstrict.wy from strict.wy
    ; 2) transpiles both nonstrict.wy and strict.wy


    (import _fptk_local *) (require _fptk_local *)

    (defclass [dataclass] FilePairDescriptor []
        ( #^ str strict_wy); source of all, everything else is produced from it
        ( #^ str strict_hy)
        ( #^ str non_strict_wy)
        ( #^ str non_strict_hy))

    (setv $FILE_PAIRS
        [ [ "../../src/fpmx/_wy_source/strict/maybeM.wy"]])
