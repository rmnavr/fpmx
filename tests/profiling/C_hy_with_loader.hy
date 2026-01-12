
    (import time [time :as get_time])

    (setv _t0 (get_time))
    (require fptk [load_fptk])
    (setv _t1 (get_time))
    (load_fptk "core") ; "lens" "strict" "monads"
    (setv _t2 (get_time))

    (print f"\nCalling from hy (loader):")
    (print f"{(- _t1 _t0) :.3f} sec | require fptk [load_fptk]")
    (print f"{(- _t2 _t1) :.3f} sec | load_fptk 'core' 'lens' 'strict' 'monads'")
    (print f"--------------------")
    (print f"{(- _t2 _t0) :.3f} sec | Total")
    (print f"")

