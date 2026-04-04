
    ; TODO:
    ; - xmin < xmax check
    ; - xmin=1, xmax=None, when xmin > max.x of all pts
    ; - xsize=1 gives error
    ; * :sep linux/windows

; Imports ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (require fpmx.prelude.from_hyrule [of])
    (import typing [Tuple Union List Optional])
    (import funcy [lpluck partition str_join])
    (import dataclasses [dataclass])

    (export :objects [dotPlot])

; _____________________________________________________________________________/ }}}1
; Info ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; Cell — 8 braile mini-dots [True, False, ...]
    ; DrawingArea — canvas where plot is drawn (excludes frame)

; _____________________________________________________________________________/ }}}1

; [Classes] Pts and such ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv number (of Union int float))
    (setv Point (of Tuple number number))

; _____________________________________________________________________________/ }}}1
; [Classes] Cell (8-mini-dots) ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (setv $SPACE_CHAR " ")

    (defclass [dataclass] Cell []
        "represents 8 mini-dots of Braille-char"
        (setv #^ bool g False) (setv #^ bool h False)
        (setv #^ bool e False) (setv #^ bool f False)
        (setv #^ bool c False) (setv #^ bool d False)
        (setv #^ bool a False) (setv #^ bool b False))

    (defn #^ str cell2Char [#^ Cell cell]
        "returns Braille char"
        (setv code
            (+ 10240 (* cell.g 1) (* cell.h 8)
                      (* cell.e 2) (* cell.f 16)
                      (* cell.c 4) (* cell.d 32)
                      (* cell.a 64) (* cell.b 128)))
        (if (= code 10240)
             (return $SPACE_CHAR)
             (return (chr code))))

; _____________________________________________________________________________/ }}}1

; [Functions] Cell-related ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ Cell
        markCell
        [ #^ (of List Point) pts
          #^ number xmin
          #^ number xmax
          #^ number ymin
          #^ number ymax]
        "if any of 8 mini-dots contains pts — make this mini-dot True"
        (setv [[x0 x2] [y0 y4]] [[xmin xmax] [ymin ymax]])
        (setv x1 (py "x0 + (x2 - x0)/2"))
        (setv y1 (py "y0 + 1*(y4 - y0)/4"))
        (setv y2 (py "y0 + 2*(y4 - y0)/4"))
        (setv y3 (py "y0 + 3*(y4 - y0)/4"))
        (setv a (anyPtsInsideLimsQ pts x0 x1 y0 y1))
        (setv b (anyPtsInsideLimsQ pts x1 x2 y0 y1))
        (setv c (anyPtsInsideLimsQ pts x0 x1 y1 y2))
        (setv d (anyPtsInsideLimsQ pts x1 x2 y1 y2))
        (setv e (anyPtsInsideLimsQ pts x0 x1 y2 y3))
        (setv f (anyPtsInsideLimsQ pts x1 x2 y2 y3))
        (setv g (anyPtsInsideLimsQ pts x0 x1 y3 y4))
        (setv h (anyPtsInsideLimsQ pts x1 x2 y3 y4))
        (return (Cell :a a :b b :c c :d d :e e :f f :g g :h h)))

    (defn #^ bool
        anyPtsInsideLimsQ
        [ #^ (of List Point) pts
          #^ number xmin
          #^ number xmax
          #^ number ymin
          #^ number ymax]
        (for [&pt pts]
            (setv [x y] &pt)
            (when (and (> x xmin) (<= x xmax) (> y ymin) (<= y ymax))
                   (return True)))
        (return False))

; _____________________________________________________________________________/ }}}1
; [Functions] Plot: validating params ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn validatePlotParams
        [ #^ int xsize
          #^ int ysize
          #^ (of Optional number) xmin
          #^ (of Optional number) xmax
          #^ (of Optional number) ymin
          #^ (of Optional number) ymax]
        "does nothing when all is OK"
        ;
        (when
            (or (!= int (type xsize))
                 (!= int (type ysize)))
            (raise (TypeError "Type for plotsizes should be ints")))
        (when
            (or (<= xsize 1)
                 (<= ysize 0))
            (raise (ValueError "Minimal allowable plot size is xsize=2, ysize=1")))
        (when
            (or (not (or (isinstance xmin number) (= xmin None) ))
                 (not (or (isinstance xmax number) (= xmax None)))
                 (not (or (isinstance ymin number) (= ymin None)))
                 (not (or (isinstance ymax number) (= ymax None))))
            (raise (TypeError "Type for x/y lims should be int, float or None"))))

    (defn #^ (of Tuple number number number number); xmin xmax ymin ymax
        calculate_plot_lims
        [ #^ (of List Point) pts
          #^ (of Optional number) xmin
          #^ (of Optional number) xmax
          #^ (of Optional number) ymin
          #^ (of Optional number) ymax]
        "assigns automatic lims based on min/max pts coords, also when some of plot_lims are Nones"
        ; step 1: calculate lims based on pts only
        (setv _margin 1.0)
        (cond (= 0 (len pts))
               (setv [[pts_x0 pts_x1] [pts_y0 pts_y1]] [[None None] [None None]])
               ;
               (= 1 (len pts))
               (do (setv _x (get pts 0 0))
                    (setv _y (get pts 0 1))
                    (setv [[pts_x0 pts_x1] [pts_y0 pts_y1]]
                         [[(- _x _margin) (+ _x _margin)] [(- _y _margin) (+ _y _margin)]]))
               True
               (do
                  (setv [pts_x0 pts_x1] ( (fn [%it] #((min %it) (max %it))) (lpluck 0 pts)))
                  (setv [pts_y0 pts_y1] ( (fn [%it] #((min %it) (max %it))) (lpluck 1 pts)))))
        ; step 2: process possible Nones in user-given plot-lims
        (setv [[lim_x0 lim_x1] [lim_y0 lim_y1]] [[xmin xmax] [ymin ymax]])
        ; TODO: not all possibilities are taken into account currently
        (setv out_x0 (if (= lim_x0 None) (if (= pts_x0 None) 0 pts_x0) lim_x0))
        (setv out_x1 (if (= lim_x1 None) (if (= pts_x1 None) 1 pts_x1) lim_x1))
        (setv out_y0 (if (= lim_y0 None) (if (= pts_y0 None) 0 pts_y0) lim_y0))
        (setv out_y1 (if (= lim_y1 None) (if (= pts_y1 None) 1 pts_y1) lim_y1))
        ;
        (return [out_x0 out_x1 out_y0 out_y1]))

; _____________________________________________________________________________/ }}}1
; [Functions] Plot: plotting ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (defn #^ (of List str)
        constructDrawingArea
        [ #^ (of List Point) pts
          #^ int xsize
          #^ int ysize
          #^ number xmin
          #^ number xmax
          #^ number ymin
          #^ number ymax]
        "returns top most string first (with max Y), then Y-1 and so on"
        (setv [[x0 xN] [y0 yN]] [[xmin xmax] [ymin ymax]])
        ;
        (setv xs (list (map (fn [it] (py "x0 + it*(xN - x0)/xsize")) (range 0 (+ 1 xsize)) ))); from x0 to xN, both included
        (setv ys (list (map (fn [it] (py "y0 + it*(yN - y0)/ysize")) (range 0 (+ 1 ysize)) ))); from x0 to xN, both included
        ;
        (setv cells [])
        (for [&iy (range 0 (- (len ys) 1))]
            (for [&ix (range 0 (- (len xs) 1))]
                (cells.append
                    (cell2Char (markCell pts (get xs &ix) (get xs (+ 1 &ix)) (get ys &iy) (get ys (+ 1 &iy)))))))
        (setv lines (list (partition xsize cells )))
        (list (reversed (list (map (fn [%it] (+ #* %it)) lines )))))

    (defn #^ (of List str)
       addFrame
       [ #^ (of List str) drawing_area]
       (setv xsize (len (get drawing_area 0)))
       (setv ysize (len drawing_area))
       (setv outp [])
       ;
       (outp.append (+ $SPACE_CHAR (* xsize "_") $SPACE_CHAR))
       (for [&str drawing_area] (outp.append (+ "|" &str "|" )))
       (outp.append (+ $SPACE_CHAR (* xsize "‾") $SPACE_CHAR))
       ;
       (return outp))

    (defn #^ (of List str)
        addLims
        [ #^ (of List str) framed_plot
          #^ number xmin
          #^ number xmax
          #^ number ymin
          #^ number ymax]
        ;
        ; add y ticks:
        (setv top_line (+ (get framed_plot  0) "_" (if (> ymax 0) " " "") f"{ymax :.3f}"))
        (setv prebot_line (+ (get framed_plot -2) " " (if (> ymin 0) " " "") f"{ymin :.3f}"))
        (setv bot_line (+ (get framed_plot -1) "‾"))
        (setv bot_line (bot_line.replace " " "|")); add x verti marks
        (setv _y_ticks_added [top_line #* (cut framed_plot 1 -2) prebot_line bot_line])
        ;
        ; add x ticks:
        (setv x_min_tick f"{xmin :.3f}")
        (setv extra_len
            (max
                1
                (- (len (get framed_plot 0)) (len x_min_tick) 1)))
        (setv x_max_tick f"{xmax :.3f}")
        ;
        (setv xbot_line (+ x_min_tick (* extra_len " ") x_max_tick))
        ;
        (return [#* _y_ticks_added xbot_line]))

; _____________________________________________________________________________/ }}}1
; [Functions] Plot: assembly ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    ; All data sanitizing happens at dotPlot level.
    ; So all subfunctions expect correct data.

    (defn #^ str dotPlot
        [ #^ (of List (of Tuple number number)) pts
          *
          #^ int [xsize 60]
          #^ int [ysize 30]
          #^ (of Optional number) [xmin None]
          #^ (of Optional number) [xmax None]
          #^ (of Optional number) [ymin None]
          #^ (of Optional number) [ymax None]
          #^ bool [frame True]]
        ;
        ; validation:
        (validatePlotParams xsize ysize xmin xmax ymin ymax)
        (setv [xmin_ xmax_ ymin_ ymax_]; here Nones are resolved
            (calculate_plot_lims pts xmin xmax ymin ymax))
        (when
            (or (>= xmin_ xmax_)
                 (>= ymin_ ymax_))
            (raise (ValueError "Plotlims should be min < max")))
        ;
        ; drawing:
        (setv lines (constructDrawingArea pts xsize ysize xmin_ xmax_ ymin_ ymax_))
        (when frame
            (setv lines (addFrame lines))
            (setv lines (addLims lines xmin_ xmax_ ymin_ ymax_)))
        ;
        (return (str_join "\n" lines)))

; _____________________________________________________________________________/ }}}1

; /test/ ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

    (import math [sin])

    (setv xs (list (map (fn [it] (/ it 100)) (range -1000 1010) )))
    (setv ys (list (map sin xs )))
    (setv series (list (zip xs ys )))

    (print (dotPlot series :xsize 30 :ysize 5))

; _____________________________________________________________________________/ }}}1
