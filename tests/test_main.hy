
    (require fptk.loader [load_fptk]) (load_fptk "core")
    (import hypothesis [given strategies :as st])

    (import math)

    (defn [(given (st.integers))] test_x2 [x]
        (setv result (half x))
        (assert (floatQ result))
        (assert (math.isclose (double result) x)))
