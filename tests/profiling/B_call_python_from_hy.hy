
    (import time [time :as get_time])

    (setv _t0 (get_time))
    (import A_python_real_times *)
    (setv _t1 (get_time))
    (print f"// {(- _t1 _t0) :.3f} sec | import A_python_real_times *")

