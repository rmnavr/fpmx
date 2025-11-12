
    (require fptk [lmapm assertm])

    (assertm = (lmapm (+ 3 it) [1 2]) [4 5])
