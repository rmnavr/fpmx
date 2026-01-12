
    (import time [time :as get_time])

    (setv _t0 (get_time))
    (import fptk.core *)
    (setv _t1 (get_time))
    (require fptk.core *)
    (setv _t2 (get_time))

    (print f"\nCalling from hy (direct):")
    (print f"{(- _t1 _t0) :.3f} sec | import core *")
    (print f"{(- _t2 _t1) :.3f} sec | require core *")
    (print f"--------------------")
    (print f"{(- _t2 _t0) :.3f} sec | Total")
    (print f"")

