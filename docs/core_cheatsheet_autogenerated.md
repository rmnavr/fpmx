# fptk-core-cheatsheet


| Group | Functions/Types | Macros |
|-------|-----------------|--------|
| G01: Checks | <span title=":: evenQ(x) ::">[`evenQ`](#evenQ)</span> <span title=":: oddQ(x) ::">[`oddQ`](#oddQ)</span> <span title=":: zeroQ(x) :: checks directly via (= x 0)">[`zeroQ`](#zeroQ)</span> <span title=":: negativeQ(x) :: checks directly via (< x 0)">[`negativeQ`](#negativeQ)</span> <span title=":: positiveQ(x) :: checks directly via (> x 0)">[`positiveQ`](#positiveQ)</span> <span title="">[`noneQ`](#noneQ)</span> <span title="">[`notnoneQ`](#notnoneQ)</span> <span title=":: oftypeQ(tp, x) :: checks directly via (= (type x) tp)">[`oftypeQ`](#oftypeQ)</span> <span title=":: ofinstQ(tp, x) :: checks directly via (isinstance x tp)">[`ofinstQ`](#ofinstQ)</span> <span title=":: intQ(x) :: checks literally if type(x) == int, will also work with StrictInt from pydantic">[`intQ`](#intQ)</span> <span title=":: floatQ(x) :: checks literally if type(x) == float, will also work with StrictFloat from pydantic">[`floatQ`](#floatQ)</span> <span title=":: numberQ(x) :: checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic">[`numberQ`](#numberQ)</span> <span title=":: strQ(x) :: checks literally if type(x) == str, will also work with StrictStr from pydantic">[`strQ`](#strQ)</span> <span title=":: dictQ(x) :: checks literally if type(x) == dict">[`dictQ`](#dictQ)</span> <span title=":: listQ(value) :: checks if value is list">[`listQ`](#listQ)</span> <span title=":: tupleQ(value) :: checks if value is tuple">[`tupleQ`](#tupleQ)</span> <span title=":: setQ(value) :: checks if value is set">[`setQ`](#setQ)</span> <span title=":: iteratorQ(value) :: checks if value is iterator">[`iteratorQ`](#iteratorQ)</span> <span title=":: iterableQ(value) :: checks if value is iterable">[`iterableQ`](#iterableQ)</span> <span title=":: trueQ(x) :: checks directly via (= x True)">[`trueQ`](#trueQ)</span> <span title=":: falseQ(x) :: checks directly via (= x False)">[`falseQ`](#falseQ)</span> <span title=":: oflenQ(n, xs) :: checks directly via (= (len xs) n)">[`oflenQ`](#oflenQ)</span> <span title=":: zerolenQ(xs) :: checks directly via (= (len xs) 0)">[`zerolenQ`](#zerolenQ)</span> |  |
| G02: Math | <span title=":: inc(n) :: = n + 1">[`dec`](#dec)</span> <span title=":: dec(n) :: = n - 1">[`inc`](#inc)</span> <span title=":: sign(n) :: will give 0 for n=0">[`sign`](#sign)</span> <span title=":: half(x) :: = x/2">[`half`](#half)</span> <span title=":: double(x) :: = x*2">[`double`](#double)</span> <span title=":: reciprocal(x) :: = 1/x ; throws error for x=0">[`reciprocal`](#reciprocal)</span> <span title="floor(1.9) = 1">[`floor`](#floor)</span> <span title="ceil(1.1) = 2">[`ceil`](#ceil)</span> <span title=":: round_to(n, step) :: rounds to closest multiple of step: round_to(9.1, 1.5) == 9.0">[`round_to`](#round_to)</span> <span title=":: clip(x, lower, upper) :: clips x to fit in lower <= x <= upper limit">[`clip`](#clip)</span> <span title="approx_eq(a, b, *, rel_tol=1e-09, abs_tol=0.0)">[`approx_eq`](#approx_eq)</span> <span title=":: sqrt(n) :: = √n">[`sqrt`](#sqrt)</span> <span title=":: squared(x) :: = pow(x,2)">[`squared`](#squared)</span> <span title=":: dist(p, q) -> float :: ≈ √((px-qx)² + (py-qy)² ...)">[`dist`](#dist)</span> <span title=":: hypot(*coordinates) :: = √(x² + y² + ...)">[`hypot`](#hypot)</span> <span title=":: normalize(xs) -> xs :: will throw error for zero-len vector">[`normalize`](#normalize)</span> <span title=":: exp(x) ::">[`exp`](#exp)</span> <span title=":: log(x, base=math.e) ::">[`log`](#log)</span> <span title=":: ln(x) :: = math.log(x, math.e) ; coexists with log for clarity">[`ln`](#ln)</span> <span title=":: log10(x) ::">[`log10`](#log10)</span> <span title="literally just float pi=3.14...">[`pi`](#pi)</span> <span title=":: sin(x) :: x is in radians">[`sin`](#sin)</span> <span title=":: cos(x) :: x is in radians">[`cos`](#cos)</span> <span title=":: tan(x) :: x is in radians, will give smth like 1.6E+16 for x = pi">[`tan`](#tan)</span> <span title=":: degrees(x) :: x in radians is converted to degrees">[`degrees`](#degrees)</span> <span title=":: radians(x) :: x in degrees is converted to radians">[`radians`](#radians)</span> <span title=":: acos(x) :: x is in radians, result is between 0 and pi">[`acos`](#acos)</span> <span title=":: asin(x) :: x is in radians, result is between -pi/2 and pi/2">[`asin`](#asin)</span> <span title=":: asin(x) :: x is in radians, result is between -pi/2 and pi/2">[`atan`](#atan)</span> <span title=":: atan2(y, x) :: both signs are considered">[`atan2`](#atan2)</span> <span title=":: choice(seq) -> Elem :: throws error for empty list">[`choice`](#choice)</span> <span title=":: randint(a, b) -> int :: returns random integer in range [a, b] including both end points">[`randint`](#randint)</span> <span title=":: randfloat(a, b) -> float :: range is [a, b) or [a, b] depending on rounding">[`randfloat`](#randfloat)</span> <span title=":: rand01() -> float :: generates random number in interval [0, 1)">[`rand01`](#rand01)</span> <span title=":: sums(seq [, acc]) -> generator :: reductions with addition function">[`sums`](#sums)</span> <span title=":: lsums(seq [, acc]) -> list :: list version of sums">[`lsums`](#lsums)</span> <span title=":: product(iterable, /, *, start=1) :: product([2, 3, 5]) = 30">[`product`](#product)</span> |  |
| G03: Operators to functions | <span title=":: minus(x, y) = x - y ::">[`minus`](#minus)</span> <span title=":: neg(n) :: = -1 * n">[`neg`](#neg)</span> <span title=":: mod(5, 2) :: = 1">[`mod`](#mod)</span> <span title="'@' as function">[`matmul`](#matmul)</span> <span title=":: div(a, b) ::">[`div`](#div)</span> <span title="'and' as function">[`and_`](#and_)</span> <span title="'or' as function">[`or_`](#or_)</span> <span title="'not' as function">[`not_`](#not_)</span> <span title="'is' as function">[`is_`](#is_)</span> <span title="">[`xor`](#xor)</span> <span title="equal">[`eq`](#eq)</span> <span title="non-equal">[`neq`](#neq)</span> <span title="greater than">[`gt`](#gt)</span> <span title="less than">[`lt`](#lt)</span> <span title="greater or equal">[`geq`](#geq)</span> <span title="less or equal">[`leq`](#leq)</span> <span title=":: gt0(x) :: checks for x > 0">[`gt0`](#gt0)</span> <span title=":: geq0(x) :: x >= 0">[`geq0`](#geq0)</span> <span title=":: lt0(x) :: checks for x < 0">[`lt0`](#lt0)</span> <span title=":: leq0(x) :: x <= 0">[`leq0`](#leq0)</span> <span title=":: mul(*args) :: literally just mul(a,b,c,...)=a*b*c*...; can also be used with 0 or 1 arg">[`mul`](#mul)</span> <span title=":: smul(*args) :: synonim of mul (with underlined usage on strings)">[`smul`](#smul)</span> <span title=":: lmul(*args) :: synonim of mul (with underlined usage on lists)">[`lmul`](#lmul)</span> <span title=":: plus(*args) :: literally just plus(a,b,c,...)=a+b+c...; can also be used with 0 or 1 arg">[`plus`](#plus)</span> <span title=":: sconcat(*args) :: string concantenation as a monoid (will not give error when used with 0 or 1 args)">[`sconcat`](#sconcat)</span> |  |
| G04: Strings | <span title=":: strlen(text) :: rename of len, underlines usage on strings">[`strlen`](#strlen)</span> <span title=":: str_join(ss, sep='') :: rearrangement of funcy.str_join, ss is seq of strings">[`str_join`](#str_join)</span> <span title=":: enlengthen(target_len, string, char=' ', on_tail=True) :: adds char to string until target_len reached">[`enlengthen`](#enlengthen)</span> <span title=":: lowercase(string) :: str.lower method as a function">[`lowercase`](#lowercase)</span> <span title=":: strip(string, chars=None) :: str.strip method as a function">[`strip`](#strip)</span> <span title=":: lstrip(string, chars=None) :: str.lstrip method as a function">[`lstrip`](#lstrip)</span> <span title=":: rstrip(string, chars=None) :: str.rstrip method as a function">[`rstrip`](#rstrip)</span> <span title=":: re_sub(rpattern, replacement, string, count=0, flags=0) ::">[`re_sub`](#re_sub)</span> <span title=":: re_split(rpattern, string) ::">[`re_split`](#re_split)</span> <span title=":: re_find(rpattern, string, flags=0) -> str :: returns first found">[`re_find`](#re_find)</span> <span title=":: re_test(rpattern, string, ...) -> bool :: tests if string has match (not neccessarily whole string)">[`re_test`](#re_test)</span> <span title=":: re_all(rpattern, string, ...) -> List :: returns tuples if groups requested like via r'a(b)(c)d'">[`re_all`](#re_all)</span> |  |
| G05: Getters | <span title=":: assoc(xs, k1, v1, k2, v2, ...) -> None :: ≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)">[`assoc`](#assoc)</span> <span title=":: nth(n, seq) -> Optional elem :: 0-based index; works also with dicts">[`nth`](#nth)</span> <span title=":: first(seq) -> Optional elem ::">[`first`](#first)</span> <span title=":: second(seq) -> Optional elem ::">[`second`](#second)</span> <span title=":: third(seq) -> Optional elem ::">[`third`](#third)</span> <span title=":: fourth(seq) -> Optional elem ::">[`fourth`](#fourth)</span> <span title=":: beforelast(seq) -> Optional elem ::">[`beforelast`](#beforelast)</span> <span title=":: last(seq) -> Optional elem ::">[`last`](#last)</span> <span title=":: rest(seq) -> List :: drops 1st elem of list">[`rest`](#rest)</span> <span title=":: butlast(seq) -> List :: drops last elem of list">[`butlast`](#butlast)</span> <span title=":: drop(n, seq) -> List :: drops n>=0 elems from start of the list; when n<0, drops from end of the list">[`drop`](#drop)</span> <span title=":: take(n, seq) -> List :: takes n elems from start; when n<0, takes from end of the list">[`take`](#take)</span> <span title=":: pick(ns, seq) -> List :: throws error if some of ns doesn't exist; ns can be list of ints or dict keys">[`pick`](#pick)</span> <span title=":: pluck(key, mappings) -> generator :: gets same key (or idx) from every mapping, mappings can be lists of lists/dicts/etc.">[`pluck`](#pluck)</span> <span title=":: lpluck(key, mappings) -> list ::">[`lpluck`](#lpluck)</span> <span title=":: pluck_attr(attr, objects) -> generator :: attr should be given as str">[`pluck_attr`](#pluck_attr)</span> <span title=":: lpluck_attr(attr, objects) -> list :: list version of pluck_attr">[`lpluck_attr`](#lpluck_attr)</span> <span title=":: mask_sel('abc', [1,0,1]) -> iterator: 'a', 'c' ::">[`mask_sel`](#mask_sel)</span> <span title=":: lmask_sel(data, selectors) -> list ::">[`lmask_sel`](#lmask_sel)</span> <span title=":: mask2idxs(mask) -> list :: mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]">[`mask2idxs`](#mask2idxs)</span> <span title=":: idxs2mask(idxs) -> list :: idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]">[`idxs2mask`](#idxs2mask)</span> | <span title="">[`ncut`](#ncut)</span> <span title=":: (pluckm n xs) (pluckm key ys) (pluckm .attr zs) :: accepts fptk-style .arg syntax">[`pluckm`](#pluckm)</span> <span title="list version of pluckm">[`lpluckm`](#lpluckm)</span> <span title=":: (getattrm Object 'attr') (getattrm Object .attr) :: accepts fptk-style .attr syntax">[`getattrm`](#getattrm)</span> |
| G06: Typing | <span title="">[`Enum`](#Enum)</span> <span title="">[`List`](#List)</span> <span title="">[`Tuple`](#Tuple)</span> <span title="">[`TypedDict`](#TypedDict)</span> <span title="">[`Dict`](#Dict)</span> <span title="">[`Union`](#Union)</span> <span title="">[`Generator`](#Generator)</span> <span title="">[`Any`](#Any)</span> <span title="">[`Optional`](#Optional)</span> <span title="">[`Callable`](#Callable)</span> <span title="">[`Literal`](#Literal)</span> <span title="">[`Type`](#Type)</span> <span title="">[`TypeVar`](#TypeVar)</span> <span title="">[`Generic`](#Generic)</span> <span title="">[`NamedTuple`](#NamedTuple)</span> <span title="">[`dataclass`](#dataclass)</span> <span title="non-mutating">[`upd_field`](#upd_field)</span> | <span title="example: (of List int) which is equiv to py-code: List[int]">[`of`](#of)</span> <span title="example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]">[`def::`](#Annotator2)</span> <span title="define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))">[`f::`](#Annotator1)</span> |
| G07: IO | <span title=":: file_existsQ(filename) :: also works on folders">[`file_existsQ`](#file_existsQ)</span> <span title=":: fileQ(filename) ::">[`fileQ`](#fileQ)</span> <span title=":: dirQ(filename) ::">[`dirQ`](#dirQ)</span> <span title=":: read_file(file_name, encoding='utf-8') -> str :: returns whole file content">[`read_file`](#read_file)</span> <span title=":: write_file(text, file_name, mode='w', encoding='utf-8') :: modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation">[`write_to_file`](#write_to_file)</span> |  |
| G08: APL | <span title=":: inf_range(start [, step]) :: inf_range(10) -> generator: 10, 11, 12, ...">[`inf_range`](#inf_range)</span> <span title=":: cycle(p) :: cycle('AB') -> A B A B ...">[`cycle`](#cycle)</span> <span title=":: lcycle(p, n) -> list :: takes first n elems from cycle(p)">[`lcycle`](#lcycle)</span> <span title=":: repeat(elem [, n]) :: repeat(10,3) -> 10 10 10">[`repeat`](#repeat)</span> <span title=":: lrepeat(elem, n) -> list :: unlike in repeat, n has to be provided">[`lrepeat`](#lrepeat)</span> <span title=":: pairwise(seq) -> iterator :: supposed to be used in loops, will produce no elems for seq with len <= 1">[`pairwise`](#pairwise)</span> <span title=":: with_prev(seq, fill=None) -> iterator :: supposed to be used in loops">[`with_prev`](#with_prev)</span> <span title=":: with_next(seq, fill=None) -> iterator :: supposed to be used in loops">[`with_next`](#with_next)</span> <span title=":: islice(iterable, start, stop[, step]) :: list(islice(inf_range(10), 2)) == [10, 11]">[`islice`](#islice)</span> <span title="list version of islice: lislice">[`lislice`](#lislice)</span> <span title=":: cat(seqs) :: non-variadic version of concat">[`cat`](#cat)</span> <span title=":: lcat(seqs) :: non-variadic version of concat">[`lcat`](#lcat)</span> <span title=":: concat(*seqs) -> iterator :: variadic vertion of cat">[`concat`](#concat)</span> <span title=":: lconcat(*seqs) -> list :: literally just list(concat(*seqs))">[`lconcat`](#lconcat)</span> <span title=":: mapcat(f, *seqs) :: maps, then concatenates">[`mapcat`](#mapcat)</span> <span title=":: lmapcat(f, *seqs) :: maps, then concatenates">[`lmapcat`](#lmapcat)</span> <span title=":: lreversed(sequence) :: list version of reversed">[`lreversed`](#lreversed)</span> <span title=":: lfilter(pred, seq) -> List :: funcy list version of extended filter">[`lfilter`](#lfilter)</span> <span title=":: fltr1st(f, seq) -> Optional elem :: returns first found element (or None)">[`fltr1st`](#fltr1st)</span> <span title=":: reject(pred, seq)-> iterator :: same as filter, but checks for False">[`reject`](#reject)</span> <span title=":: lreject(pred, seq) -> List :: list version of reject">[`lreject`](#lreject)</span> <span title=":: without(items, seq) -> generator :: subtracts items from seq (as a sets)">[`without`](#without)</span> <span title=":: lwithout(items, seq) -> list :: list version of reject">[`lwithout`](#lwithout)</span> <span title=":: takewhile([pred, ] seq) :: yields elems of seq as long as they pass pred">[`takewhile`](#takewhile)</span> <span title=":: dropwhile([pred, ] seq) :: mirror of takewhile">[`dropwhile`](#dropwhile)</span> <span title=":: filter_split(pred, seq) -> passed, rejected ::">[`filter_split`](#filter_split)</span> <span title=":: lfilter_split(pred,seq) -> passed, rejected :: list version of filter_split">[`lfilter_split`](#lfilter_split)</span> <span title=":: flatten(coll) :: recursively flattens to the bottom">[`flatten`](#flatten)</span> <span title=":: bisect_at(n, seq) -> start, tail :: len of start will = n, works only with n>=0">[`bisect_at`](#bisect_at)</span> <span title=":: lbisect_at(n, seq) -> start, tail :: list version of bisect_at, but also for n<0, abs(n) will be len of tail">[`lbisect_at`](#lbisect_at)</span> <span title=":: bisect_by(pred, seq) -> taken, dropped :: similar to (takewhile, dropwhile)">[`bisect_by`](#bisect_by)</span> <span title=":: lbisect_by(pred, seq) -> taken, dropped :: list version of lbisect">[`lbisect_by`](#lbisect_by)</span> <span title=":: partition(n, seq, *, step=None, tail=False) -> generator :: splits seq to lists of len n, tail=True will allow including fewer than n items">[`partition`](#partition)</span> <span title=":: lpartition(n, seq, *, step=None, tail=False) -> List :: simply list(partition(...))">[`lpartition`](#lpartition)</span> <span title=":: partition_by(f, seq) -> iterator of iterators :: splits when f(item) change">[`partition_by`](#partition_by)</span> <span title=":: lpartition_by(f,seq) -> list of lists :: list(partition_by(...))">[`lpartition_by`](#lpartition_by)</span> <span title=":: group_by(f, seq) -> defaultdict(list) :: groups elems of seq keyed by the result of f">[`group_by`](#group_by)</span> <span title=":: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list :: cut at pred(elem)==True elems">[`lmulticut_by`](#lmulticut_by)</span> | <span title=":: (filterm f xs) :: same as filter, but expects fm-syntax for func">[`filterm`](#filterm)</span> <span title=":: (lfilterm f xs) :: list version of lfilterm">[`lfilterm`](#lfilterm)</span> |
| G09: FP | <span title=":: lzip(*iterables) -> List :: literally just list(zip(*iterables))">[`lzip`](#lzip)</span> <span title=":: lmap(f, *seqs) -> List :: list version of map">[`lmap`](#lmap)</span> <span title=":: starmap(function, iterable) ::">[`starmap`](#starmap)</span> <span title=":: lstarmap(function, iterable) -> list :: list version of starmap">[`lstarmap`](#lstarmap)</span> <span title=":: reduce(function, sequence[, initial]) -> value :: theory: reduce + monoid = binary-function for free becomes n-arg-function">[`reduce`](#reduce)</span> <span title=":: reductions(f, seq [, acc]) -> generator :: returns sequence of intermetidate values of reduce(f, seq, acc)">[`reductions`](#reductions)</span> <span title=":: lreductions(f, seq [, acc]) -> list :: list version of reductions">[`lreductions`](#lreductions)</span> <span title="identity(n) -> n">[`identity`](#identity)</span> <span title=":: constantly(val) :: constantly(30) is FUNCTION that always return val no matter the arguments">[`constantly`](#constantly)</span> <span title=":: compose(f1, f2, ..., fn) :: = f1(f2(..fn(***))) ; applicator">[`compose`](#compose)</span> <span title=":: rcompose(f1, f2, ..., fn) :: = fn(..(f2(f1(***)))) ; applicator">[`rcompose`](#rcompose)</span> <span title=":: ljuxt(*fs) :: = [f1, f2, ...](***) ; applicator">[`ljuxt`](#ljuxt)</span> <span title=":: nested(n, f) :: applicator f(...(f(***)))">[`nested`](#nested)</span> <span title=":: apply_n(n, f, *args, **kwargs) :: f(f(f(...f(*args, **kwargs))">[`apply_n`](#apply_n)</span> <span title="applicator">[`partial`](#partial)</span> <span title="applicator">[`rpartial`](#rpartial)</span> <span title=":: flip(f, a, b) = f(b, a) :: calls f with flipped args">[`flip`](#flip)</span> <span title=":: pflip(f, a) :: applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25">[`pflip`](#pflip)</span> <span title=":: fnot(f, *args, **kwargs) :: = not(f(*args, **kwargs))">[`fnot`](#fnot)</span> <span title=":: eq_any(x, values) :: = (or (eq x value1) (eq x value2) ...)">[`eq_any`](#eq_any)</span> <span title=":: on(f, check, x, y) :: example: (on len eq xs ys) -> (eq (len xs) (len yx))">[`on`](#on)</span> <span title=":: all_fs(fs, *args, **kwargs) :: checks if all f(*args, **kwargs) are True">[`all_fs`](#all_fs)</span> <span title=":: any_fs(fs, *args, **kwargs) :: checks if any of f(*args, **kwargs) is True">[`any_fs`](#any_fs)</span> | <span title="">[`case`](#case)</span> <span title="">[`unless`](#unless)</span> <span title="">[`lif`](#lif)</span> <span title="">[`branch`](#branch)</span> <span title="">[`->`](#hyruleThreading1)</span> <span title="">[`->>`](#hyruleThreading2)</span> <span title="">[`as->`](#hyruleThreading3)</span> <span title="mutating">[`doto`](#hyruleThreading4)</span> <span title=":: (do_n   n #* body) -> None :: expands to ~ (do body body body ...)">[`do_n`](#do_n)</span> <span title=":: (list_n n #* body) -> List ::">[`list_n`](#list_n)</span> <span title=":: (fm (* it 3)) :: anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'">[`fm`](#fm)</span> <span title=":: (f> (* it 3) 4) :: anonymous function with fm syntax, immediately applicates args">[`f>`](#LambdaWithAppl)</span> <span title="same as map, but expects fm-syntax for func">[`mapm`](#mapm)</span> <span title="same as lmap, but expects fm-syntax for func">[`lmapm`](#lmapm)</span> <span title="unification of dot-macro and ->">[`=>`](#FPTKThreading1)</span> <span title="unification of dot-macro and ->>">[`=>>`](#FPTKThreading2)</span> <span title="aplicator, pipe of partials">[`p:`](#PipeOfPartials)</span> |
| G90: one-based index getters | <span title=":: get_(seq, *ns) -> elem :: same as get, but with 1-based index (will throw error for n=0)">[`get_`](#get_)</span> <span title=":: nth_(n, seq) -> Optional elem :: same as nth, but with 1-based index; will return None for n=0">[`nth_`](#nth_)</span> <span title=":: slice_(start, end, step=None) :: similar to slice, but with 1-based index; will throw error for start=0 or end=0">[`slice_`](#slice_)</span> <span title=":: cut_(seq, start, end, step=None) -> List :: similar to cut, but with 1-based index; will throw error for start=0 or end=0">[`cut_`](#cut_)</span> <span title=":: range_(start, end=None, step=1) -> range :: same as range, but with 1-based index">[`range_`](#range_)</span> <span title=":: lrange_(start, end, step=1) -> List :: range including both ends when possible, also works on fractionals">[`lrange_`](#lrange_)</span> |  |
| G91: Benchmarking | <span title=":: cur_time() :: gets current time in seconds">[`cur_time`](#cur_time)</span> <span title=":: dt_printer(* args, fresh_run=False) :: starts timer on fresh run, prints time passed since previous call">[`dt_print`](#dt_print)</span> | <span title=":: (timing expr1 expr2 ...) -> #(float, Any) :: returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)">[`timing`](#timing)</span> |
| G92: Testing |  | <span title=":: (assertm op arg1 arg2) :: tests if (op arg1 arg2), for example (= 1 1)">[`assertm`](#assertm)</span> <span title="example: (assertm gives_error_typeQ (get [1] 2) IndexError)">[`gives_error_typeQ`](#gives_error_typeQ)</span> |
| G93: Misc | <span title="standard python pprint function">[`pprint`](#pprint)</span> <span title=":: lprint(seq, sep=None) :: prints every elem of seq on new line">[`lprint`](#lprint)</span> | <span title="">[`comment`](#comment)</span> |

# Detailed descriptions

## evenQ

[go up](#fptk-core-cheatsheet)

```hy
Name: evenQ (= funcy.even)
Kind: Reimport
Sgnt: evenQ(x)
```

```hy
Help on function even in module funcy.primitives:

even(x)
```

## oddQ

[go up](#fptk-core-cheatsheet)

```hy
Name: oddQ (= funcy.odd)
Kind: Reimport
Sgnt: oddQ(x)
```

```hy
Help on function odd in module funcy.primitives:

odd(x)
```

## zeroQ

[go up](#fptk-core-cheatsheet)

```hy
Name: zeroQ
Kind: FPTK original
Sgnt: zeroQ(x)
Info: checks directly via (= x 0)
```

```hy
Help on function zeroQ in module fptk.core.funcs:

zeroQ(x)
    checks literally if x == 0
```

## negativeQ

[go up](#fptk-core-cheatsheet)

```hy
Name: negativeQ
Kind: FPTK original
Sgnt: negativeQ(x)
Info: checks directly via (< x 0)
```

```hy
Help on function negativeQ in module fptk.core.funcs:

negativeQ(x)
    checks literally if x < 0
```

## positiveQ

[go up](#fptk-core-cheatsheet)

```hy
Name: positiveQ
Kind: FPTK original
Sgnt: positiveQ(x)
Info: checks directly via (> x 0)
```

```hy
Help on function positiveQ in module fptk.core.funcs:

positiveQ(x)
    checks literally if x > 0
```

## noneQ

[go up](#fptk-core-cheatsheet)

```hy
Name: noneQ (= funcy.isnone)
Kind: Reimport
```

```hy
Help on function isnone in module funcy.primitives:

isnone(x)
```

## notnoneQ

[go up](#fptk-core-cheatsheet)

```hy
Name: notnoneQ (= funcy.notnone)
Kind: Reimport
```

```hy
Help on function notnone in module funcy.primitives:

notnone(x)
```

## oftypeQ

[go up](#fptk-core-cheatsheet)

```hy
Name: oftypeQ
Kind: FPTK original
Sgnt: oftypeQ(tp, x)
Info: checks directly via (= (type x) tp)
```

```hy
Help on function oftypeQ in module fptk.core.funcs:

oftypeQ(tp, x)
    checks literally if type(x) == tp
```

## ofinstQ

[go up](#fptk-core-cheatsheet)

```hy
Name: ofinstQ
Kind: FPTK original
Sgnt: ofinstQ(tp, x)
Info: checks directly via (isinstance x tp)
```

```hy
Help on function ofinstQ in module fptk.core.funcs:

ofinstQ(tp, x)
    checks literally if isinstance(x, tp)
```

## intQ

[go up](#fptk-core-cheatsheet)

```hy
Name: intQ
Kind: FPTK original
Sgnt: intQ(x)
Info: checks literally if type(x) == int, will also work with StrictInt from pydantic
```

```hy
Help on function intQ in module fptk.core.funcs:

intQ(x)
    checks literally if type(x) == int
```

## floatQ

[go up](#fptk-core-cheatsheet)

```hy
Name: floatQ
Kind: FPTK original
Sgnt: floatQ(x)
Info: checks literally if type(x) == float, will also work with StrictFloat from pydantic
```

```hy
Help on function floatQ in module fptk.core.funcs:

floatQ(x)
    checks literally if type(x) == float
```

## numberQ

[go up](#fptk-core-cheatsheet)

```hy
Name: numberQ
Kind: FPTK original
Sgnt: numberQ(x)
Info: checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic
```

```hy
Help on function numberQ in module fptk.core.funcs:

numberQ(x)
    checks literally if type(x) == int or type(x) == float
```

## strQ

[go up](#fptk-core-cheatsheet)

```hy
Name: strQ
Kind: FPTK original
Sgnt: strQ(x)
Info: checks literally if type(x) == str, will also work with StrictStr from pydantic
```

```hy
Help on function strQ in module fptk.core.funcs:

strQ(x)
    checks literally if type(x) == int or type(x) == float
```

## dictQ

[go up](#fptk-core-cheatsheet)

```hy
Name: dictQ
Kind: FPTK original
Sgnt: dictQ(x)
Info: checks literally if type(x) == dict
```

```hy
Help on function dictQ in module fptk.core.funcs:

dictQ(x)
    checks literally if type(x) == dict
```

## listQ

[go up](#fptk-core-cheatsheet)

```hy
Name: listQ (= funcy.is_list)
Kind: Reimport
Sgnt: listQ(value)
Info: checks if value is list
```

## tupleQ

[go up](#fptk-core-cheatsheet)

```hy
Name: tupleQ (= funcy.is_tuple)
Kind: Reimport
Sgnt: tupleQ(value)
Info: checks if value is tuple
```

## setQ

[go up](#fptk-core-cheatsheet)

```hy
Name: setQ (= funcy.is_set)
Kind: Reimport
Sgnt: setQ(value)
Info: checks if value is set
```

## iteratorQ

[go up](#fptk-core-cheatsheet)

```hy
Name: iteratorQ (= funcy.is_iter)
Kind: Reimport
Sgnt: iteratorQ(value)
Info: checks if value is iterator
```

## iterableQ

[go up](#fptk-core-cheatsheet)

```hy
Name: iterableQ (= funcy.iterable)
Kind: Reimport
Sgnt: iterableQ(value)
Info: checks if value is iterable
```

## trueQ

[go up](#fptk-core-cheatsheet)

```hy
Name: trueQ
Kind: FPTK original
Sgnt: trueQ(x)
Info: checks directly via (= x True)
```

```hy
Help on function trueQ in module fptk.core.funcs:

trueQ(x)
    checks literally if x == True
```

## falseQ

[go up](#fptk-core-cheatsheet)

```hy
Name: falseQ
Kind: FPTK original
Sgnt: falseQ(x)
Info: checks directly via (= x False)
```

```hy
Help on function falseQ in module fptk.core.funcs:

falseQ(x)
    checks literally if x == False
```

## oflenQ

[go up](#fptk-core-cheatsheet)

```hy
Name: oflenQ
Kind: FPTK original
Sgnt: oflenQ(n, xs)
Info: checks directly via (= (len xs) n)
```

```hy
Help on function oflenQ in module fptk.core.funcs:

oflenQ(n, xs)
    checks literally if len(xs) == n
```

## zerolenQ

[go up](#fptk-core-cheatsheet)

```hy
Name: zerolenQ
Kind: FPTK original
Sgnt: zerolenQ(xs)
Info: checks directly via (= (len xs) 0)
```

```hy
Help on function zerolenQ in module fptk.core.funcs:

zerolenQ(xs)
    checks literally if len(xs) == 0
```

## dec

[go up](#fptk-core-cheatsheet)

```hy
Name: dec
Kind: FPTK original
Sgnt: inc(n)
Info: = n + 1
```

```hy
Help on function dec in module fptk.core.funcs:

dec(n)
```

## inc

[go up](#fptk-core-cheatsheet)

```hy
Name: inc
Kind: FPTK original
Sgnt: dec(n)
Info: = n - 1
```

```hy
Help on function inc in module fptk.core.funcs:

inc(n)
```

## sign

[go up](#fptk-core-cheatsheet)

```hy
Name: sign
Kind: FPTK original
Sgnt: sign(n)
Info: will give 0 for n=0
```

```hy
Help on function sign in module fptk.core.funcs:

sign(x)
```

## half

[go up](#fptk-core-cheatsheet)

```hy
Name: half
Kind: FPTK original
Sgnt: half(x)
Info: = x/2
```

```hy
Help on function half in module fptk.core.funcs:

half(x)
    half(x) = x / 2
```

## double

[go up](#fptk-core-cheatsheet)

```hy
Name: double
Kind: FPTK original
Sgnt: double(x)
Info: = x*2
```

```hy
Help on function double in module fptk.core.funcs:

double(x)
    double(x) = x * 2
```

## reciprocal

[go up](#fptk-core-cheatsheet)

```hy
Name: reciprocal
Kind: FPTK original
Sgnt: reciprocal(x)
Info: = 1/x ; throws error for x=0
```

```hy
Help on function reciprocal in module fptk.core.funcs:

reciprocal(x)
    reciprocal(x) = 1 / x
```

## floor

[go up](#fptk-core-cheatsheet)

```hy
Name: floor
Kind: Reimport from [math]
Info: floor(1.9) = 1
```

```hy
Help on built-in function floor in module math:

floor(x, /)
    Return the floor of x as an Integral.
    
    This is the largest integer <= x.
```

## ceil

[go up](#fptk-core-cheatsheet)

```hy
Name: ceil
Kind: Reimport from [math]
Info: ceil(1.1) = 2
```

```hy
Help on built-in function ceil in module math:

ceil(x, /)
    Return the ceiling of x as an Integral.
    
    This is the smallest integer >= x.
```

## round_to

[go up](#fptk-core-cheatsheet)

```hy
Name: round_to
Kind: FPTK original
Sgnt: round_to(n, step)
Info: rounds to closest multiple of step: round_to(9.1, 1.5) == 9.0
```

```hy
Help on function round_to in module fptk.core.funcs:

round_to(n, step)
```

## clip

[go up](#fptk-core-cheatsheet)

```hy
Name: clip
Kind: FPTK original
Sgnt: clip(x, lower, upper)
Info: clips x to fit in lower <= x <= upper limit
```

```hy
Help on function clip in module fptk.core.funcs:

clip(x, lower, upper)
    clips x to fit in lower <= x <= upper limit
```

## approx_eq

[go up](#fptk-core-cheatsheet)

```hy
Name: approx_eq (= math.isclose)
Kind: Reimport
Info: approx_eq(a, b, *, rel_tol=1e-09, abs_tol=0.0)
```

```hy
Help on built-in function isclose in module math:

isclose(a, b, *, rel_tol=1e-09, abs_tol=0.0)
    Determine whether two floating point numbers are close in value.
    
      rel_tol
        maximum difference for being considered "close", relative to the
        magnitude of the input values
      abs_tol
        maximum difference for being considered "close", regardless of the
        magnitude of the input values
    
    Return True if a is close in value to b, and False otherwise.
    
    For the values to be considered close, the difference between them
    must be smaller than at least one of the tolerances.
    
    -inf, inf and NaN behave similarly to the IEEE 754 Standard.  That
    is, NaN is not close to anything, even itself.  inf and -inf are
    only close to themselves.
```

## sqrt

[go up](#fptk-core-cheatsheet)

```hy
Name: sqrt
Kind: Reimport from [math]
Sgnt: sqrt(n)
Info: = √n
```

```hy
Help on built-in function sqrt in module math:

sqrt(x, /)
    Return the square root of x.
```

## squared

[go up](#fptk-core-cheatsheet)

```hy
Name: squared
Kind: FPTK original
Sgnt: squared(x)
Info: = pow(x,2)
```

```hy
Help on function squared in module fptk.core.funcs:

squared(x)
    squared(x) = pow(x, 2)
```

## dist

[go up](#fptk-core-cheatsheet)

```hy
Name: dist
Kind: Reimport from [math]
Sgnt: dist(p, q) -> float
Info: ≈ √((px-qx)² + (py-qy)² ...)
```

```hy
Help on built-in function dist in module math:

dist(p, q, /)
    Return the Euclidean distance between two points p and q.
    
    The points should be specified as sequences (or iterables) of
    coordinates.  Both inputs must have the same dimension.
    
    Roughly equivalent to:
        sqrt(sum((px - qx) ** 2.0 for px, qx in zip(p, q)))
```

## hypot

[go up](#fptk-core-cheatsheet)

```hy
Name: hypot
Kind: Reimport from [math]
Sgnt: hypot(*coordinates)
Info: = √(x² + y² + ...)
```

```hy
Help on built-in function hypot in module math:

hypot(...)
    hypot(*coordinates) -> value
    
    Multidimensional Euclidean distance from the origin to a point.
    
    Roughly equivalent to:
        sqrt(sum(x**2 for x in coordinates))
    
    For a two dimensional point (x, y), gives the hypotenuse
    using the Pythagorean theorem:  sqrt(x*x + y*y).
    
    For example, the hypotenuse of a 3/4/5 right triangle is:
    
        >>> hypot(3.0, 4.0)
        5.0
```

## normalize

[go up](#fptk-core-cheatsheet)

```hy
Name: normalize
Kind: FPTK original
Sgnt: normalize(xs) -> xs
Info: will throw error for zero-len vector
```

```hy
Help on function normalize in module fptk.core.funcs:

normalize(xs)
    devides each coord of vector to vectors norm,
    example: norm of [1, 2, 3] = sqrt(1 + 4 + 9) = sqrt(14) ~= 3.74,
    so will return [1/3.74, 2/3.74, 3/3.74]
    ---
    will throw error for norm == 0
```

## exp

[go up](#fptk-core-cheatsheet)

```hy
Name: exp
Kind: Reimport from [math]
Sgnt: exp(x)
```

```hy
Help on built-in function exp in module math:

exp(x, /)
    Return e raised to the power of x.
```

## log

[go up](#fptk-core-cheatsheet)

```hy
Name: log
Kind: Reimport from [math]
Sgnt: log(x, base=math.e)
```

```hy
Help on built-in function log in module math:

log(...)
    log(x, [base=math.e])
    Return the logarithm of x to the given base.
    
    If the base not specified, returns the natural logarithm (base e) of x.
```

## ln

[go up](#fptk-core-cheatsheet)

```hy
Name: ln
Kind: FPTK original
Sgnt: ln(x)
Info: = math.log(x, math.e) ; coexists with log for clarity
```

```hy
Help on function ln in module fptk.core.funcs:

ln(x)
```

## log10

[go up](#fptk-core-cheatsheet)

```hy
Name: log10
Kind: Reimport from [math]
Sgnt: log10(x)
```

```hy
Help on built-in function log10 in module math:

log10(x, /)
    Return the base 10 logarithm of x.
```

## pi

[go up](#fptk-core-cheatsheet)

```hy
Name: pi
Kind: Reimport from [math]
Info: literally just float pi=3.14...
```

```hy
Help on float object:

class float(object)
 |  float(x=0, /)
 |  
 |  Convert a string or number to a floating point number, if possible.
 |  
 |  Methods defined here:
 |  
 |  __abs__(self, /)
 |      abs(self)
 |  
 |  __add__(self, value, /)
 |      Return self+value.
 |  
 |  __bool__(self, /)
 |      True if self else False
 |  
 |  __ceil__(self, /)
 |      Return the ceiling as an Integral.
 |  
 |  __divmod__(self, value, /)
 |      Return divmod(self, value).
 |  
 |  __eq__(self, value, /)
 |      Return self==value.
 |  
 |  __float__(self, /)
 |      float(self)
 |  
 |  __floor__(self, /)
 |      Return the floor as an Integral.
 |  
 |  __floordiv__(self, value, /)
 |      Return self//value.
 |  
 |  __format__(self, format_spec, /)
 |      Formats the float according to format_spec.
 |  
 |  __ge__(self, value, /)
 |      Return self>=value.
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __getnewargs__(self, /)
 |  
 |  __gt__(self, value, /)
 |      Return self>value.
 |  
 |  __hash__(self, /)
 |      Return hash(self).
 |  
 |  __int__(self, /)
 |      int(self)
 |  
 |  __le__(self, value, /)
 |      Return self<=value.
 |  
 |  __lt__(self, value, /)
 |      Return self<value.
 |  
 |  __mod__(self, value, /)
 |      Return self%value.
 |  
 |  __mul__(self, value, /)
 |      Return self*value.
 |  
 |  __ne__(self, value, /)
 |      Return self!=value.
 |  
 |  __neg__(self, /)
 |      -self
 |  
 |  __pos__(self, /)
 |      +self
 |  
 |  __pow__(self, value, mod=None, /)
 |      Return pow(self, value, mod).
 |  
 |  __radd__(self, value, /)
 |      Return value+self.
 |  
 |  __rdivmod__(self, value, /)
 |      Return divmod(value, self).
 |  
 |  __repr__(self, /)
 |      Return repr(self).
 |  
 |  __rfloordiv__(self, value, /)
 |      Return value//self.
 |  
 |  __rmod__(self, value, /)
 |      Return value%self.
 |  
 |  __rmul__(self, value, /)
 |      Return value*self.
 |  
 |  __round__(self, ndigits=None, /)
 |      Return the Integral closest to x, rounding half toward even.
 |      
 |      When an argument is passed, work like built-in round(x, ndigits).
 |  
 |  __rpow__(self, value, mod=None, /)
 |      Return pow(value, self, mod).
 |  
 |  __rsub__(self, value, /)
 |      Return value-self.
 |  
 |  __rtruediv__(self, value, /)
 |      Return value/self.
 |  
 |  __sub__(self, value, /)
 |      Return self-value.
 |  
 |  __truediv__(self, value, /)
 |      Return self/value.
 |  
 |  __trunc__(self, /)
 |      Return the Integral closest to x between 0 and x.
 |  
 |  as_integer_ratio(self, /)
 |      Return integer ratio.
 |      
 |      Return a pair of integers, whose ratio is exactly equal to the original float
 |      and with a positive denominator.
 |      
 |      Raise OverflowError on infinities and a ValueError on NaNs.
 |      
 |      >>> (10.0).as_integer_ratio()
 |      (10, 1)
 |      >>> (0.0).as_integer_ratio()
 |      (0, 1)
 |      >>> (-.25).as_integer_ratio()
 |      (-1, 4)
 |  
 |  conjugate(self, /)
 |      Return self, the complex conjugate of any float.
 |  
 |  hex(self, /)
 |      Return a hexadecimal representation of a floating-point number.
 |      
 |      >>> (-0.1).hex()
 |      '-0x1.999999999999ap-4'
 |      >>> 3.14159.hex()
 |      '0x1.921f9f01b866ep+1'
 |  
 |  is_integer(self, /)
 |      Return True if the float is an integer.
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  __getformat__(typestr, /) from builtins.type
 |      You probably don't want to use this function.
 |      
 |        typestr
 |          Must be 'double' or 'float'.
 |      
 |      It exists mainly to be used in Python's test suite.
 |      
 |      This function returns whichever of 'unknown', 'IEEE, big-endian' or 'IEEE,
 |      little-endian' best describes the format of floating point numbers used by the
 |      C type named by typestr.
 |  
 |  __setformat__(typestr, fmt, /) from builtins.type
 |      You probably don't want to use this function.
 |      
 |        typestr
 |          Must be 'double' or 'float'.
 |        fmt
 |          Must be one of 'unknown', 'IEEE, big-endian' or 'IEEE, little-endian',
 |          and in addition can only be one of the latter two if it appears to
 |          match the underlying C reality.
 |      
 |      It exists mainly to be used in Python's test suite.
 |      
 |      Override the automatic determination of C-level floating point type.
 |      This affects how floats are converted to and from binary strings.
 |  
 |  fromhex(string, /) from builtins.type
 |      Create a floating-point number from a hexadecimal string.
 |      
 |      >>> float.fromhex('0x1.ffffp10')
 |      2047.984375
 |      >>> float.fromhex('-0x1p-1074')
 |      -5e-324
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  imag
 |      the imaginary part of a complex number
 |  
 |  real
 |      the real part of a complex number
```

## sin

[go up](#fptk-core-cheatsheet)

```hy
Name: sin
Kind: Reimport from [math]
Sgnt: sin(x)
Info: x is in radians
```

```hy
Help on built-in function sin in module math:

sin(x, /)
    Return the sine of x (measured in radians).
```

## cos

[go up](#fptk-core-cheatsheet)

```hy
Name: cos
Kind: Reimport from [math]
Sgnt: cos(x)
Info: x is in radians
```

```hy
Help on built-in function cos in module math:

cos(x, /)
    Return the cosine of x (measured in radians).
```

## tan

[go up](#fptk-core-cheatsheet)

```hy
Name: tan
Kind: Reimport from [math]
Sgnt: tan(x)
Info: x is in radians, will give smth like 1.6E+16 for x = pi
```

```hy
Help on built-in function tan in module math:

tan(x, /)
    Return the tangent of x (measured in radians).
```

## degrees

[go up](#fptk-core-cheatsheet)

```hy
Name: degrees
Kind: Reimport from [math]
Sgnt: degrees(x)
Info: x in radians is converted to degrees
```

```hy
Help on built-in function degrees in module math:

degrees(x, /)
    Convert angle x from radians to degrees.
```

## radians

[go up](#fptk-core-cheatsheet)

```hy
Name: radians
Kind: Reimport from [math]
Sgnt: radians(x)
Info: x in degrees is converted to radians
```

```hy
Help on built-in function radians in module math:

radians(x, /)
    Convert angle x from degrees to radians.
```

## acos

[go up](#fptk-core-cheatsheet)

```hy
Name: acos
Kind: Reimport from [math]
Sgnt: acos(x)
Info: x is in radians, result is between 0 and pi
```

```hy
Help on built-in function acos in module math:

acos(x, /)
    Return the arc cosine (measured in radians) of x.
    
    The result is between 0 and pi.
```

## asin

[go up](#fptk-core-cheatsheet)

```hy
Name: asin
Kind: Reimport from [math]
Sgnt: asin(x)
Info: x is in radians, result is between -pi/2 and pi/2
```

```hy
Help on built-in function asin in module math:

asin(x, /)
    Return the arc sine (measured in radians) of x.
    
    The result is between -pi/2 and pi/2.
```

## atan

[go up](#fptk-core-cheatsheet)

```hy
Name: atan
Kind: Reimport from [math]
Sgnt: asin(x)
Info: x is in radians, result is between -pi/2 and pi/2
```

```hy
Help on built-in function atan in module math:

atan(x, /)
    Return the arc tangent (measured in radians) of x.
    
    The result is between -pi/2 and pi/2.
```

## atan2

[go up](#fptk-core-cheatsheet)

```hy
Name: atan2
Kind: Reimport from [math]
Sgnt: atan2(y, x)
Info: both signs are considered
```

```hy
Help on built-in function atan2 in module math:

atan2(y, x, /)
    Return the arc tangent (measured in radians) of y/x.
    
    Unlike atan(y/x), the signs of both x and y are considered.
```

## choice

[go up](#fptk-core-cheatsheet)

```hy
Name: choice
Kind: Reimport from [random]
Sgnt: choice(seq) -> Elem
Info: throws error for empty list
```

```hy
Help on method choice in module random:

choice(seq) method of random.Random instance
    Choose a random element from a non-empty sequence.
```

## randint

[go up](#fptk-core-cheatsheet)

```hy
Name: randint
Kind: Reimport from [random]
Sgnt: randint(a, b) -> int
Info: returns random integer in range [a, b] including both end points
```

```hy
Help on method randint in module random:

randint(a, b) method of random.Random instance
    Return random integer in range [a, b], including both end points.
```

## randfloat

[go up](#fptk-core-cheatsheet)

```hy
Name: randfloat (= random.uniform)
Kind: Reimport
Sgnt: randfloat(a, b) -> float
Info: range is [a, b) or [a, b] depending on rounding
```

```hy
Help on method uniform in module random:

uniform(a, b) method of random.Random instance
    Get a random number in the range [a, b) or [a, b] depending on rounding.
```

## rand01

[go up](#fptk-core-cheatsheet)

```hy
Name: rand01 (= random.random)
Kind: Reimport
Sgnt: rand01() -> float
Info: generates random number in interval [0, 1)
```

```hy
Help on built-in function random:

random() method of random.Random instance
    random() -> x in the interval [0, 1).
```

## sums

[go up](#fptk-core-cheatsheet)

```hy
Name: sums
Kind: Reimport from [funcy]
Sgnt: sums(seq [, acc]) -> generator
Info: reductions with addition function
```

```hy
Help on function sums in module funcy.seqs:

sums(seq, acc=EMPTY)
    Yields partial sums of seq.
```

## lsums

[go up](#fptk-core-cheatsheet)

```hy
Name: lsums
Kind: Reimport from [funcy]
Sgnt: lsums(seq [, acc]) -> list
Info: list version of sums
```

```hy
Help on function lsums in module funcy.seqs:

lsums(seq, acc=EMPTY)
    Lists partial sums of seq.
```

## product

[go up](#fptk-core-cheatsheet)

```hy
Name: product (= math.prod)
Kind: Reimport
Sgnt: product(iterable, /, *, start=1)
Info: product([2, 3, 5]) = 30
```

```hy
Help on built-in function prod in module math:

prod(iterable, /, *, start=1)
    Calculate the product of all the elements in the input iterable.
    
    The default start value for the product is 1.
    
    When the iterable is empty, return the start value.  This function is
    intended specifically for use with numeric values and may reject
    non-numeric types.
```

## minus

[go up](#fptk-core-cheatsheet)

```hy
Name: minus
Kind: FPTK original
Sgnt: minus(x, y) = x - y
```

```hy
Help on function minus in module fptk.core.funcs:

minus(x, y)
    minux(x, y) = x - y
```

## neg

[go up](#fptk-core-cheatsheet)

```hy
Name: neg
Kind: Reimport from [operator]
Sgnt: neg(n)
Info: = -1 * n
```

```hy
Help on built-in function neg in module _operator:

neg(a, /)
    Same as -a.
```

## mod

[go up](#fptk-core-cheatsheet)

```hy
Name: mod
Kind: Reimport from [operator]
Sgnt: mod(5, 2)
Info: = 1
```

```hy
Help on built-in function mod in module _operator:

mod(a, b, /)
    Same as a % b.
```

## matmul

[go up](#fptk-core-cheatsheet)

```hy
Name: matmul
Kind: Reimport from [operator]
Info: '@' as function
```

```hy
Help on built-in function matmul in module _operator:

matmul(a, b, /)
    Same as a @ b.
```

## div

[go up](#fptk-core-cheatsheet)

```hy
Name: div (= operator.truediv)
Kind: Reimport
Sgnt: div(a, b)
```

```hy
Help on built-in function truediv in module _operator:

truediv(a, b, /)
    Same as a / b.
```

## and_

[go up](#fptk-core-cheatsheet)

```hy
Name: and_
Kind: Reimport from [operator]
Info: 'and' as function
```

```hy
Help on built-in function and_ in module _operator:

and_(a, b, /)
    Same as a & b.
```

## or_

[go up](#fptk-core-cheatsheet)

```hy
Name: or_
Kind: Reimport from [operator]
Info: 'or' as function
```

```hy
Help on built-in function or_ in module _operator:

or_(a, b, /)
    Same as a | b.
```

## not_

[go up](#fptk-core-cheatsheet)

```hy
Name: not_
Kind: Reimport from [operator]
Info: 'not' as function
```

```hy
Help on built-in function not_ in module _operator:

not_(a, /)
    Same as not a.
```

## is_

[go up](#fptk-core-cheatsheet)

```hy
Name: is_
Kind: Reimport from [operator]
Info: 'is' as function
```

```hy
Help on built-in function is_ in module _operator:

is_(a, b, /)
    Same as a is b.
```

## xor

[go up](#fptk-core-cheatsheet)

```hy
Name: xor
Kind: Reimport from [operator]
```

```hy
Help on built-in function xor in module _operator:

xor(a, b, /)
    Same as a ^ b.
```

## eq

[go up](#fptk-core-cheatsheet)

```hy
Name: eq
Kind: Reimport from [operator]
Info: equal
```

```hy
Help on built-in function eq in module _operator:

eq(a, b, /)
    Same as a == b.
```

## neq

[go up](#fptk-core-cheatsheet)

```hy
Name: neq (= operator.ne)
Kind: Reimport
Info: non-equal
```

```hy
Help on built-in function ne in module _operator:

ne(a, b, /)
    Same as a != b.
```

## gt

[go up](#fptk-core-cheatsheet)

```hy
Name: gt
Kind: Reimport from [operator]
Info: greater than
```

```hy
Help on built-in function gt in module _operator:

gt(a, b, /)
    Same as a > b.
```

## lt

[go up](#fptk-core-cheatsheet)

```hy
Name: lt
Kind: Reimport from [operator]
Info: less than
```

```hy
Help on built-in function lt in module _operator:

lt(a, b, /)
    Same as a < b.
```

## geq

[go up](#fptk-core-cheatsheet)

```hy
Name: geq (= operator.ge)
Kind: Reimport
Info: greater or equal
```

```hy
Help on built-in function ge in module _operator:

ge(a, b, /)
    Same as a >= b.
```

## leq

[go up](#fptk-core-cheatsheet)

```hy
Name: leq (= operator.le)
Kind: Reimport
Info: less or equal
```

```hy
Help on built-in function le in module _operator:

le(a, b, /)
    Same as a <= b.
```

## gt0

[go up](#fptk-core-cheatsheet)

```hy
Name: gt0
Kind: FPTK original
Sgnt: gt0(x)
Info: checks for x > 0
```

```hy
Help on function gt0 in module fptk.core.funcs:

gt0(x)
    checks for x > 0
```

## geq0

[go up](#fptk-core-cheatsheet)

```hy
Name: geq0
Kind: FPTK original
Sgnt: geq0(x)
Info: x >= 0
```

```hy
Help on function geq0 in module fptk.core.funcs:

geq0(x)
    checks for x >= 0
```

## lt0

[go up](#fptk-core-cheatsheet)

```hy
Name: lt0
Kind: FPTK original
Sgnt: lt0(x)
Info: checks for x < 0
```

```hy
Help on function lt0 in module fptk.core.funcs:

lt0(x)
    checks for x < 0
```

## leq0

[go up](#fptk-core-cheatsheet)

```hy
Name: leq0
Kind: FPTK original
Sgnt: leq0(x)
Info: x <= 0
```

```hy
Help on function leq0 in module fptk.core.funcs:

leq0(x)
    checks for x <= 0
```

## mul

[go up](#fptk-core-cheatsheet)

```hy
Name: mul
Kind: FPTK original
Sgnt: mul(*args)
Info: literally just mul(a,b,c,...)=a*b*c*...; can also be used with 0 or 1 arg
```

```hy
Help on function mul in module fptk.core.funcs:

mul(*args)
    literally just: mul(a, b, ...) = a * b * ... ;
    can also be used with 0 or 1 arg
```

## smul

[go up](#fptk-core-cheatsheet)

```hy
Name: smul
Kind: FPTK original
Sgnt: smul(*args)
Info: synonim of mul (with underlined usage on strings)
```

```hy
Help on function smul in module fptk.core.funcs:

smul(*args)
    just a * operator as function;
    can be used to underline usage on strings like:
    smul('a', 3) == 'aaa'
```

## lmul

[go up](#fptk-core-cheatsheet)

```hy
Name: lmul
Kind: FPTK original
Sgnt: lmul(*args)
Info: synonim of mul (with underlined usage on lists)
```

```hy
Help on function lmul in module fptk.core.funcs:

lmul(*args)
    just a * operator as function;
    can be used to underline usage on lists like:
    lmul([1], 3) == [1, 1, 1]
```

## plus

[go up](#fptk-core-cheatsheet)

```hy
Name: plus
Kind: FPTK original
Sgnt: plus(*args)
Info: literally just plus(a,b,c,...)=a+b+c...; can also be used with 0 or 1 arg
```

```hy
Help on function plus in module fptk.core.funcs:

plus(*args)
    literally just: plus(a, b, ...) = a + b + ... ;
    can also be used with 0 or 1 arg
```

## sconcat

[go up](#fptk-core-cheatsheet)

```hy
Name: sconcat
Kind: FPTK original
Sgnt: sconcat(*args)
Info: string concantenation as a monoid (will not give error when used with 0 or 1 args)
```

```hy
Help on function sconcat in module fptk.core.funcs:

sconcat(*args)
    sconcat(s1, s2, ...) = '' + s1 + s2 + ...
    string concantenation as a monoid with identity = '',
    can be used with 0 or 1 args
```

## strlen

[go up](#fptk-core-cheatsheet)

```hy
Name: strlen
Kind: FPTK original
Sgnt: strlen(text)
Info: rename of len, underlines usage on strings
```

```hy
Help on function strlen in module fptk.core.funcs:

strlen(text)
    rename of len, underlines usage on strings
```

## str_join

[go up](#fptk-core-cheatsheet)

```hy
Name: str_join
Kind: FPTK original
Sgnt: str_join(ss, sep='')
Info: rearrangement of funcy.str_join, ss is seq of strings
```

```hy
Help on function str_join in module fptk.core.funcs:

str_join(ss, sep='')
    str_join(['1', '2', '3'], '-') = '1-2-3'
```

## enlengthen

[go up](#fptk-core-cheatsheet)

```hy
Name: enlengthen
Kind: FPTK original
Sgnt: enlengthen(target_len, string, char=' ', on_tail=True)
Info: adds char to string until target_len reached
```

```hy
Help on function enlengthen in module fptk.core.funcs:

enlengthen(target_len: int, string: str, char: str = ' ', on_tail: bool = True, force_len: bool = False) -> str
    appends char to string until target_len reached
    
    - if len(string) > target_len, will return string with no change
    - with on_tail=False will prepend chars rather than append
    - with force_len=True will cut string to target_len if required (taking on_tail option into account)
    - when len(char)> 1 is given, repeats it's pattern, but still ensures target_len
```

## lowercase

[go up](#fptk-core-cheatsheet)

```hy
Name: lowercase
Kind: FPTK original
Sgnt: lowercase(string)
Info: str.lower method as a function
```

```hy
Help on function lowercase in module fptk.core.funcs:

lowercase(string: str) -> str
    str.lower method as a function
```

## strip

[go up](#fptk-core-cheatsheet)

```hy
Name: strip
Kind: FPTK original
Sgnt: strip(string, chars=None)
Info: str.strip method as a function
```

```hy
Help on function strip in module fptk.core.funcs:

strip(string: str, chars=None) -> str
    str.strip method as a function,
    removes leading and trailing whitespaces (or chars when given)
```

## lstrip

[go up](#fptk-core-cheatsheet)

```hy
Name: lstrip
Kind: FPTK original
Sgnt: lstrip(string, chars=None)
Info: str.lstrip method as a function
```

```hy
Help on function lstrip in module fptk.core.funcs:

lstrip(string: str, chars=None) -> str
    str.lstrip method as a function
```

## rstrip

[go up](#fptk-core-cheatsheet)

```hy
Name: rstrip
Kind: FPTK original
Sgnt: rstrip(string, chars=None)
Info: str.rstrip method as a function
```

```hy
Help on function rstrip in module fptk.core.funcs:

rstrip(string: str, chars=None) -> str
    str.rstrip method as a function
```

## re_sub

[go up](#fptk-core-cheatsheet)

```hy
Name: re_sub (= re.sub)
Kind: Reimport
Sgnt: re_sub(rpattern, replacement, string, count=0, flags=0)
```

```hy
Help on function sub in module re:

sub(pattern, repl, string, count=0, flags=0)
    Return the string obtained by replacing the leftmost
    non-overlapping occurrences of the pattern in string by the
    replacement repl.  repl can be either a string or a callable;
    if a string, backslash escapes in it are processed.  If it is
    a callable, it's passed the Match object and must return
    a replacement string to be used.
```

## re_split

[go up](#fptk-core-cheatsheet)

```hy
Name: re_split (= re.split)
Kind: Reimport
Sgnt: re_split(rpattern, string)
```

```hy
Help on function split in module re:

split(pattern, string, maxsplit=0, flags=0)
    Split the source string by the occurrences of the pattern,
    returning a list containing the resulting substrings.  If
    capturing parentheses are used in pattern, then the text of all
    groups in the pattern are also returned as part of the resulting
    list.  If maxsplit is nonzero, at most maxsplit splits occur,
    and the remainder of the string is returned as the final element
    of the list.
```

## re_find

[go up](#fptk-core-cheatsheet)

```hy
Name: re_find
Kind: Reimport from [funcy]
Sgnt: re_find(rpattern, string, flags=0) -> str
Info: returns first found
```

```hy
Help on function re_find in module funcy.strings:

re_find(regex, s, flags=0)
    Matches regex against the given string,
    returns the match in the simplest possible form.
```

## re_test

[go up](#fptk-core-cheatsheet)

```hy
Name: re_test
Kind: Reimport from [funcy]
Sgnt: re_test(rpattern, string, ...) -> bool
Info: tests if string has match (not neccessarily whole string)
```

```hy
Help on function re_test in module funcy.strings:

re_test(regex, s, flags=0)
    Tests whether regex matches against s.
```

## re_all

[go up](#fptk-core-cheatsheet)

```hy
Name: re_all
Kind: Reimport from [funcy]
Sgnt: re_all(rpattern, string, ...) -> List
Info: returns tuples if groups requested like via r'a(b)(c)d'
```

```hy
Help on function re_all in module funcy.strings:

re_all(regex, s, flags=0)
    Lists all matches of regex in s, presents them in simplest possible form
```

## assoc

[go up](#fptk-core-cheatsheet)

```hy
Name: assoc
Kind: Reimport from [fptk/hyrule]
Sgnt: assoc(xs, k1, v1, k2, v2, ...) -> None
Info: ≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)
```

```hy
Help on function assoc in module fptk.core.from_hyrule:

assoc(coll, *kvs, **kwargs)
    usage: (assoc collection idx value)
    returns None
```

## nth

[go up](#fptk-core-cheatsheet)

```hy
Name: nth
Kind: Reimport from [funcy]
Sgnt: nth(n, seq) -> Optional elem
Info: 0-based index; works also with dicts
```

```hy
Help on function nth in module funcy.seqs:

nth(n, seq)
    Returns nth item in the sequence or None if no such item exists.
```

## first

[go up](#fptk-core-cheatsheet)

```hy
Name: first
Kind: Reimport from [funcy]
Sgnt: first(seq) -> Optional elem
```

```hy
Help on function first in module funcy.seqs:

first(seq)
    Returns the first item in the sequence.
    Returns None if the sequence is empty.
```

## second

[go up](#fptk-core-cheatsheet)

```hy
Name: second
Kind: Reimport from [funcy]
Sgnt: second(seq) -> Optional elem
```

```hy
Help on function second in module funcy.seqs:

second(seq)
    Returns second item in the sequence.
    Returns None if there are less than two items in it.
```

## third

[go up](#fptk-core-cheatsheet)

```hy
Name: third
Kind: FPTK original
Sgnt: third(seq) -> Optional elem
```

```hy
Help on function third in module fptk.core.funcs:

third(seq)
```

## fourth

[go up](#fptk-core-cheatsheet)

```hy
Name: fourth
Kind: FPTK original
Sgnt: fourth(seq) -> Optional elem
```

```hy
Help on function fourth in module fptk.core.funcs:

fourth(seq)
```

## beforelast

[go up](#fptk-core-cheatsheet)

```hy
Name: beforelast
Kind: FPTK original
Sgnt: beforelast(seq) -> Optional elem
```

```hy
Help on function beforelast in module fptk.core.funcs:

beforelast(seq)
```

## last

[go up](#fptk-core-cheatsheet)

```hy
Name: last
Kind: Reimport from [funcy]
Sgnt: last(seq) -> Optional elem
```

```hy
Help on function last in module funcy.seqs:

last(seq)
    Returns the last item in the sequence or iterator.
    Returns None if the sequence is empty.
```

## rest

[go up](#fptk-core-cheatsheet)

```hy
Name: rest
Kind: FPTK original
Sgnt: rest(seq) -> List
Info: drops 1st elem of list
```

```hy
Help on function rest in module fptk.core.funcs:

rest(seq)
    drops 1st elem of list
```

## butlast

[go up](#fptk-core-cheatsheet)

```hy
Name: butlast
Kind: FPTK original
Sgnt: butlast(seq) -> List
Info: drops last elem of list
```

```hy
Help on function butlast in module fptk.core.funcs:

butlast(seq)
    drops last elem of list
```

## drop

[go up](#fptk-core-cheatsheet)

```hy
Name: drop
Kind: FPTK original
Sgnt: drop(n, seq) -> List
Info: drops n>=0 elems from start of the list; when n<0, drops from end of the list
```

```hy
Help on function drop in module fptk.core.funcs:

drop(n, seq)
    drops n>=0 elems from start of seq; when n<0, drops from end of the seq
```

## take

[go up](#fptk-core-cheatsheet)

```hy
Name: take
Kind: FPTK original
Sgnt: take(n, seq) -> List
Info: takes n elems from start; when n<0, takes from end of the list
```

```hy
Help on function take in module fptk.core.funcs:

take(n, seq)
    takes n>=0 elems from start of seq; when n<0, takes from end of the seq
```

## pick

[go up](#fptk-core-cheatsheet)

```hy
Name: pick
Kind: FPTK original
Sgnt: pick(ns, seq) -> List
Info: throws error if some of ns doesn't exist; ns can be list of ints or dict keys
```

```hy
Help on function pick in module fptk.core.funcs:

pick(ns, seq)
    pics elems ns from seq,
    throws error if some of ns doesn't exist,
    ns can be list of dicts keys
```

## pluck

[go up](#fptk-core-cheatsheet)

```hy
Name: pluck
Kind: Reimport from [funcy]
Sgnt: pluck(key, mappings) -> generator
Info: gets same key (or idx) from every mapping, mappings can be lists of lists/dicts/etc.
```

```hy
Help on function pluck in module funcy.colls:

pluck(key, mappings)
    Iterates over values for key in mappings.
```

## lpluck

[go up](#fptk-core-cheatsheet)

```hy
Name: lpluck
Kind: Reimport from [funcy]
Sgnt: lpluck(key, mappings) -> list
```

```hy
Help on function lpluck in module funcy.colls:

lpluck(key, mappings)
    Lists values for key in each mapping.
```

## pluck_attr

[go up](#fptk-core-cheatsheet)

```hy
Name: pluck_attr
Kind: Reimport from [funcy]
Sgnt: pluck_attr(attr, objects) -> generator
Info: attr should be given as str
```

```hy
Help on function pluck_attr in module funcy.colls:

pluck_attr(attr, objects)
    Iterates over values of given attribute of given objects.
```

## lpluck_attr

[go up](#fptk-core-cheatsheet)

```hy
Name: lpluck_attr
Kind: Reimport from [funcy]
Sgnt: lpluck_attr(attr, objects) -> list
Info: list version of pluck_attr
```

```hy
Help on function lpluck_attr in module funcy.colls:

lpluck_attr(attr, objects)
    Lists values of given attribute of each object.
```

## mask_sel

[go up](#fptk-core-cheatsheet)

```hy
Name: mask_sel (= itertools.compress)
Kind: Reimport
Sgnt: mask_sel('abc', [1,0,1]) -> iterator: 'a', 'c'
```

```hy
Help on class compress in module itertools:

class compress(builtins.object)
 |  compress(data, selectors)
 |  
 |  Return data elements corresponding to true selector elements.
 |  
 |  Forms a shorter iterator from selected data elements using the selectors to
 |  choose the data elements.
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## lmask_sel

[go up](#fptk-core-cheatsheet)

```hy
Name: lmask_sel
Kind: FPTK original
Sgnt: lmask_sel(data, selectors) -> list
```

```hy
Help on function lmask_sel in module fptk.core.funcs:

lmask_sel(data, selectors)
    selects by mask: lmask_sel('abc', [1,0,1]) -> ['a', 'c']
```

## mask2idxs

[go up](#fptk-core-cheatsheet)

```hy
Name: mask2idxs
Kind: FPTK original
Sgnt: mask2idxs(mask) -> list
Info: mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]
```

```hy
Help on function mask2idxs in module fptk.core.funcs:

mask2idxs(mask)
    mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]
```

## idxs2mask

[go up](#fptk-core-cheatsheet)

```hy
Name: idxs2mask
Kind: FPTK original
Sgnt: idxs2mask(idxs) -> list
Info: idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]
```

```hy
Help on function idxs2mask in module fptk.core.funcs:

idxs2mask(idxs, bools=False)
    idxs is non-sorted list of positive integers like [0 3 2], which will be converted to [1 0 1 1] ;
    setting bools=True will output [True False True True] instead
```

## ncut

[go up](#fptk-core-cheatsheet)

```hy
Name: ncut
Kind: Macro from [fptk/hyrule]
```

## pluckm

[go up](#fptk-core-cheatsheet)

```hy
Name: pluckm
Kind: Macro from [fptk]
Sgnt: (pluckm n xs) (pluckm key ys) (pluckm .attr zs)
Info: accepts fptk-style .arg syntax
```

## lpluckm

[go up](#fptk-core-cheatsheet)

```hy
Name: lpluckm
Kind: Macro from [fptk]
Info: list version of pluckm
```

## getattrm

[go up](#fptk-core-cheatsheet)

```hy
Name: getattrm
Kind: Macro from [fptk]
Sgnt: (getattrm Object 'attr') (getattrm Object .attr)
Info: accepts fptk-style .attr syntax
```

## Enum

[go up](#fptk-core-cheatsheet)

```hy
Name: Enum
Kind: Reimport from [enum]
```

```hy
Help on class Enum in module enum:

class Enum(builtins.object)
 |  Enum(value, names=None, *, module=None, qualname=None, type=None, start=1)
 |  
 |  Generic enumeration.
 |  
 |  Derive from this class to define new enumerations.
 |  
 |  Data descriptors defined here:
 |  
 |  name
 |      The name of the Enum member.
 |  
 |  value
 |      The value of the Enum member.
 |  
 |  ----------------------------------------------------------------------
 |  Readonly properties inherited from EnumMeta:
 |  
 |  __members__
 |      Returns a mapping of member name->value.
 |      
 |      This mapping lists all enum members, including aliases. Note that this
 |      is a read-only view of the internal mapping.
```

## List

[go up](#fptk-core-cheatsheet)

```hy
Name: List
Kind: Reimport from [typing]
```

```hy
Help on _SpecialGenericAlias in module typing:

List = typing.List
    A generic version of list.
```

## Tuple

[go up](#fptk-core-cheatsheet)

```hy
Name: Tuple
Kind: Reimport from [typing]
```

```hy
Help on _TupleType in module typing:

Tuple = typing.Tuple
    Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
    
    Example: Tuple[T1, T2] is a tuple of two elements corresponding
    to type variables T1 and T2.  Tuple[int, float, str] is a tuple
    of an int, a float and a string.
    
    To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
```

## TypedDict

[go up](#fptk-core-cheatsheet)

```hy
Name: TypedDict
Kind: Reimport from [typing]
```

```hy
Help on function TypedDict in module typing:

TypedDict(typename, fields=None, /, *, total=True, **kwargs)
    A simple typed namespace. At runtime it is equivalent to a plain dict.
    
    TypedDict creates a dictionary type that expects all of its
    instances to have a certain set of keys, where each key is
    associated with a value of a consistent type. This expectation
    is not checked at runtime but is only enforced by type checkers.
    Usage::
    
        class Point2D(TypedDict):
            x: int
            y: int
            label: str
    
        a: Point2D = {'x': 1, 'y': 2, 'label': 'good'}  # OK
        b: Point2D = {'z': 3, 'label': 'bad'}           # Fails type check
    
        assert Point2D(x=1, y=2, label='first') == dict(x=1, y=2, label='first')
    
    The type info can be accessed via the Point2D.__annotations__ dict, and
    the Point2D.__required_keys__ and Point2D.__optional_keys__ frozensets.
    TypedDict supports two additional equivalent forms::
    
        Point2D = TypedDict('Point2D', x=int, y=int, label=str)
        Point2D = TypedDict('Point2D', {'x': int, 'y': int, 'label': str})
    
    By default, all keys must be present in a TypedDict. It is possible
    to override this by specifying totality.
    Usage::
    
        class point2D(TypedDict, total=False):
            x: int
            y: int
    
    This means that a point2D TypedDict can have any of the keys omitted.A type
    checker is only expected to support a literal False or True as the value of
    the total argument. True is the default, and makes all items defined in the
    class body be required.
    
    The class syntax is only supported in Python 3.6+, while two other
    syntax forms work for Python 2.7 and 3.2+
```

## Dict

[go up](#fptk-core-cheatsheet)

```hy
Name: Dict
Kind: Reimport from [typing]
```

```hy
Help on _SpecialGenericAlias in module typing:

Dict = typing.Dict
    A generic version of dict.
```

## Union

[go up](#fptk-core-cheatsheet)

```hy
Name: Union
Kind: Reimport from [typing]
```

```hy
Help on _SpecialForm in module typing:

Union = typing.Union
    Union type; Union[X, Y] means either X or Y.
    
    To define a union, use e.g. Union[int, str].  Details:
    - The arguments must be types and there must be at least one.
    - None as an argument is a special case and is replaced by
      type(None).
    - Unions of unions are flattened, e.g.::
    
        Union[Union[int, str], float] == Union[int, str, float]
    
    - Unions of a single argument vanish, e.g.::
    
        Union[int] == int  # The constructor actually returns int
    
    - Redundant arguments are skipped, e.g.::
    
        Union[int, str, int] == Union[int, str]
    
    - When comparing unions, the argument order is ignored, e.g.::
    
        Union[int, str] == Union[str, int]
    
    - You cannot subclass or instantiate a union.
    - You can use Optional[X] as a shorthand for Union[X, None].
```

## Generator

[go up](#fptk-core-cheatsheet)

```hy
Name: Generator
Kind: Reimport from [typing]
```

```hy
Help on _SpecialGenericAlias in module typing:

Generator = typing.Generator
    A generic version of collections.abc.Generator.
```

## Any

[go up](#fptk-core-cheatsheet)

```hy
Name: Any
Kind: Reimport from [typing]
```

```hy
Help on _SpecialForm in module typing:

Any = typing.Any
    Special type indicating an unconstrained type.
    
    - Any is compatible with every type.
    - Any assumed to have all methods.
    - All values assumed to be instances of Any.
    
    Note that all the above statements are true from the point of view of
    static type checkers. At runtime, Any should not be used with instance
    or class checks.
```

## Optional

[go up](#fptk-core-cheatsheet)

```hy
Name: Optional
Kind: Reimport from [typing]
```

```hy
Help on _SpecialForm in module typing:

Optional = typing.Optional
    Optional type.
    
    Optional[X] is equivalent to Union[X, None].
```

## Callable

[go up](#fptk-core-cheatsheet)

```hy
Name: Callable
Kind: Reimport from [typing]
```

```hy
Help on _CallableType in module typing:

Callable = typing.Callable
    Callable type; Callable[[int], str] is a function of (int) -> str.
    
    The subscription syntax must always be used with exactly two
    values: the argument list and the return type.  The argument list
    must be a list of types or ellipsis; the return type must be a single type.
    
    There is no syntax to indicate optional or keyword arguments,
    such function types are rarely used as callback types.
```

## Literal

[go up](#fptk-core-cheatsheet)

```hy
Name: Literal
Kind: Reimport from [typing]
```

```hy
Help on _LiteralSpecialForm in module typing:

Literal = typing.Literal
    Special typing form to define literal types (a.k.a. value types).
    
    This form can be used to indicate to type checkers that the corresponding
    variable or function parameter has a value equivalent to the provided
    literal (or one of several literals):
    
      def validate_simple(data: Any) -> Literal[True]:  # always returns True
          ...
    
      MODE = Literal['r', 'rb', 'w', 'wb']
      def open_helper(file: str, mode: MODE) -> str:
          ...
    
      open_helper('/some/path', 'r')  # Passes type check
      open_helper('/other/path', 'typo')  # Error in type checker
    
    Literal[...] cannot be subclassed. At runtime, an arbitrary value
    is allowed as type argument to Literal[...], but type checkers may
    impose restrictions.
```

## Type

[go up](#fptk-core-cheatsheet)

```hy
Name: Type
Kind: Reimport from [typing]
```

```hy
Help on _SpecialGenericAlias in module typing:

Type = typing.Type
    A special construct usable to annotate class objects.
    
    For example, suppose we have the following classes::
    
      class User: ...  # Abstract base for User classes
      class BasicUser(User): ...
      class ProUser(User): ...
      class TeamUser(User): ...
    
    And a function that takes a class argument that's a subclass of
    User and returns an instance of the corresponding class::
    
      U = TypeVar('U', bound=User)
      def new_user(user_class: Type[U]) -> U:
          user = user_class()
          # (Here we could write the user object to a database)
          return user
    
      joe = new_user(BasicUser)
    
    At this point the type checker knows that joe has type BasicUser.
```

## TypeVar

[go up](#fptk-core-cheatsheet)

```hy
Name: TypeVar
Kind: Reimport from [typing]
```

```hy
Help on class TypeVar in module typing:

class TypeVar(_Final, _Immutable, _TypeVarLike)
 |  TypeVar(name, *constraints, bound=None, covariant=False, contravariant=False)
 |  
 |  Type variable.
 |  
 |  Usage::
 |  
 |    T = TypeVar('T')  # Can be anything
 |    A = TypeVar('A', str, bytes)  # Must be str or bytes
 |  
 |  Type variables exist primarily for the benefit of static type
 |  checkers.  They serve as the parameters for generic types as well
 |  as for generic function definitions.  See class Generic for more
 |  information on generic types.  Generic functions work as follows:
 |  
 |    def repeat(x: T, n: int) -> List[T]:
 |        '''Return a list containing n references to x.'''
 |        return [x]*n
 |  
 |    def longest(x: A, y: A) -> A:
 |        '''Return the longest of two strings.'''
 |        return x if len(x) >= len(y) else y
 |  
 |  The latter example's signature is essentially the overloading
 |  of (str, str) -> str and (bytes, bytes) -> bytes.  Also note
 |  that if the arguments are instances of some subclass of str,
 |  the return type is still plain str.
 |  
 |  At runtime, isinstance(x, T) and issubclass(C, T) will raise TypeError.
 |  
 |  Type variables defined with covariant=True or contravariant=True
 |  can be used to declare covariant or contravariant generic types.
 |  See PEP 484 for more details. By default generic types are invariant
 |  in all type variables.
 |  
 |  Type variables can be introspected. e.g.:
 |  
 |    T.__name__ == 'T'
 |    T.__constraints__ == ()
 |    T.__covariant__ == False
 |    T.__contravariant__ = False
 |    A.__constraints__ == (str, bytes)
 |  
 |  Note that only type variables defined in global scope can be pickled.
 |  
 |  Method resolution order:
 |      TypeVar
 |      _Final
 |      _Immutable
 |      _TypeVarLike
 |      builtins.object
 |  
 |  Methods defined here:
 |  
 |  __init__(self, name, *constraints, bound=None, covariant=False, contravariant=False)
 |      Initialize self.  See help(type(self)) for accurate signature.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __bound__
 |  
 |  __constraints__
 |  
 |  __contravariant__
 |  
 |  __covariant__
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  ----------------------------------------------------------------------
 |  Class methods inherited from _Final:
 |  
 |  __init_subclass__(*args, **kwds) from builtins.type
 |      This method is called when a class is subclassed.
 |      
 |      The default implementation does nothing. It may be
 |      overridden to extend subclasses.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from _Final:
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)
 |  
 |  ----------------------------------------------------------------------
 |  Methods inherited from _Immutable:
 |  
 |  __copy__(self)
 |  
 |  __deepcopy__(self, memo)
 |  
 |  ----------------------------------------------------------------------
 |  Methods inherited from _TypeVarLike:
 |  
 |  __or__(self, right)
 |      Return self|value.
 |  
 |  __reduce__(self)
 |      Helper for pickle.
 |  
 |  __repr__(self)
 |      Return repr(self).
 |  
 |  __ror__(self, left)
 |      Return value|self.
```

## Generic

[go up](#fptk-core-cheatsheet)

```hy
Name: Generic
Kind: Reimport from [typing]
```

```hy
Help on class Generic in module typing:

class Generic(builtins.object)
 |  Abstract base class for generic types.
 |  
 |  A generic type is typically declared by inheriting from
 |  this class parameterized with one or more type variables.
 |  For example, a generic mapping type might be defined as::
 |  
 |    class Mapping(Generic[KT, VT]):
 |        def __getitem__(self, key: KT) -> VT:
 |            ...
 |        # Etc.
 |  
 |  This class can then be used as follows::
 |  
 |    def lookup_name(mapping: Mapping[KT, VT], key: KT, default: VT) -> VT:
 |        try:
 |            return mapping[key]
 |        except KeyError:
 |            return default
 |  
 |  Class methods defined here:
 |  
 |  __class_getitem__(params) from builtins.type
 |  
 |  __init_subclass__(*args, **kwargs) from builtins.type
 |      This method is called when a class is subclassed.
 |      
 |      The default implementation does nothing. It may be
 |      overridden to extend subclasses.
```

## NamedTuple

[go up](#fptk-core-cheatsheet)

```hy
Name: NamedTuple
Kind: Reimport from [typing]
```

```hy
Help on function NamedTuple in module typing:

NamedTuple(typename, fields=None, /, **kwargs)
    Typed version of namedtuple.
    
    Usage in Python versions >= 3.6::
    
        class Employee(NamedTuple):
            name: str
            id: int
    
    This is equivalent to::
    
        Employee = collections.namedtuple('Employee', ['name', 'id'])
    
    The resulting class has an extra __annotations__ attribute, giving a
    dict that maps field names to types.  (The field names are also in
    the _fields attribute, which is part of the namedtuple API.)
    Alternative equivalent keyword syntax is also accepted::
    
        Employee = NamedTuple('Employee', name=str, id=int)
    
    In Python versions <= 3.5 use::
    
        Employee = NamedTuple('Employee', [('name', str), ('id', int)])
```

## dataclass

[go up](#fptk-core-cheatsheet)

```hy
Name: dataclass
Kind: Reimport from [dataclasses]
```

```hy
Help on function dataclass in module dataclasses:

dataclass(cls=None, /, *, init=True, repr=True, eq=True, order=False, unsafe_hash=False, frozen=False, match_args=True, kw_only=False, slots=False)
    Returns the same class as was passed in, with dunder methods
    added based on the fields defined in the class.
    
    Examines PEP 526 __annotations__ to determine fields.
    
    If init is true, an __init__() method is added to the class. If
    repr is true, a __repr__() method is added. If order is true, rich
    comparison dunder methods are added. If unsafe_hash is true, a
    __hash__() method function is added. If frozen is true, fields may
    not be assigned to after instance creation. If match_args is true,
    the __match_args__ tuple is added. If kw_only is true, then by
    default all fields are keyword-only. If slots is true, an
    __slots__ attribute is added.
```

## upd_field

[go up](#fptk-core-cheatsheet)

```hy
Name: upd_field (= dataclasses.replace)
Kind: Reimport
Info: non-mutating
```

```hy
Help on function replace in module dataclasses:

replace(obj, /, **changes)
    Return a new object replacing specified fields with new values.
    
    This is especially useful for frozen classes.  Example usage:
    
      @dataclass(frozen=True)
      class C:
          x: int
          y: int
    
      c = C(1, 2)
      c1 = replace(c, x=3)
      assert c1.x == 3 and c1.y == 2
```

## of

[go up](#fptk-core-cheatsheet)

```hy
Name: of
Kind: Macro from [fptk/hyrule]
Info: example: (of List int) which is equiv to py-code: List[int]
```

## Annotator2

[go up](#fptk-core-cheatsheet)

```hy
Name: def::
Kind: Macro from [fptk]
Info: example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]
```

## Annotator1

[go up](#fptk-core-cheatsheet)

```hy
Name: f::
Kind: Macro from [fptk]
Info: define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))
```

## file_existsQ

[go up](#fptk-core-cheatsheet)

```hy
Name: file_existsQ (= os.path.exists)
Kind: Reimport
Sgnt: file_existsQ(filename)
Info: also works on folders
```

```hy
Help on function exists in module genericpath:

exists(path)
    Test whether a path exists.  Returns False for broken symbolic links
```

## fileQ

[go up](#fptk-core-cheatsheet)

```hy
Name: fileQ (= os.path.isfile)
Kind: Reimport
Sgnt: fileQ(filename)
```

```hy
Help on function isfile in module genericpath:

isfile(path)
    Test whether a path is a regular file
```

## dirQ

[go up](#fptk-core-cheatsheet)

```hy
Name: dirQ (= os.path.isdir)
Kind: Reimport
Sgnt: dirQ(filename)
```

```hy
Help on function isdir in module genericpath:

isdir(s)
    Return true if the pathname refers to an existing directory.
```

## read_file

[go up](#fptk-core-cheatsheet)

```hy
Name: read_file
Kind: FPTK original
Sgnt: read_file(file_name, encoding='utf-8') -> str
Info: returns whole file content
```

```hy
Help on function read_file in module fptk.core.funcs:

read_file(file_name: str, encoding: str = 'utf-8')
    returns whole file content
```

## write_to_file

[go up](#fptk-core-cheatsheet)

```hy
Name: write_to_file
Kind: FPTK original
Sgnt: write_file(text, file_name, mode='w', encoding='utf-8')
Info: modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation
```

```hy
Help on function write_to_file in module fptk.core.funcs:

write_to_file(text: str, file_name: str, mode: str = 'w', encoding: str = 'utf-8')
    writes text to file_name;
    modes:
    - 'w' - (over)write
    - 'a' - append
    - 'x' - exclusive creation
    - ...
    - see more at help(open)
```

## inf_range

[go up](#fptk-core-cheatsheet)

```hy
Name: inf_range (= itertools.count)
Kind: Reimport
Sgnt: inf_range(start [, step])
Info: inf_range(10) -> generator: 10, 11, 12, ...
```

```hy
Help on class count in module itertools:

class count(builtins.object)
 |  count(start=0, step=1)
 |  
 |  Return a count object whose .__next__() method returns consecutive values.
 |  
 |  Equivalent to:
 |      def count(firstval=0, step=1):
 |          x = firstval
 |          while 1:
 |              yield x
 |              x += step
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  __repr__(self, /)
 |      Return repr(self).
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## cycle

[go up](#fptk-core-cheatsheet)

```hy
Name: cycle
Kind: Reimport from [itertools]
Sgnt: cycle(p)
Info: cycle('AB') -> A B A B ...
```

```hy
Help on class cycle in module itertools:

class cycle(builtins.object)
 |  cycle(iterable, /)
 |  
 |  Return elements from the iterable until it is exhausted. Then repeat the sequence indefinitely.
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  __setstate__(...)
 |      Set state information for unpickling.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## lcycle

[go up](#fptk-core-cheatsheet)

```hy
Name: lcycle
Kind: FPTK original
Sgnt: lcycle(p, n) -> list
Info: takes first n elems from cycle(p)
```

```hy
Help on function lcycle in module fptk.core.funcs:

lcycle(p, n)
    takes first n elems from cycle(p)
```

## repeat

[go up](#fptk-core-cheatsheet)

```hy
Name: repeat
Kind: Reimport from [itertools]
Sgnt: repeat(elem [, n])
Info: repeat(10,3) -> 10 10 10
```

```hy
Help on class repeat in module itertools:

class repeat(builtins.object)
 |  repeat(object [,times]) -> create an iterator which returns the object
 |  for the specified number of times.  If not specified, returns the object
 |  endlessly.
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __length_hint__(...)
 |      Private method returning an estimate of len(list(it)).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  __repr__(self, /)
 |      Return repr(self).
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## lrepeat

[go up](#fptk-core-cheatsheet)

```hy
Name: lrepeat
Kind: FPTK original
Sgnt: lrepeat(elem, n) -> list
Info: unlike in repeat, n has to be provided
```

```hy
Help on function lrepeat in module fptk.core.funcs:

lrepeat(elem, n)
    literally just list(repeat(elem, n))
```

## pairwise

[go up](#fptk-core-cheatsheet)

```hy
Name: pairwise
Kind: Reimport from [funcy]
Sgnt: pairwise(seq) -> iterator
Info: supposed to be used in loops, will produce no elems for seq with len <= 1
```

```hy
Help on function pairwise in module funcy.seqs:

pairwise(seq)
    Yields all pairs of neighboring items in seq.
```

## with_prev

[go up](#fptk-core-cheatsheet)

```hy
Name: with_prev
Kind: Reimport from [funcy]
Sgnt: with_prev(seq, fill=None) -> iterator
Info: supposed to be used in loops
```

```hy
Help on function with_prev in module funcy.seqs:

with_prev(seq, fill=None)
    Yields each item paired with its preceding: (item, prev).
```

## with_next

[go up](#fptk-core-cheatsheet)

```hy
Name: with_next
Kind: Reimport from [funcy]
Sgnt: with_next(seq, fill=None) -> iterator
Info: supposed to be used in loops
```

```hy
Help on function with_next in module funcy.seqs:

with_next(seq, fill=None)
    Yields each item paired with its following: (item, next).
```

## islice

[go up](#fptk-core-cheatsheet)

```hy
Name: islice
Kind: Reimport from [itertools]
Sgnt: islice(iterable, start, stop[, step])
Info: list(islice(inf_range(10), 2)) == [10, 11]
```

```hy
Help on class islice in module itertools:

class islice(builtins.object)
 |  islice(iterable, stop) --> islice object
 |  islice(iterable, start, stop[, step]) --> islice object
 |  
 |  Return an iterator whose next() method returns selected values from an
 |  iterable.  If start is specified, will skip all preceding elements;
 |  otherwise, start defaults to zero.  Step defaults to one.  If
 |  specified as another value, step determines how many values are
 |  skipped between successive calls.  Works like a slice() on a list
 |  but returns an iterator.
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  __setstate__(...)
 |      Set state information for unpickling.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## lislice

[go up](#fptk-core-cheatsheet)

```hy
Name: lislice
Kind: FPTK original
Info: list version of islice: lislice
```

```hy
Help on function lislice in module fptk.core.funcs:

lislice(*kwargs)
    literally just list(lislice(...))
```

## cat

[go up](#fptk-core-cheatsheet)

```hy
Name: cat
Kind: Reimport from [funcy]
Sgnt: cat(seqs)
Info: non-variadic version of concat
```

```hy
Help on built-in function from_iterable:

from_iterable(iterable, /) method of builtins.type instance
    Alternative chain() constructor taking a single iterable argument that evaluates lazily.
```

## lcat

[go up](#fptk-core-cheatsheet)

```hy
Name: lcat
Kind: Reimport from [funcy]
Sgnt: lcat(seqs)
Info: non-variadic version of concat
```

```hy
Help on function lcat in module funcy.seqs:

lcat(seqs)
    Concatenates the sequence of sequences.
```

## concat

[go up](#fptk-core-cheatsheet)

```hy
Name: concat (= itertools.chain)
Kind: Reimport
Sgnt: concat(*seqs) -> iterator
Info: variadic vertion of cat
```

```hy
Help on class chain in module itertools:

class chain(builtins.object)
 |  chain(*iterables) --> chain object
 |  
 |  Return a chain object whose .__next__() method returns elements from the
 |  first iterable until it is exhausted, then elements from the next
 |  iterable, until all of the iterables are exhausted.
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  __setstate__(...)
 |      Set state information for unpickling.
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  __class_getitem__(...) from builtins.type
 |      See PEP 585
 |  
 |  from_iterable(iterable, /) from builtins.type
 |      Alternative chain() constructor taking a single iterable argument that evaluates lazily.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## lconcat

[go up](#fptk-core-cheatsheet)

```hy
Name: lconcat
Kind: FPTK original
Sgnt: lconcat(*seqs) -> list
Info: literally just list(concat(*seqs))
```

```hy
Help on function lconcat in module fptk.core.funcs:

lconcat(*seqs)
    literally just list(concat(*seqs))
```

## mapcat

[go up](#fptk-core-cheatsheet)

```hy
Name: mapcat
Kind: Reimport from [funcy]
Sgnt: mapcat(f, *seqs)
Info: maps, then concatenates
```

```hy
Help on function mapcat in module funcy.seqs:

mapcat(f, *seqs)
    Maps given sequence(s) and chains the results.
```

## lmapcat

[go up](#fptk-core-cheatsheet)

```hy
Name: lmapcat
Kind: Reimport from [funcy]
Sgnt: lmapcat(f, *seqs)
Info: maps, then concatenates
```

```hy
Help on function lmapcat in module funcy.seqs:

lmapcat(f, *seqs)
    Maps given sequence(s) and concatenates the results.
```

## lreversed

[go up](#fptk-core-cheatsheet)

```hy
Name: lreversed
Kind: FPTK original
Sgnt: lreversed(sequence)
Info: list version of reversed
```

```hy
Help on function lreversed in module fptk.core.funcs:

lreversed(sequence)
```

## lfilter

[go up](#fptk-core-cheatsheet)

```hy
Name: lfilter
Kind: Reimport from [funcy]
Sgnt: lfilter(pred, seq) -> List
Info: funcy list version of extended filter
```

```hy
Help on function lfilter in module funcy.seqs:

lfilter(pred, seq)
    An extended version of builtin filter() returning a list.
    Derives a predicate from string, int, slice, dict or set.
```

## fltr1st

[go up](#fptk-core-cheatsheet)

```hy
Name: fltr1st
Kind: FPTK original
Sgnt: fltr1st(f, seq) -> Optional elem
Info: returns first found element (or None)
```

```hy
Help on function fltr1st in module fptk.core.funcs:

fltr1st(function, iterable)
    returns first found element (via function criteria), returns None if not found
```

## reject

[go up](#fptk-core-cheatsheet)

```hy
Name: reject (= funcy.remove)
Kind: Reimport
Sgnt: reject(pred, seq)-> iterator
Info: same as filter, but checks for False
```

```hy
Help on function remove in module funcy.seqs:

remove(pred, seq)
    Iterates items passing given predicate.
```

## lreject

[go up](#fptk-core-cheatsheet)

```hy
Name: lreject (= funcy.lremove)
Kind: Reimport
Sgnt: lreject(pred, seq) -> List
Info: list version of reject
```

```hy
Help on function lremove in module funcy.seqs:

lremove(pred, seq)
    Creates a list if items passing given predicate.
```

## without

[go up](#fptk-core-cheatsheet)

```hy
Name: without
Kind: FPTK original
Sgnt: without(items, seq) -> generator
Info: subtracts items from seq (as a sets)
```

```hy
Help on function without in module fptk.core.funcs:

without(items, seq)
    returns generator for seq with each item in items removed (does not mutate seq)
```

## lwithout

[go up](#fptk-core-cheatsheet)

```hy
Name: lwithout
Kind: FPTK original
Sgnt: lwithout(items, seq) -> list
Info: list version of reject
```

```hy
Help on function lwithout in module fptk.core.funcs:

lwithout(items, seq)
    returns seq with each item in items removed (does not mutate seq)
```

## takewhile

[go up](#fptk-core-cheatsheet)

```hy
Name: takewhile
Kind: Reimport from [funcy]
Sgnt: takewhile([pred, ] seq)
Info: yields elems of seq as long as they pass pred
```

```hy
Help on function takewhile in module funcy.seqs:

takewhile(pred, seq=EMPTY)
    Yields sequence items until first predicate fail.
    Stops on first falsy value in one argument version.
```

## dropwhile

[go up](#fptk-core-cheatsheet)

```hy
Name: dropwhile
Kind: Reimport from [funcy]
Sgnt: dropwhile([pred, ] seq)
Info: mirror of takewhile
```

```hy
Help on function dropwhile in module funcy.seqs:

dropwhile(pred, seq=EMPTY)
    Skips the start of the sequence passing pred (or just truthy),
    then iterates over the rest.
```

## filter_split

[go up](#fptk-core-cheatsheet)

```hy
Name: filter_split (= funcy.split)
Kind: Reimport
Sgnt: filter_split(pred, seq) -> passed, rejected
```

```hy
Help on function split in module funcy.seqs:

split(pred, seq)
    Lazily splits items which pass the predicate from the ones that don't.
    Returns a pair (passed, failed) of respective iterators.
```

## lfilter_split

[go up](#fptk-core-cheatsheet)

```hy
Name: lfilter_split (= funcy.lsplit)
Kind: Reimport
Sgnt: lfilter_split(pred,seq) -> passed, rejected
Info: list version of filter_split
```

```hy
Help on function lsplit in module funcy.seqs:

lsplit(pred, seq)
    Splits items which pass the predicate from the ones that don't.
    Returns a pair (passed, failed) of respective lists.
```

## flatten

[go up](#fptk-core-cheatsheet)

```hy
Name: flatten
Kind: Reimport from [fptk/hyrule]
Sgnt: flatten(coll)
Info: recursively flattens to the bottom
```

```hy
Help on function flatten in module fptk.core.from_hyrule:

flatten(coll)
    recursively flattens
```

## bisect_at

[go up](#fptk-core-cheatsheet)

```hy
Name: bisect_at (= funcy.split_at)
Kind: Reimport
Sgnt: bisect_at(n, seq) -> start, tail
Info: len of start will = n, works only with n>=0
```

```hy
Help on function split_at in module funcy.seqs:

split_at(n, seq)
    Lazily splits the sequence at given position,
    returning a pair of iterators over its start and tail.
```

## lbisect_at

[go up](#fptk-core-cheatsheet)

```hy
Name: lbisect_at
Kind: FPTK original
Sgnt: lbisect_at(n, seq) -> start, tail
Info: list version of bisect_at, but also for n<0, abs(n) will be len of tail
```

```hy
Help on function lbisect_at in module fptk.core.funcs:

lbisect_at(n, seq)
    splits seq to start and tail lists (returns tuple of lists),
    when n>=0, len of start will be = n (or less, when len(seq) < n),
    when n<0, len of tail will be = n (or less, when len(seq) < abs(n))
```

## bisect_by

[go up](#fptk-core-cheatsheet)

```hy
Name: bisect_by (= funcy.split_by)
Kind: Reimport
Sgnt: bisect_by(pred, seq) -> taken, dropped
Info: similar to (takewhile, dropwhile)
```

```hy
Help on function split_by in module funcy.seqs:

split_by(pred, seq)
    Lazily splits the start of the sequence,
    consisting of items passing pred, from the rest of it.
```

## lbisect_by

[go up](#fptk-core-cheatsheet)

```hy
Name: lbisect_by (= funcy.lsplit_by)
Kind: Reimport
Sgnt: lbisect_by(pred, seq) -> taken, dropped
Info: list version of lbisect
```

```hy
Help on function lsplit_by in module funcy.seqs:

lsplit_by(pred, seq)
    Splits the start of the sequence,
    consisting of items passing pred, from the rest of it.
```

## partition

[go up](#fptk-core-cheatsheet)

```hy
Name: partition
Kind: FPTK original
Sgnt: partition(n, seq, *, step=None, tail=False) -> generator
Info: splits seq to lists of len n, tail=True will allow including fewer than n items
```

```hy
Help on function partition in module fptk.core.funcs:

partition(n, seq, *, step=None, tail=False)
    splits seq to lists of len n,
    at step offsets apart (step=None defaults to n when not given),
    tail=False will allow fewer than n items at the end;
    returns generator
```

## lpartition

[go up](#fptk-core-cheatsheet)

```hy
Name: lpartition
Kind: FPTK original
Sgnt: lpartition(n, seq, *, step=None, tail=False) -> List
Info: simply list(partition(...))
```

```hy
Help on function lpartition in module fptk.core.funcs:

lpartition(n, seq, *, step=None, tail=False)
    splits seq to lists of len n,
    at step offsets apart (step=None defaults to n when not given),
    tail=False will allow fewer than n items at the end;
    returns list of lists
```

## partition_by

[go up](#fptk-core-cheatsheet)

```hy
Name: partition_by
Kind: Reimport from [funcy]
Sgnt: partition_by(f, seq) -> iterator of iterators
Info: splits when f(item) change
```

```hy
Help on function partition_by in module funcy.seqs:

partition_by(f, seq)
    Lazily partition seq into continuous chunks with constant value of f.
```

## lpartition_by

[go up](#fptk-core-cheatsheet)

```hy
Name: lpartition_by
Kind: Reimport from [funcy]
Sgnt: lpartition_by(f,seq) -> list of lists
Info: list(partition_by(...))
```

```hy
Help on function lpartition_by in module funcy.seqs:

lpartition_by(f, seq)
    Partition seq into continuous chunks with constant value of f.
```

## group_by

[go up](#fptk-core-cheatsheet)

```hy
Name: group_by
Kind: Reimport from [funcy]
Sgnt: group_by(f, seq) -> defaultdict(list)
Info: groups elems of seq keyed by the result of f
```

```hy
Help on function group_by in module funcy.seqs:

group_by(f, seq)
    Groups given sequence items into a mapping f(item) -> [item, ...].
```

## lmulticut_by

[go up](#fptk-core-cheatsheet)

```hy
Name: lmulticut_by
Kind: FPTK original
Sgnt: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list
Info: cut at pred(elem)==True elems
```

```hy
Help on function lmulticut_by in module fptk.core.funcs:

lmulticut_by(pred, seq: list, keep_border=True, merge_border=False) -> List[list]
    cuts at elems which give pred(elem)=True
    #
    keep_border =True  will keep elements with pred(elem)=True
    merge_border=True  will cut only at first of a sequence of pred(elem)=True elems
    #
    in the example below evenQ is function that gives True for even numbers,
    that is cuts will happen at elems=0
    #
                                           #  keep_b merge_b
                                           #  ------ -------
    lmulticut_by(evenQ, [0, 1, 0, 0, 1, 1, 0], True , True ) # -> [[0, 1], [0, 0, 1, 1], [0]]
    lmulticut_by(evenQ, [0, 1, 0, 0, 1, 1, 0], True , False) # -> [[0, 1], [0], [0, 1, 1], [0]]
    lmulticut_by(evenQ, [0, 1, 0, 0, 1, 1, 0], False, True ) # -> [[1], [1, 1]]
    lmulticut_by(evenQ, [0, 1, 0, 0, 1, 1, 0], False, False) # -> [[1], [], [1, 1], []]
```

## filterm

[go up](#fptk-core-cheatsheet)

```hy
Name: filterm
Kind: Macro from [fptk]
Sgnt: (filterm f xs)
Info: same as filter, but expects fm-syntax for func
```

## lfilterm

[go up](#fptk-core-cheatsheet)

```hy
Name: lfilterm
Kind: Macro from [fptk]
Sgnt: (lfilterm f xs)
Info: list version of lfilterm
```

## lzip

[go up](#fptk-core-cheatsheet)

```hy
Name: lzip
Kind: FPTK original
Sgnt: lzip(*iterables) -> List
Info: literally just list(zip(*iterables))
```

```hy
Help on function lzip in module fptk.core.funcs:

lzip(*iterables)
```

## lmap

[go up](#fptk-core-cheatsheet)

```hy
Name: lmap
Kind: Reimport from [funcy]
Sgnt: lmap(f, *seqs) -> List
Info: list version of map
```

```hy
Help on function lmap in module funcy.seqs:

lmap(f, *seqs)
    An extended version of builtin map() returning a list.
    Derives a mapper from string, int, slice, dict or set.
```

## starmap

[go up](#fptk-core-cheatsheet)

```hy
Name: starmap
Kind: Reimport from [itertools]
Sgnt: starmap(function, iterable)
```

```hy
Help on class starmap in module itertools:

class starmap(builtins.object)
 |  starmap(function, iterable, /)
 |  
 |  Return an iterator whose values are returned from the function evaluated with an argument tuple taken from the given sequence.
 |  
 |  Methods defined here:
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __next__(self, /)
 |      Implement next(self).
 |  
 |  __reduce__(...)
 |      Return state information for pickling.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
```

## lstarmap

[go up](#fptk-core-cheatsheet)

```hy
Name: lstarmap
Kind: FPTK original
Sgnt: lstarmap(function, iterable) -> list
Info: list version of starmap
```

```hy
Help on function lstarmap in module fptk.core.funcs:

lstarmap(function, iterable)
    literally just list(starmap(function, iterable))
```

## reduce

[go up](#fptk-core-cheatsheet)

```hy
Name: reduce
Kind: Reimport from [functools]
Sgnt: reduce(function, sequence[, initial]) -> value
Info: theory: reduce + monoid = binary-function for free becomes n-arg-function
```

```hy
Help on built-in function reduce in module _functools:

reduce(...)
    reduce(function, iterable[, initial]) -> value
    
    Apply a function of two arguments cumulatively to the items of a sequence
    or iterable, from left to right, so as to reduce the iterable to a single
    value.  For example, reduce(lambda x, y: x+y, [1, 2, 3, 4, 5]) calculates
    ((((1+2)+3)+4)+5).  If initial is present, it is placed before the items
    of the iterable in the calculation, and serves as a default when the
    iterable is empty.
```

## reductions

[go up](#fptk-core-cheatsheet)

```hy
Name: reductions
Kind: Reimport from [funcy]
Sgnt: reductions(f, seq [, acc]) -> generator
Info: returns sequence of intermetidate values of reduce(f, seq, acc)
```

```hy
Help on function reductions in module funcy.seqs:

reductions(f, seq, acc=EMPTY)
    Yields intermediate reductions of seq by f.
```

## lreductions

[go up](#fptk-core-cheatsheet)

```hy
Name: lreductions
Kind: Reimport from [funcy]
Sgnt: lreductions(f, seq [, acc]) -> list
Info: list version of reductions
```

```hy
Help on function lreductions in module funcy.seqs:

lreductions(f, seq, acc=EMPTY)
    Lists intermediate reductions of seq by f.
```

## identity

[go up](#fptk-core-cheatsheet)

```hy
Name: identity
Kind: Reimport from [funcy]
Info: identity(n) -> n
```

```hy
Help on function identity in module funcy.funcs:

identity(x)
    Returns its argument.
```

## constantly

[go up](#fptk-core-cheatsheet)

```hy
Name: constantly
Kind: FPTK original
Sgnt: constantly(val)
Info: constantly(30) is FUNCTION that always return val no matter the arguments
```

```hy
Help on function constantly in module fptk.core.funcs:

constantly(value)
```

## compose

[go up](#fptk-core-cheatsheet)

```hy
Name: compose
Kind: Reimport from [funcy]
Sgnt: compose(f1, f2, ..., fn)
Info: = f1(f2(..fn(***))) ; applicator
```

```hy
Help on function compose in module funcy.funcs:

compose(*fs)
    Composes passed functions.
```

## rcompose

[go up](#fptk-core-cheatsheet)

```hy
Name: rcompose
Kind: Reimport from [funcy]
Sgnt: rcompose(f1, f2, ..., fn)
Info: = fn(..(f2(f1(***)))) ; applicator
```

```hy
Help on function rcompose in module funcy.funcs:

rcompose(*fs)
    Composes functions, calling them from left to right.
```

## ljuxt

[go up](#fptk-core-cheatsheet)

```hy
Name: ljuxt
Kind: Reimport from [funcy]
Sgnt: ljuxt(*fs)
Info: = [f1, f2, ...](***) ; applicator
```

```hy
Help on function ljuxt in module funcy.funcs:

ljuxt(*fs)
    Constructs a juxtaposition of the given functions.
    Result returns a list of results of fs.
```

## nested

[go up](#fptk-core-cheatsheet)

```hy
Name: nested
Kind: FPTK original
Sgnt: nested(n, f)
Info: applicator f(...(f(***)))
```

```hy
Help on function nested in module fptk.core.funcs:

nested(n, f)
    constructs function f(f(f(...f))), where nesting is n times deep
```

## apply_n

[go up](#fptk-core-cheatsheet)

```hy
Name: apply_n
Kind: FPTK original
Sgnt: apply_n(n, f, *args, **kwargs)
Info: f(f(f(...f(*args, **kwargs))
```

```hy
Help on function apply_n in module fptk.core.funcs:

apply_n(n, f, *args, **kwargs)
    applies f to args and kwargs,
    than applies f to result of prev application,
    and this is repeated in total for n times,
    
    n=1 is simply f(args, kwargs)
```

## partial

[go up](#fptk-core-cheatsheet)

```hy
Name: partial
Kind: Reimport from [funcy]
Info: applicator
```

```hy
Help on class partial in module functools:

class partial(builtins.object)
 |  partial(func, *args, **keywords) - new function with partial application
 |  of the given arguments and keywords.
 |  
 |  Methods defined here:
 |  
 |  __call__(self, /, *args, **kwargs)
 |      Call self as a function.
 |  
 |  __delattr__(self, name, /)
 |      Implement delattr(self, name).
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __reduce__(...)
 |      Helper for pickle.
 |  
 |  __repr__(self, /)
 |      Return repr(self).
 |  
 |  __setattr__(self, name, value, /)
 |      Implement setattr(self, name, value).
 |  
 |  __setstate__(...)
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  __class_getitem__(...) from builtins.type
 |      See PEP 585
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |  
 |  __vectorcalloffset__
 |  
 |  args
 |      tuple of arguments to future partial calls
 |  
 |  func
 |      function object to use in future partial calls
 |  
 |  keywords
 |      dictionary of keyword arguments to future partial calls
```

## rpartial

[go up](#fptk-core-cheatsheet)

```hy
Name: rpartial
Kind: Reimport from [funcy]
Info: applicator
```

```hy
Help on function rpartial in module funcy.funcs:

rpartial(func, *args, **kwargs)
    Partially applies last arguments.
    New keyworded arguments extend and override kwargs.
```

## flip

[go up](#fptk-core-cheatsheet)

```hy
Name: flip
Kind: FPTK original
Sgnt: flip(f, a, b) = f(b, a)
Info: calls f with flipped args
```

```hy
Help on function flip in module fptk.core.funcs:

flip(f, a, b)
    flip(f, a, b) = f(b, a)
```

## pflip

[go up](#fptk-core-cheatsheet)

```hy
Name: pflip
Kind: FPTK original
Sgnt: pflip(f, a)
Info: applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25
```

```hy
Help on function pflip in module fptk.core.funcs:

pflip(f, a)
    creates partial applicator for f(a,b) with args a and b flipped;
    example usage: pflip(div, 4)(1) == div(1, 4) == 0.25
```

## fnot

[go up](#fptk-core-cheatsheet)

```hy
Name: fnot
Kind: FPTK original
Sgnt: fnot(f, *args, **kwargs)
Info: = not(f(*args, **kwargs))
```

```hy
Help on function fnot in module fptk.core.funcs:

fnot(f, *args, **kwargs)
    fnot(f, *args, **kwargs) = not(f(*args, **kwargs))
```

## eq_any

[go up](#fptk-core-cheatsheet)

```hy
Name: eq_any
Kind: FPTK original
Sgnt: eq_any(x, values)
Info: = (or (eq x value1) (eq x value2) ...)
```

```hy
Help on function eq_any in module fptk.core.funcs:

eq_any(x, values)
    eq_any(x, [v1, v2, ...]) = or(eq(x, v1), eq(x, v2), ...)
```

## on

[go up](#fptk-core-cheatsheet)

```hy
Name: on
Kind: FPTK original
Sgnt: on(f, check, x, y)
Info: example: (on len eq xs ys) -> (eq (len xs) (len yx))
```

```hy
Help on function on in module fptk.core.funcs:

on(f, check, x, y)
    on(f, check, x, y) = check(f(x), f(y))
    inspired by Haskell's 'on' function
```

## all_fs

[go up](#fptk-core-cheatsheet)

```hy
Name: all_fs
Kind: FPTK original
Sgnt: all_fs(fs, *args, **kwargs)
Info: checks if all f(*args, **kwargs) are True
```

```hy
Help on function all_fs in module fptk.core.funcs:

all_fs(fs, *args, **kwargs)
    all_fs([f1, f2, ...], *args, **kwargs) = and(f1(*args, **kwargs), f2, ...)
```

## any_fs

[go up](#fptk-core-cheatsheet)

```hy
Name: any_fs
Kind: FPTK original
Sgnt: any_fs(fs, *args, **kwargs)
Info: checks if any of f(*args, **kwargs) is True
```

```hy
Help on function any_fs in module fptk.core.funcs:

any_fs(fs, *args, **kwargs)
    all_fs([f1, f2, ...], *args, **kwargs) = or(f1(*args, **kwargs), f2, ...)
```

## case

[go up](#fptk-core-cheatsheet)

```hy
Name: case
Kind: Macro from [fptk/hyrule]
```

## unless

[go up](#fptk-core-cheatsheet)

```hy
Name: unless
Kind: Macro from [fptk/hyrule]
```

## lif

[go up](#fptk-core-cheatsheet)

```hy
Name: lif
Kind: Macro from [fptk/hyrule]
```

## branch

[go up](#fptk-core-cheatsheet)

```hy
Name: branch
Kind: Macro from [fptk/hyrule]
```

## hyruleThreading1

[go up](#fptk-core-cheatsheet)

```hy
Name: ->
Kind: Macro from [fptk/hyrule]
```

## hyruleThreading2

[go up](#fptk-core-cheatsheet)

```hy
Name: ->>
Kind: Macro from [fptk/hyrule]
```

## hyruleThreading3

[go up](#fptk-core-cheatsheet)

```hy
Name: as->
Kind: Macro from [fptk/hyrule]
```

## hyruleThreading4

[go up](#fptk-core-cheatsheet)

```hy
Name: doto
Kind: Macro from [fptk/hyrule]
Info: mutating
```

## do_n

[go up](#fptk-core-cheatsheet)

```hy
Name: do_n
Kind: Macro from [fptk/hyrule]
Sgnt: (do_n   n #* body) -> None
Info: expands to ~ (do body body body ...)
```

## list_n

[go up](#fptk-core-cheatsheet)

```hy
Name: list_n
Kind: Macro from [fptk/hyrule]
Sgnt: (list_n n #* body) -> List
```

## fm

[go up](#fptk-core-cheatsheet)

```hy
Name: fm
Kind: Macro from [fptk]
Sgnt: (fm (* it 3))
Info: anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'
```

## LambdaWithAppl

[go up](#fptk-core-cheatsheet)

```hy
Name: f>
Kind: Macro from [fptk]
Sgnt: (f> (* it 3) 4)
Info: anonymous function with fm syntax, immediately applicates args
```

## mapm

[go up](#fptk-core-cheatsheet)

```hy
Name: mapm
Kind: Macro from [fptk]
Info: same as map, but expects fm-syntax for func
```

## lmapm

[go up](#fptk-core-cheatsheet)

```hy
Name: lmapm
Kind: Macro from [fptk]
Info: same as lmap, but expects fm-syntax for func
```

## FPTKThreading1

[go up](#fptk-core-cheatsheet)

```hy
Name: =>
Kind: Macro from [fptk]
Info: unification of dot-macro and ->
```

## FPTKThreading2

[go up](#fptk-core-cheatsheet)

```hy
Name: =>>
Kind: Macro from [fptk]
Info: unification of dot-macro and ->>
```

## PipeOfPartials

[go up](#fptk-core-cheatsheet)

```hy
Name: p:
Kind: Macro from [fptk]
Info: aplicator, pipe of partials
```

## get_

[go up](#fptk-core-cheatsheet)

```hy
Name: get_
Kind: FPTK original
Sgnt: get_(seq, *ns) -> elem
Info: same as get, but with 1-based index (will throw error for n=0)
```

```hy
Help on function get_ in module fptk.core.funcs:

get_(seq, *ns)
    same as hy get macro, but with 1-based index,
    can also work with dict keys,
    will throw error for n=0,
    will throw error if elem not found (just like hy get macro)
```

## nth_

[go up](#fptk-core-cheatsheet)

```hy
Name: nth_
Kind: FPTK original
Sgnt: nth_(n, seq) -> Optional elem
Info: same as nth, but with 1-based index; will return None for n=0
```

```hy
Help on function nth_ in module fptk.core.funcs:

nth_(n, seq)
    same as nth, but with 1-based index,
    will throw error for n=0,
    will return None if elem not found (just like nth)
```

## slice_

[go up](#fptk-core-cheatsheet)

```hy
Name: slice_
Kind: FPTK original
Sgnt: slice_(start, end, step=None)
Info: similar to slice, but with 1-based index; will throw error for start=0 or end=0
```

```hy
Help on function slice_ in module fptk.core.funcs:

slice_(start, end, step=None)
    similar to py slice, but:
    - has 1-based index
    - will throw error when start=0 or end=0
```

## cut_

[go up](#fptk-core-cheatsheet)

```hy
Name: cut_
Kind: FPTK original
Sgnt: cut_(seq, start, end, step=None) -> List
Info: similar to cut, but with 1-based index; will throw error for start=0 or end=0
```

```hy
Help on function cut_ in module fptk.core.funcs:

cut_(seq, start, end, step=None)
    same as hy cut macro, but with 1-based index:
    - will throw error when start=0 or end=0
```

## range_

[go up](#fptk-core-cheatsheet)

```hy
Name: range_
Kind: FPTK original
Sgnt: range_(start, end=None, step=1) -> range
Info: same as range, but with 1-based index
```

```hy
Help on function range_ in module fptk.core.funcs:

range_(start, end=None, step=1)
```

## lrange_

[go up](#fptk-core-cheatsheet)

```hy
Name: lrange_
Kind: FPTK original
Sgnt: lrange_(start, end, step=1) -> List
Info: range including both ends when possible, also works on fractionals
```

```hy
Help on function lrange_ in module fptk.core.funcs:

lrange_(start, end, step=1)
    range including both ends when possible,
    also works on fractionals
```

## cur_time

[go up](#fptk-core-cheatsheet)

```hy
Name: cur_time (= time.time)
Kind: Reimport
Sgnt: cur_time()
Info: gets current time in seconds
```

```hy
Help on built-in function time in module time:

time(...)
    time() -> floating point number
    
    Return the current time in seconds since the Epoch.
    Fractions of a second may be present if the system clock provides them.
```

## dt_print

[go up](#fptk-core-cheatsheet)

```hy
Name: dt_print
Kind: FPTK original
Sgnt: dt_printer(* args, fresh_run=False)
Info: starts timer on fresh run, prints time passed since previous call
```

```hy
Help on function dt_print in module fptk.core.funcs:

dt_print(*args, fresh_run=False, last_T=[None])
    on first run, starts the timer (and print message that it started)
    on subsequent runs prints how many time (in seconds) have passed since previous call
    #
    call with fresh_run = True to reset timer
    #
    last_T should not be touched by user!
    it is used for storing time of previous run between runs
```

## timing

[go up](#fptk-core-cheatsheet)

```hy
Name: timing
Kind: Macro from [fptk]
Sgnt: (timing expr1 expr2 ...) -> #(float, Any)
Info: returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)
```

## assertm

[go up](#fptk-core-cheatsheet)

```hy
Name: assertm
Kind: Macro from [fptk]
Sgnt: (assertm op arg1 arg2)
Info: tests if (op arg1 arg2), for example (= 1 1)
```

## gives_error_typeQ

[go up](#fptk-core-cheatsheet)

```hy
Name: gives_error_typeQ
Kind: Macro from [fptk]
Info: example: (assertm gives_error_typeQ (get [1] 2) IndexError)
```

## pprint

[go up](#fptk-core-cheatsheet)

```hy
Name: pprint
Kind: Reimport from [pprint]
Info: standard python pprint function
```

```hy
Help on function pprint in module pprint:

pprint(object, stream=None, indent=1, width=80, depth=None, *, compact=False, sort_dicts=True, underscore_numbers=False)
    Pretty-print a Python object to a stream [default is sys.stdout].
```

## lprint

[go up](#fptk-core-cheatsheet)

```hy
Name: lprint
Kind: FPTK original
Sgnt: lprint(seq, sep=None)
Info: prints every elem of seq on new line
```

```hy
Help on function lprint in module fptk.core.funcs:

lprint(seq, sep=None)
    essentially list(map(print, seq)) ;
    with sep='---' (or some other) will print sep between seq elems
```

## comment

[go up](#fptk-core-cheatsheet)

```hy
Name: comment
Kind: Macro from [fptk/hyrule]
```