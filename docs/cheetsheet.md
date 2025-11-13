
| Group | Functions/Types | Macros |
|-------|-----------------|--------|
| FP: Control flow |  | <span title="">[`case`](#case)</span> <span title="">[`branch`](#branch)</span> <span title="">[`unless`](#unless)</span> <span title="">[`lif`](#lif)</span> |
| FP: Composition | <span title=":: constantly(val) :: constantly(30) is FUNCTION that always return val no matter the arguments">[`constantly`](#constantly)</span> <span title="identity(n) -> n">[`identity`](#identity)</span> <span title="applicator">[`partial`](#partial)</span> <span title="applicator">[`rpartial`](#rpartial)</span> <span title=":: compose(f1, f2, ..., fn) :: = f1(f2(..fn(***))) ; applicator">[`compose`](#compose)</span> <span title=":: rcompose(f1, f2, ..., fn) :: = fn(..(f2(f1(***)))) ; applicator">[`rcompose`](#rcompose)</span> <span title=":: ljuxt(*fs) :: = [f1, f2, ...](***) ; applicator">[`ljuxt`](#ljuxt)</span> <span title=":: pflip(f, a) :: applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25">[`pflip`](#pflip)</span> <span title=":: flip(f, a, b) = f(b, a) :: calls f with flipped args">[`flip`](#flip)</span> | <span title="">[`->`](#->)</span> <span title="">[`->>`](#->>)</span> <span title="">[`as->`](#as->)</span> <span title="mutating">[`doto`](#doto)</span> <span title="unification of dot-macro and ->">[`=>`](#=>)</span> <span title="unification of dot-macro and ->>">[`=>>`](#=>>)</span> <span title="aplicator, pipe of partials">[`p:`](#p:)</span> |
| FP: threading | <span title=":: lzip(*iterables) -> List :: literally just list(zip(*iterables))">[`lzip`](#lzip)</span> <span title=":: lmap(f, *seqs) -> List :: list version of map">[`lmap`](#lmap)</span> <span title=":: starmap(function, iterable) ::">[`starmap`](#starmap)</span> <span title=":: lstarmap(function, iterable) -> list :: list version of starmap">[`lstarmap`](#lstarmap)</span> <span title=":: reduce(function, sequence[, initial]) -> value :: theory: reduce + monoid = binary-function for free becomes n-arg-function">[`reduce`](#reduce)</span> <span title=":: reductions(f, seq [, acc]) -> generator :: returns sequence of intermetidate values of reduce(f, seq, acc)">[`reductions`](#reductions)</span> <span title=":: lreductions(f, seq [, acc]) -> list :: list version of reductions">[`lreductions`](#lreductions)</span> <span title=":: sums(seq [, acc]) -> generator :: reductions with addition function">[`sums`](#sums)</span> <span title=":: lsums(seq [, acc]) -> list :: list version of sums">[`lsums`](#lsums)</span> <span title=":: product(iterable, /, *, start=1) :: product([2, 3, 5]) = 30">[`product`](#product)</span> | <span title=":: (fm (* it 3)) :: anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'">[`fm`](#fm)</span> <span title="same as map, but expects fm-syntax for func">[`mapm`](#mapm)</span> <span title="same as lmap, but expects fm-syntax for func">[`lmapm`](#lmapm)</span> |
| FP: n-applicators | <span title=":: nested(n, f) :: applicator f(...(f(***)))">[`nested`](#nested)</span> <span title=":: apply_n(n, f, *args, **kwargs) :: f(f(f(...f(*args, **kwargs))">[`apply_n`](#apply_n)</span> | <span title=":: (do_n   n #* body) -> None :: expands to ~ (do body body body ...)">[`do_n`](#do_n)</span> <span title=":: (list_n n #* body) -> List ::">[`list_n`](#list_n)</span> |
| APL: filtering | <span title=":: lfilter(pred, seq) -> List :: funcy list version of extended filter">[`lfilter`](#lfilter)</span> <span title=":: fltr1st(f, seq) -> Optional elem :: returns first found element (or None)">[`fltr1st`](#fltr1st)</span> <span title=":: reject(pred, seq)-> iterator :: same as filter, but checks for False">[`reject`](#reject)</span> <span title=":: lreject(pred, seq) -> List :: list version of reject">[`lreject`](#lreject)</span> <span title=":: without(items, seq) -> generator :: subtracts items from seq (as a sets)">[`without`](#without)</span> <span title=":: lwithout(items, seq) -> list :: list version of reject">[`lwithout`](#lwithout)</span> <span title=":: takewhile([pred, ] seq) :: yields elems of seq as long as they pass pred">[`takewhile`](#takewhile)</span> <span title=":: dropwhile([pred, ] seq) :: mirror of dropwhile">[`dropwhile`](#dropwhile)</span> <span title=":: filter_split(pred, seq) -> passed, rejected ::">[`filter_split`](#filter_split)</span> <span title=":: lfilter_split(pred,seq) -> passed, rejected :: list version of filter_split">[`lfilter_split`](#lfilter_split)</span> <span title=":: bisect_at(n, seq) -> start, tail :: len of start will = n, works only with n>=0">[`bisect_at`](#bisect_at)</span> <span title=":: lbisect_at(n, seq) -> start, tail :: list version of bisect_at, but also for n<0, abs(n) will be len of tail">[`lbisect_at`](#lbisect_at)</span> <span title=":: bisect_by(pred, seq) -> taken, dropped :: similar to (takewhile, dropwhile)">[`bisect_by`](#bisect_by)</span> <span title=":: lbisect_by(pred, seq) -> taken, dropped :: list version of lbisect">[`lbisect_by`](#lbisect_by)</span> <span title=":: mask_sel('abc', [1,0,1]) -> iterator: 'a', 'c' ::">[`mask_sel`](#mask_sel)</span> <span title=":: lmask_sel(data, selectors) -> list ::">[`lmask_sel`](#lmask_sel)</span> <span title=":: mask2idxs(mask) -> list :: mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]">[`mask2idxs`](#mask2idxs)</span> <span title=":: idxs2mask(idxs) -> list :: idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]">[`idxs2mask`](#idxs2mask)</span> | <span title=":: (filterm f xs) :: same as filter, but expects fm-syntax for func">[`filterm`](#filterm)</span> <span title=":: (lfilterm f xs) :: list version of lfilterm">[`lfilterm`](#lfilterm)</span> |
| APL: iterators and looping | <span title=":: inf_range(start [, step]) :: inf_range(10) -> generator: 10, 11, 12, ...">[`inf_range`](#inf_range)</span> <span title=":: islice(iterable, start, stop[, step]) :: list(islice(inf_range(10), 2)) == [10, 11]">[`islice`](#islice)</span> <span title="list version of islice: lislice">[`lislice`](#lislice)</span> <span title=":: cycle(p) :: cycle('AB') -> A B A B ...">[`cycle`](#cycle)</span> <span title=":: lcycle(p, n) -> list :: takes first n elems from cycle(p)">[`lcycle`](#lcycle)</span> <span title=":: repeat(elem [, n]) :: repeat(10,3) -> 10 10 10">[`repeat`](#repeat)</span> <span title=":: lrepeat(elem, n) -> list :: unlike in repeat, n has to be provided">[`lrepeat`](#lrepeat)</span> <span title=":: concat(*seqs) -> iterator ::">[`concat`](#concat)</span> <span title=":: lconcat(*seqs) -> list :: list(concat(*seqs))">[`lconcat`](#lconcat)</span> <span title=":: cat(seqs) :: non-variadic version of concat">[`cat`](#cat)</span> <span title=":: lcat(seqs) :: non-variadic version of concat">[`lcat`](#lcat)</span> <span title=":: mapcat(f, *seqs) :: maps, then concatenates">[`mapcat`](#mapcat)</span> <span title=":: lmapcat(f, *seqs) :: maps, then concatenates">[`lmapcat`](#lmapcat)</span> <span title=":: pairwise(seq) -> iterator :: supposed to be used in loops, will produce no elems for seq with len <= 1">[`pairwise`](#pairwise)</span> <span title=":: with_prev(seq, fill=None) -> iterator :: supposed to be used in loops">[`with_prev`](#with_prev)</span> <span title=":: with_next(seq, fill=None) -> iterator :: supposed to be used in loops">[`with_next`](#with_next)</span> |  |
| APL: working with lists | <span title=":: flatten(coll) :: flattens to the bottom, non-mutating">[`flatten`](#flatten)</span> <span title=":: lprint(seq, sep=None) :: prints every elem of seq on new line">[`lprint`](#lprint)</span> <span title=":: lreversed(sequence) :: list version of reversed">[`lreversed`](#lreversed)</span> <span title=":: partition(n, seq, *, step=None, tail=False) -> generator :: splits seq to lists of len n, tail=True will allow including fewer than n items">[`partition`](#partition)</span> <span title=":: lpartition(n, seq, *, step=None, tail=False) -> List :: simply list(partition(...))">[`lpartition`](#lpartition)</span> <span title=":: partition_by(f, seq) -> iterator of iterators :: splits when f(item) change">[`partition_by`](#partition_by)</span> <span title=":: lpartition_by(f,seq) -> list of lists :: list(partition_by(...))">[`lpartition_by`](#lpartition_by)</span> <span title=":: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list :: cut at pred(elem)==True elems">[`lmulticut_by`](#lmulticut_by)</span> |  |
| APL: counting | <span title=":: count_occurrences(elem, seq) -> int :: rename of list.count method">[`count_occurrences`](#count_occurrences)</span> |  |
| Getters: idxs and keys | <span title=":: nth(n, seq) -> Optional elem :: 0-based index; works also with dicts">[`nth`](#nth)</span> <span title=":: assoc(xs, k1, v1, k2, v2, ...) -> None :: ≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)">[`assoc`](#assoc)</span> <span title=":: first(seq) -> Optional elem ::">[`first`](#first)</span> <span title=":: second(seq) -> Optional elem ::">[`second`](#second)</span> <span title=":: third(seq) -> Optional elem ::">[`third`](#third)</span> <span title=":: fourth(seq) -> Optional elem ::">[`fourth`](#fourth)</span> <span title=":: beforelast(seq) -> Optional elem ::">[`beforelast`](#beforelast)</span> <span title=":: last(seq) -> Optional elem ::">[`last`](#last)</span> <span title=":: rest(seq) -> List :: drops 1st elem of list">[`rest`](#rest)</span> <span title=":: butlast(seq) -> List :: drops last elem of list">[`butlast`](#butlast)</span> <span title=":: drop(n, seq) -> List :: drops n>=0 elems from start of the list; when n<0, drops from end of the list">[`drop`](#drop)</span> <span title=":: take(n, seq) -> List :: takes n elems from start; when n<0, takes from end of the list">[`take`](#take)</span> <span title=":: pick(ns, seq) -> List :: throws error if some of ns doesn't exist; ns can be list of ints or dict keys">[`pick`](#pick)</span> | <span title="">[`ncut`](#ncut)</span> |
| Getters: one based index | <span title=":: get_(seq, *ns) -> elem :: same as get, but with 1-based index (will throw error for n=0)">[`get_`](#get_)</span> <span title=":: nth_(n, seq) -> Optional elem :: same as nth, but with 1-based index; will return None for n=0">[`nth_`](#nth_)</span> <span title=":: slice_(start, end, step=None) :: similar to slice, but with 1-based index; will throw error for start=0 or end=0">[`slice_`](#slice_)</span> <span title=":: cut_(seq, start, end, step=None) -> List :: similar to cut, but with 1-based index; will throw error for start=0 or end=0">[`cut_`](#cut_)</span> |  |
| Getters: keys and attrs | <span title=":: pluck(key, mappings) -> generator :: gets same key (or idx) from every mapping, mappings can be lists of lists/dicts/etc.">[`pluck`](#pluck)</span> <span title=":: lpluck(key, mappings) -> list ::">[`lpluck`](#lpluck)</span> <span title=":: pluck_attr(attr, objects) -> generator :: attr should be given as str">[`pluck_attr`](#pluck_attr)</span> <span title=":: lpluck_attr(attr, objects) -> list :: list version of pluck_attr">[`lpluck_attr`](#lpluck_attr)</span> | <span title=":: (getattrm Object 'attr') (getattrm Object .attr) :: accepts fptk-style .attr syntax">[`getattrm`](#getattrm)</span> <span title=":: (pluckm n xs) (pluckm key ys) (pluckm .attr zs) :: accepts fptk-style .arg syntax">[`pluckm`](#pluckm)</span> <span title="list version of pluckm">[`lpluckm`](#lpluckm)</span> |
| Typing: Base | <span title="">[`dataclass`](#dataclass)</span> <span title="">[`Enum`](#Enum)</span> <span title="">[`List`](#List)</span> <span title="">[`Tuple`](#Tuple)</span> <span title="">[`TypedDict`](#TypedDict)</span> <span title="">[`Dict`](#Dict)</span> <span title="">[`Union`](#Union)</span> <span title="">[`Generator`](#Generator)</span> <span title="">[`Any`](#Any)</span> <span title="">[`Optional`](#Optional)</span> <span title="">[`Callable`](#Callable)</span> <span title="">[`Literal`](#Literal)</span> <span title="">[`Type`](#Type)</span> <span title="">[`TypeVar`](#TypeVar)</span> <span title="">[`Generic`](#Generic)</span> <span title="">[`noneQ`](#noneQ)</span> <span title="">[`notnoneQ`](#notnoneQ)</span> <span title=":: oftypeQ(tp, x) :: checks directly via (= (type x) tp)">[`oftypeQ`](#oftypeQ)</span> <span title=":: intQ(x) :: checks literally if type(x) == int, will also work with StrictInt from pydantic">[`intQ`](#intQ)</span> <span title=":: floatQ(x) :: checks literally if type(x) == float, will also work with StrictFloat from pydantic">[`floatQ`](#floatQ)</span> <span title=":: numberQ(x) :: checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic">[`numberQ`](#numberQ)</span> <span title=":: strQ(x) :: checks literally if type(x) == str, will also work with StrictStr from pydantic">[`strQ`](#strQ)</span> <span title=":: dictQ(x) :: checks literally if type(x) == dict">[`dictQ`](#dictQ)</span> <span title=":: listQ(value) :: checks if value is list">[`listQ`](#listQ)</span> <span title=":: tupleQ(value) :: checks if value is tuple">[`tupleQ`](#tupleQ)</span> <span title=":: setQ(value) :: checks if value is set">[`setQ`](#setQ)</span> <span title=":: iteratorQ(value) :: checks if value is iterator">[`iteratorQ`](#iteratorQ)</span> <span title=":: iterableQ(value) :: checks if value is iterable">[`iterableQ`](#iterableQ)</span> | <span title="example: (of List int) which is equiv to py-code: List[int]">[`of`](#of)</span> <span title="example: (f:: int -> int => (of Tuple int str)) -> Callable[[int, int], Tuple[int,str]]">[`f::`](#f::)</span> <span title="define function with signature; example: (def:: int -> int -> float fdivide [x y] (/ x y))">[`def::`](#def::)</span> |
| Typing: Strict | <span title="">[`BaseModel`](#BaseModel)</span> <span title="will be still of int type, but will perform strict typecheck when variable is created">[`StrictInt`](#StrictInt)</span> <span title="will be still of str type, but will perform strict typecheck when variable is created">[`StrictStr`](#StrictStr)</span> <span title="will be still of float type, but will perform strict typecheck when variable is created">[`StrictFloat`](#StrictFloat)</span> <span title="Union of StrictInt and StrictFloat">[`StrictNumber`](#StrictNumber)</span> <span title="decorator for type-checking func args">[`validate_call`](#validate_call)</span> <span title="same as validate_call but with option validate_return=True set (thus validating args and return type)">[`validateF`](#validateF)</span> |  |
| Math and logic: Basic math | <span title=":: inc(n) :: = n + 1">[`inc`](#inc)</span> <span title=":: dec(n) :: = n - 1">[`dec`](#dec)</span> <span title=":: sign(n) :: will give 0 for n=0">[`sign`](#sign)</span> <span title=":: neg(n) :: = -1 * n">[`neg`](#neg)</span> <span title="floor(1.9) = 1">[`floor`](#floor)</span> <span title="ceil(1.1) = 2">[`ceil`](#ceil)</span> <span title=":: half(x) :: = x/2">[`half`](#half)</span> <span title=":: double(x) :: = x*2">[`double`](#double)</span> <span title=":: squared(x) :: = pow(x,2)">[`squared`](#squared)</span> <span title=":: reciprocal(x) :: = 1/x ; throws error for x=0">[`reciprocal`](#reciprocal)</span> <span title=":: sqrt(n) :: = √n">[`sqrt`](#sqrt)</span> <span title=":: dist(p, q) -> float :: ≈ √((px-qx)² + (py-qy)² ...)">[`dist`](#dist)</span> <span title=":: hypot(*coordinates) :: = √(x² + y² + ...)">[`hypot`](#hypot)</span> <span title=":: normalize(xs) -> xs :: will throw error for zero-len vector">[`normalize`](#normalize)</span> <span title=":: exp(x) ::">[`exp`](#exp)</span> <span title=":: log(x, base=math.e) ::">[`log`](#log)</span> <span title=":: ln(x) :: = math.log(x, math.e) ; coexists with log for clarity">[`ln`](#ln)</span> <span title=":: log10(x) ::">[`log10`](#log10)</span> <span title=":: evenQ(x) ::">[`evenQ`](#evenQ)</span> <span title=":: oddQ(x) ::">[`oddQ`](#oddQ)</span> <span title=":: zeroQ(x) :: checks directly via (= x 0)">[`zeroQ`](#zeroQ)</span> <span title=":: negativeQ(x) :: checks directly via (< x 0)">[`negativeQ`](#negativeQ)</span> <span title=":: positiveQ(x) :: checks directly via (> x 0)">[`positiveQ`](#positiveQ)</span> |  |
| Math and logic: Ranges | <span title=":: range_(start, end=None, step=1) -> List :: same as range, but with 1-based index">[`range_`](#range_)</span> <span title=":: lrange_(start, end, step=1) -> List :: range including both ends when possible, also works on fractionals">[`lrange_`](#lrange_)</span> <span title=":: clip(x, lower, upper) :: clips x to fit in lower <= x <= upper limit">[`clip`](#clip)</span> |  |
| Math and logic: Trigonometry | <span title="literally just float pi=3.14...">[`pi`](#pi)</span> <span title=":: sin(x) :: x is in radians">[`sin`](#sin)</span> <span title=":: cos(x) :: x is in radians">[`cos`](#cos)</span> <span title=":: tan(x) :: x is in radians, will give smth like 1.6E+16 for x = pi">[`tan`](#tan)</span> <span title=":: degrees(x) :: x in radians is converted to degrees">[`degrees`](#degrees)</span> <span title=":: radians(x) :: x in degrees is converted to radians">[`radians`](#radians)</span> <span title=":: acos(x) :: x is in radians, result is between 0 and pi">[`acos`](#acos)</span> <span title=":: asin(x) :: x is in radians, result is between -pi/2 and pi/2">[`asin`](#asin)</span> <span title=":: asin(x) :: x is in radians, result is between -pi/2 and pi/2">[`atan`](#atan)</span> <span title=":: atan2(y, x) :: both signs are considered">[`atan2`](#atan2)</span> |  |
| Math and logic: Base operators to functions | <span title="'and' as function">[`and_`](#and_)</span> <span title="'or' as function">[`or_`](#or_)</span> <span title="'not' as function">[`not_`](#not_)</span> <span title="'is' as function">[`is_`](#is_)</span> <span title="">[`xor`](#xor)</span> <span title="equal">[`eq`](#eq)</span> <span title="non-equal">[`neq`](#neq)</span> <span title="greater than">[`gt`](#gt)</span> <span title="less than">[`lt`](#lt)</span> <span title="greater or equal">[`geq`](#geq)</span> <span title="less or equal">[`leq`](#leq)</span> <span title="'@' as function">[`matmul`](#matmul)</span> <span title=":: div(a, b) ::">[`div`](#div)</span> <span title=":: gt0(x) :: checks for x > 0">[`gt0`](#gt0)</span> <span title=":: geq0(x) :: x >= 0">[`geq0`](#geq0)</span> <span title=":: lt0(x) :: checks for x < 0">[`lt0`](#lt0)</span> <span title=":: leq0(x) :: x <= 0">[`leq0`](#leq0)</span> <span title=":: minus(x, y) = x - y ::">[`minus`](#minus)</span> <span title=":: dmul(*args) = arg1 + arg2 + ... :: 'dunder mul', '*' operator as a function">[`dmul`](#dmul)</span> <span title=":: dadd(*args) = arg1 + arg2 + ... :: 'dunder add', '+' operator as a function">[`dadd`](#dadd)</span> <span title=":: lmul(*args) = arg1 * arg2 * ... :: rename of * operator, underlines usage for list">[`lmul`](#lmul)</span> <span title=":: smul(*args) = arg1 * arg2 * ... :: rename of * operator, underlines usage for string">[`smul`](#smul)</span> <span title=":: mul(*args) :: multiplication as a monoid (will not give error when used with 0 or 1 args)">[`mul`](#mul)</span> <span title=":: plus(*args) :: addition as a monoid (will not give error when used with 0 or 1 args)">[`plus`](#plus)</span> <span title=":: sconcat(*args) :: string concantenation as a monoid (will not give error when used with 0 or 1 args)">[`sconcat`](#sconcat)</span> |  |
| Math and logic: Logic checks | <span title=":: fnot(f, *args, **kwargs) :: = not(f(*args, **kwargs))">[`fnot`](#fnot)</span> <span title=":: eq_any(x, values) :: = (or (eq x value1) (eq x value2) ...)">[`eq_any`](#eq_any)</span> <span title=":: on(f, check, x, y) :: example: (on len eq xs ys) -> (eq (len xs) (len yx))">[`on`](#on)</span> <span title=":: all_fs(fs, *args, **kwargs) :: checks if all f(*args, **kwargs) are True">[`all_fs`](#all_fs)</span> <span title=":: any_fs(fs, *args, **kwargs) :: checks if any of f(*args, **kwargs) is True">[`any_fs`](#any_fs)</span> <span title=":: trueQ(x) :: checks directly via (= x True)">[`trueQ`](#trueQ)</span> <span title=":: falseQ(x) :: checks directly via (= x False)">[`falseQ`](#falseQ)</span> <span title=":: oflenQ(n, xs) :: checks directly via (= (len xs) n)">[`oflenQ`](#oflenQ)</span> <span title=":: zerolenQ(xs) :: checks directly via (= (len xs) 0)">[`zerolenQ`](#zerolenQ)</span> |  |
| Math and logic: Random | <span title=":: choice(seq) -> Elem :: throws error for empty list">[`choice`](#choice)</span> <span title=":: randint(a, b) -> int :: returns random integer in range [a, b] including both end points">[`randint`](#randint)</span> <span title=":: randfloat(a, b) -> float :: range is [a, b) or [a, b] depending on rounding">[`randfloat`](#randfloat)</span> <span title=":: rand01() -> float :: generates random number in interval [0, 1)">[`rand01`](#rand01)</span> |  |
| Strings: Basics | <span title=":: strlen(text) :: rename of len, underlines usage on strings">[`strlen`](#strlen)</span> <span title=":: str_join(ss, sep='') :: rearrangement of funcy.str_join, ss is seq of strings">[`str_join`](#str_join)</span> <span title=":: lowercase(string) :: str.lower method as a function">[`lowercase`](#lowercase)</span> <span title=":: strip(string, chars=None) :: str.strip method as a function">[`strip`](#strip)</span> <span title=":: lstrip(string, chars=None) :: str.lstrip method as a function">[`lstrip`](#lstrip)</span> <span title=":: rstrip(string, chars=None) :: str.rstrip method as a function">[`rstrip`](#rstrip)</span> <span title=":: enlengthen(string, target_len, char=' ', on_tail=True) :: adds char to string until target_len reached">[`enlengthen`](#enlengthen)</span> |  |
| Strings: Regex | <span title=":: re_sub(rpattern, replacement, string, count=0, flags=0) ::">[`re_sub`](#re_sub)</span> <span title=":: re_split(rpattern, string) ::">[`re_split`](#re_split)</span> <span title=":: re_find(rpattern, string, flags=0) -> str :: returns first found">[`re_find`](#re_find)</span> <span title=":: re_test(rpattern, string, ...) -> bool :: tests if string has match (not neccessarily whole string)">[`re_test`](#re_test)</span> <span title=":: re_all(rpattern, string, ...) -> List ::">[`re_all`](#re_all)</span> |  |
| IO | <span title=":: file_existsQ(filename) :: also works on folders">[`file_existsQ`](#file_existsQ)</span> <span title=":: fileQ(filename) ::">[`fileQ`](#fileQ)</span> <span title=":: dirQ(filename) ::">[`dirQ`](#dirQ)</span> <span title=":: read_file(file_name, encoding='utf-8') -> str :: returns whole file content">[`read_file`](#read_file)</span> <span title=":: write_file(text, file_name, mode='w', encoding='utf-8') :: modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation">[`write_to_file`](#write_to_file)</span> |  |
| Lens | <span title="main object of lenses library (for working with immutable structures)">[`lens`](#lens)</span> | <span title="macros for working with lens, see lens macros docs for details">[`lns`](#lns)</span> <span title="macros for working with lens, see lens macros docs for details">[`&+`](#&+)</span> <span title="macros for working with lens, see lens macros docs for details">[`&+>`](#&+>)</span> <span title="macros for working with lens, see lens macros docs for details">[`l>`](#l>)</span> <span title="macros for working with lens, see lens macros docs for details">[`l>=`](#l>=)</span> |
| Benchmarking | <span title=":: dt_printer(* args, fresh_run=False) :: starts timer on fresh run, prints time passed since previous call">[`dt_print`](#dt_print)</span> | <span title=":: (timing expr1 expr2 ...) -> #(float, Any) :: returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)">[`timing`](#timing)</span> |
| Testing |  | <span title=":: (assertm op arg1 arg2) :: tests if (op arg1 arg2), for example (= 1 1)">[`assertm`](#assertm)</span> <span title="example: (assertm gives_error_typeQ (get [1] 2) IndexError)">[`gives_error_typeQ`](#gives_error_typeQ)</span> |


# if

```hy
INFO: hy | if /base/
:: (if check true false)
```

# cond

```hy
INFO: hy | cond /base/
:: (cond check1 do1 ... true doT)
```

# case

```hy
MACR: hyrule | case
```

# branch

```hy
MACR: hyrule | branch
```

# unless

```hy
MACR: hyrule | unless
```

# lif

```hy
MACR: hyrule | lif
```

# constantly

```hy
FROM: hyrule | constantly
:: constantly(val)
constantly(30) is FUNCTION that always return val no matter the arguments
```

# identity

```hy
FROM: funcy | identity
identity(n) -> n
```

# ->

```hy
MACR: hyrule | ->
```

# ->>

```hy
MACR: hyrule | ->>
```

# as->

```hy
MACR: hyrule | as->
```

# doto

```hy
MACR: hyrule | doto
mutating
```

# partial

```hy
FROM: funcy | partial
applicator
```

# rpartial

```hy
FROM: funcy | rpartial
applicator
```

# =>

```hy
MACR: fptk._macros | =>
unification of dot-macro and ->
```

# =>>

```hy
MACR: fptk._macros | =>>
unification of dot-macro and ->>
```

# p:

```hy
MACR: fptk._macros | p:
aplicator, pipe of partials
```

# compose

```hy
FROM: funcy | compose
:: compose(f1, f2, ..., fn)
= f1(f2(..fn(***))) ; applicator
```

# rcompose

```hy
FROM: funcy | rcompose
:: rcompose(f1, f2, ..., fn)
= fn(..(f2(f1(***)))) ; applicator
```

# ljuxt

```hy
FROM: funcy | ljuxt
:: ljuxt(*fs)
= [f1, f2, ...](***) ; applicator
```

# pflip

```hy
DEFN: fptk | pflip
:: pflip(f, a)
applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25
```

# flip

```hy
DEFN: fptk | flip
:: flip(f, a, b) = f(b, a)
calls f with flipped args
```

# fm

```hy
MACR: fptk._macros | fm
:: (fm (* it 3))
anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'
```

# zip

```hy
INFO: py | zip /base/
:: zip(*iterables) -> zip object
```

# lzip

```hy
DEFN: fptk | lzip
:: lzip(*iterables) -> List
literally just list(zip(*iterables))
```

# map

```hy
INFO: py | map /base/
:: map(func, *iterables) -> map object
```

# lmap

```hy
FROM: funcy | lmap
:: lmap(f, *seqs) -> List
list version of map
```

# mapm

```hy
MACR: fptk._macros | mapm
same as map, but expects fm-syntax for func
```

# lmapm

```hy
MACR: fptk._macros | lmapm
same as lmap, but expects fm-syntax for func
```

# starmap

```hy
FROM: itertools | starmap
:: starmap(function, iterable)
```

# lstarmap

```hy
DEFN: fptk | lstarmap
:: lstarmap(function, iterable) -> list
list version of starmap
```

# reduce

```hy
FROM: functools | reduce
:: reduce(function, sequence[, initial]) -> value
theory: reduce + monoid = binary-function for free becomes n-arg-function
```

# reductions

```hy
FROM: funcy | reductions
:: reductions(f, seq [, acc]) -> generator
returns sequence of intermetidate values of reduce(f, seq, acc)
```

# lreductions

```hy
FROM: funcy | lreductions
:: lreductions(f, seq [, acc]) -> list
list version of reductions
```

# sums

```hy
FROM: funcy | sums
:: sums(seq [, acc]) -> generator
reductions with addition function
```

# lsums

```hy
FROM: funcy | lsums
:: lsums(seq [, acc]) -> list
list version of sums
```

# product

```hy
FROM: math | product (<-prod)
:: product(iterable, /, *, start=1)
product([2, 3, 5]) = 30
```

# do_n

```hy
MACR: hyrule | do_n
:: (do_n   n #* body) -> None
expands to ~ (do body body body ...)
```

# list_n

```hy
MACR: hyrule | list_n
:: (list_n n #* body) -> List
```

# nested

```hy
DEFN: fptk | nested
:: nested(n, f)
applicator f(...(f(***)))
```

# apply_n

```hy
DEFN: fptk | apply_n
:: apply_n(n, f, *args, **kwargs)
f(f(f(...f(*args, **kwargs))
```

# filter

```hy
INFO: py | filter /base/
:: filter(function or None, iterable) -> filter object
when f=None, checks if elems are True
```

# lfilter

```hy
FROM: funcy | lfilter
:: lfilter(pred, seq) -> List
funcy list version of extended filter
```

# filterm

```hy
MACR: fptk._macros | filterm
:: (filterm f xs)
same as filter, but expects fm-syntax for func
```

# lfilterm

```hy
MACR: fptk._macros | lfilterm
:: (lfilterm f xs)
list version of lfilterm
```

# fltr1st

```hy
DEFN: fptk | fltr1st
:: fltr1st(f, seq) -> Optional elem
returns first found element (or None)
```

# reject

```hy
FROM: funcy | reject (<-remove)
:: reject(pred, seq)-> iterator
same as filter, but checks for False
```

# lreject

```hy
FROM: funcy | lreject (<-lremove)
:: lreject(pred, seq) -> List
list version of reject
```

# without

```hy
DEFN: fptk | without
:: without(items, seq) -> generator
subtracts items from seq (as a sets)
```

# lwithout

```hy
DEFN: fptk | lwithout
:: lwithout(items, seq) -> list
list version of reject
```

# takewhile

```hy
FROM: funcy | takewhile
:: takewhile([pred, ] seq)
yields elems of seq as long as they pass pred
```

# dropwhile

```hy
FROM: funcy | dropwhile
:: dropwhile([pred, ] seq)
mirror of dropwhile
```

# filter_split

```hy
FROM: funcy | filter_split (<-split)
:: filter_split(pred, seq) -> passed, rejected
```

# lfilter_split

```hy
FROM: funcy | lfilter_split (<-lsplit)
:: lfilter_split(pred,seq) -> passed, rejected
list version of filter_split
```

# bisect_at

```hy
FROM: funcy | bisect_at (<-split_at)
:: bisect_at(n, seq) -> start, tail
len of start will = n, works only with n>=0
```

# lbisect_at

```hy
DEFN: fptk | lbisect_at
:: lbisect_at(n, seq) -> start, tail
list version of bisect_at, but also for n<0, abs(n) will be len of tail
```

# bisect_by

```hy
FROM: funcy | bisect_by (<-split_by)
:: bisect_by(pred, seq) -> taken, dropped
similar to (takewhile, dropwhile)
```

# lbisect_by

```hy
FROM: funcy | lbisect_by (<-lsplit_by)
:: lbisect_by(pred, seq) -> taken, dropped
list version of lbisect
```

# mask_sel

```hy
FROM: itertools | mask_sel (<-compress)
:: mask_sel('abc', [1,0,1]) -> iterator: 'a', 'c'
```

# lmask_sel

```hy
DEFN: fptk | lmask_sel
:: lmask_sel(data, selectors) -> list
```

# mask2idxs

```hy
DEFN: fptk | mask2idxs
:: mask2idxs(mask) -> list
mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]
```

# idxs2mask

```hy
DEFN: fptk | idxs2mask
:: idxs2mask(idxs) -> list
idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]
```

# inf_range

```hy
FROM: itertools | inf_range (<-count)
:: inf_range(start [, step])
inf_range(10) -> generator: 10, 11, 12, ...
```

# islice

```hy
FROM: itertools | islice
:: islice(iterable, start, stop[, step])
list(islice(inf_range(10), 2)) == [10, 11]
```

# lislice

```hy
DEFN: fptk | lislice
list version of islice: lislice
```

# cycle

```hy
FROM: itertools | cycle
:: cycle(p)
cycle('AB') -> A B A B ...
```

# lcycle

```hy
DEFN: fptk | lcycle
:: lcycle(p, n) -> list
takes first n elems from cycle(p)
```

# repeat

```hy
FROM: itertools | repeat
:: repeat(elem [, n])
repeat(10,3) -> 10 10 10
```

# lrepeat

```hy
DEFN: fptk | lrepeat
:: lrepeat(elem, n) -> list
unlike in repeat, n has to be provided
```

# concat

```hy
FROM: itertools | concat (<-chain)
:: concat(*seqs) -> iterator
```

# lconcat

```hy
DEFN: fptk | lconcat
:: lconcat(*seqs) -> list
list(concat(*seqs))
```

# cat

```hy
FROM: funcy | cat
:: cat(seqs)
non-variadic version of concat
```

# lcat

```hy
FROM: funcy | lcat
:: lcat(seqs)
non-variadic version of concat
```

# mapcat

```hy
FROM: funcy | mapcat
:: mapcat(f, *seqs)
maps, then concatenates
```

# lmapcat

```hy
FROM: funcy | lmapcat
:: lmapcat(f, *seqs)
maps, then concatenates
```

# pairwise

```hy
FROM: funcy | pairwise
:: pairwise(seq) -> iterator
supposed to be used in loops, will produce no elems for seq with len <= 1
```

# with_prev

```hy
FROM: funcy | with_prev
:: with_prev(seq, fill=None) -> iterator
supposed to be used in loops
```

# with_next

```hy
FROM: funcy | with_next
:: with_next(seq, fill=None) -> iterator
supposed to be used in loops
```

# flatten

```hy
FROM: hyrule | flatten
:: flatten(coll)
flattens to the bottom, non-mutating
```

# lprint

```hy
DEFN: fptk | lprint
:: lprint(seq, sep=None)
prints every elem of seq on new line
```

# reversed

```hy
INFO: py | reversed /base/
:: reversed(sequence) -> iterator
```

# lreversed

```hy
DEFN: fptk | lreversed
:: lreversed(sequence)
list version of reversed
```

# partition

```hy
DEFN: fptk | partition
:: partition(n, seq, *, step=None, tail=False) -> generator
splits seq to lists of len n, tail=True will allow including fewer than n items
```

# lpartition

```hy
DEFN: fptk | lpartition
:: lpartition(n, seq, *, step=None, tail=False) -> List
simply list(partition(...))
```

# partition_by

```hy
FROM: funcy | partition_by
:: partition_by(f, seq) -> iterator of iterators
splits when f(item) change
```

# lpartition_by

```hy
FROM: funcy | lpartition_by
:: lpartition_by(f,seq) -> list of lists
list(partition_by(...))
```

# lmulticut_by

```hy
DEFN: fptk | lmulticut_by
:: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list
cut at pred(elem)==True elems
```

# count_occurrences

```hy
DEFN: fptk | count_occurrences
:: count_occurrences(elem, seq) -> int
rename of list.count method
```

# .

```hy
INFO: hy | . /macro/
:: (. xs [n1] [n2] ...) -> xs[n1][n2]...
throws error when not found
```

# get

```hy
INFO: hy | get /macro/
:: (get xs n #* keys) -> xs[n][key1]...
throws error when not found
```

# nth

```hy
FROM: funcy | nth
:: nth(n, seq) -> Optional elem
0-based index; works also with dicts
```

# slice

```hy
INFO: py | slice /base/
:: (slice start end step)
returns empty list when not found
```

# cut

```hy
INFO: hy | cut /macro/
:: (cut xs start end step) -> (get xs (slice start end step)) -> List
returns empty list when none found
```

# assoc

```hy
FROM: hyrule | assoc
:: assoc(xs, k1, v1, k2, v2, ...) -> None
≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)
```

# ncut

```hy
MACR: hyrule | ncut
```

# first

```hy
FROM: funcy | first
:: first(seq) -> Optional elem
```

# second

```hy
FROM: funcy | second
:: second(seq) -> Optional elem
```

# third

```hy
DEFN: fptk | third
:: third(seq) -> Optional elem
```

# fourth

```hy
DEFN: fptk | fourth
:: fourth(seq) -> Optional elem
```

# beforelast

```hy
DEFN: fptk | beforelast
:: beforelast(seq) -> Optional elem
```

# last

```hy
FROM: funcy | last
:: last(seq) -> Optional elem
```

# rest

```hy
DEFN: fptk | rest
:: rest(seq) -> List
drops 1st elem of list
```

# butlast

```hy
DEFN: fptk | butlast
:: butlast(seq) -> List
drops last elem of list
```

# drop

```hy
DEFN: fptk | drop
:: drop(n, seq) -> List
drops n>=0 elems from start of the list; when n<0, drops from end of the list
```

# take

```hy
DEFN: fptk | take
:: take(n, seq) -> List
takes n elems from start; when n<0, takes from end of the list
```

# pick

```hy
DEFN: fptk | pick
:: pick(ns, seq) -> List
throws error if some of ns doesn't exist; ns can be list of ints or dict keys
```

# get_

```hy
DEFN: fptk | get_
:: get_(seq, *ns) -> elem
same as get, but with 1-based index (will throw error for n=0)
```

# nth_

```hy
DEFN: fptk | nth_
:: nth_(n, seq) -> Optional elem
same as nth, but with 1-based index; will return None for n=0
```

# slice_

```hy
DEFN: fptk | slice_
:: slice_(start, end, step=None)
similar to slice, but with 1-based index; will throw error for start=0 or end=0
```

# cut_

```hy
DEFN: fptk | cut_
:: cut_(seq, start, end, step=None) -> List
similar to cut, but with 1-based index; will throw error for start=0 or end=0
```

# getattr

```hy
INFO: py | getattr /base/
:: getattr(object, name[, default]) -> value
arg name should be given as str
```

# getattrm

```hy
MACR: fptk._macros | getattrm
:: (getattrm Object 'attr') (getattrm Object .attr)
accepts fptk-style .attr syntax
```

# pluck

```hy
FROM: funcy | pluck
:: pluck(key, mappings) -> generator
gets same key (or idx) from every mapping, mappings can be lists of lists/dicts/etc.
```

# lpluck

```hy
FROM: funcy | lpluck
:: lpluck(key, mappings) -> list
```

# pluck_attr

```hy
FROM: funcy | pluck_attr
:: pluck_attr(attr, objects) -> generator
attr should be given as str
```

# lpluck_attr

```hy
FROM: funcy | lpluck_attr
:: lpluck_attr(attr, objects) -> list
list version of pluck_attr
```

# pluckm

```hy
MACR: fptk._macros | pluckm
:: (pluckm n xs) (pluckm key ys) (pluckm .attr zs)
accepts fptk-style .arg syntax
```

# lpluckm

```hy
MACR: fptk._macros | lpluckm
list version of pluckm
```

# of

```hy
MACR: hyrule | of
example: (of List int) which is equiv to py-code: List[int]
```

# f::

```hy
MACR: fptk._macros | f::
example: (f:: int -> int => (of Tuple int str)) -> Callable[[int, int], Tuple[int,str]]
```

# def::

```hy
MACR: fptk._macros | def::
define function with signature; example: (def:: int -> int -> float fdivide [x y] (/ x y))
```

# dataclass

```hy
FROM: dataclasses | dataclass
```

# Enum

```hy
FROM: enum | Enum
```

# List

```hy
FROM: typing | List
```

# Tuple

```hy
FROM: typing | Tuple
```

# TypedDict

```hy
FROM: typing | TypedDict
```

# Dict

```hy
FROM: typing | Dict
```

# Union

```hy
FROM: typing | Union
```

# Generator

```hy
FROM: typing | Generator
```

# Any

```hy
FROM: typing | Any
```

# Optional

```hy
FROM: typing | Optional
```

# Callable

```hy
FROM: typing | Callable
```

# Literal

```hy
FROM: typing | Literal
```

# Type

```hy
FROM: typing | Type
```

# TypeVar

```hy
FROM: typing | TypeVar
```

# Generic

```hy
FROM: typing | Generic
```

# noneQ

```hy
FROM: funcy | noneQ (<-isnone)
```

# notnoneQ

```hy
FROM: funcy | notnoneQ (<-notnone)
```

# oftypeQ

```hy
DEFN: fptk | oftypeQ
:: oftypeQ(tp, x)
checks directly via (= (type x) tp)
```

# intQ

```hy
DEFN: fptk | intQ
:: intQ(x)
checks literally if type(x) == int, will also work with StrictInt from pydantic
```

# floatQ

```hy
DEFN: fptk | floatQ
:: floatQ(x)
checks literally if type(x) == float, will also work with StrictFloat from pydantic
```

# numberQ

```hy
DEFN: fptk | numberQ
:: numberQ(x)
checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic
```

# strQ

```hy
DEFN: fptk | strQ
:: strQ(x)
checks literally if type(x) == str, will also work with StrictStr from pydantic
```

# dictQ

```hy
DEFN: fptk | dictQ
:: dictQ(x)
checks literally if type(x) == dict
```

# listQ

```hy
FROM: funcy | listQ (<-is_list)
:: listQ(value)
checks if value is list
```

# tupleQ

```hy
FROM: funcy | tupleQ (<-is_tuple)
:: tupleQ(value)
checks if value is tuple
```

# setQ

```hy
FROM: funcy | setQ (<-is_set)
:: setQ(value)
checks if value is set
```

# iteratorQ

```hy
FROM: funcy | iteratorQ (<-is_iter)
:: iteratorQ(value)
checks if value is iterator
```

# iterableQ

```hy
FROM: funcy | iterableQ (<-iterable)
:: iterableQ(value)
checks if value is iterable
```

# BaseModel

```hy
FROM: pydantic | BaseModel
```

# StrictInt

```hy
FROM: pydantic | StrictInt
will be still of int type, but will perform strict typecheck when variable is created
```

# StrictStr

```hy
FROM: pydantic | StrictStr
will be still of str type, but will perform strict typecheck when variable is created
```

# StrictFloat

```hy
FROM: pydantic | StrictFloat
will be still of float type, but will perform strict typecheck when variable is created
```

# StrictNumber

```hy
SETV: fptk | StrictNumber
Union of StrictInt and StrictFloat
```

# validate_call

```hy
FROM: pydantic | validate_call
decorator for type-checking func args
```

# validateF

```hy
SETV: fptk | validateF
same as validate_call but with option validate_return=True set (thus validating args and return type)
```

# inc

```hy
FROM: hyrule | inc
:: inc(n)
= n + 1
```

# dec

```hy
FROM: hyrule | dec
:: dec(n)
= n - 1
```

# sign

```hy
FROM: hyrule | sign
:: sign(n)
will give 0 for n=0
```

# neg

```hy
FROM: operator | neg
:: neg(n)
= -1 * n
```

# floor

```hy
FROM: math | floor
floor(1.9) = 1
```

# ceil

```hy
FROM: math | ceil
ceil(1.1) = 2
```

# half

```hy
DEFN: fptk | half
:: half(x)
= x/2
```

# double

```hy
DEFN: fptk | double
:: double(x)
= x*2
```

# squared

```hy
DEFN: fptk | squared
:: squared(x)
= pow(x,2)
```

# reciprocal

```hy
DEFN: fptk | reciprocal
:: reciprocal(x)
= 1/x ; throws error for x=0
```

# sqrt

```hy
FROM: math | sqrt
:: sqrt(n)
= √n
```

# dist

```hy
FROM: math | dist
:: dist(p, q) -> float
≈ √((px-qx)² + (py-qy)² ...)
```

# hypot

```hy
FROM: math | hypot
:: hypot(*coordinates)
= √(x² + y² + ...)
```

# normalize

```hy
DEFN: fptk | normalize
:: normalize(xs) -> xs
will throw error for zero-len vector
```

# exp

```hy
FROM: math | exp
:: exp(x)
```

# log

```hy
FROM: math | log
:: log(x, base=math.e)
```

# ln

```hy
DEFN: fptk | ln
:: ln(x)
= math.log(x, math.e) ; coexists with log for clarity
```

# log10

```hy
FROM: math | log10
:: log10(x)
```

# evenQ

```hy
FROM: funcy | evenQ (<-even)
:: evenQ(x)
```

# oddQ

```hy
FROM: funcy | oddQ (<-odd)
:: oddQ(x)
```

# zeroQ

```hy
DEFN: fptk | zeroQ
:: zeroQ(x)
checks directly via (= x 0)
```

# negativeQ

```hy
DEFN: fptk | negativeQ
:: negativeQ(x)
checks directly via (< x 0)
```

# positiveQ

```hy
DEFN: fptk | positiveQ
:: positiveQ(x)
checks directly via (> x 0)
```

# range_

```hy
FROM: hyrule | range_ (<-thru)
:: range_(start, end=None, step=1) -> List
same as range, but with 1-based index
```

# lrange_

```hy
DEFN: fptk | lrange_
:: lrange_(start, end, step=1) -> List
range including both ends when possible, also works on fractionals
```

# clip

```hy
DEFN: fptk | clip
:: clip(x, lower, upper)
clips x to fit in lower <= x <= upper limit
```

# pi

```hy
FROM: math | pi
literally just float pi=3.14...
```

# sin

```hy
FROM: math | sin
:: sin(x)
x is in radians
```

# cos

```hy
FROM: math | cos
:: cos(x)
x is in radians
```

# tan

```hy
FROM: math | tan
:: tan(x)
x is in radians, will give smth like 1.6E+16 for x = pi
```

# degrees

```hy
FROM: math | degrees
:: degrees(x)
x in radians is converted to degrees
```

# radians

```hy
FROM: math | radians
:: radians(x)
x in degrees is converted to radians
```

# acos

```hy
FROM: math | acos
:: acos(x)
x is in radians, result is between 0 and pi
```

# asin

```hy
FROM: math | asin
:: asin(x)
x is in radians, result is between -pi/2 and pi/2
```

# atan

```hy
FROM: math | atan
:: asin(x)
x is in radians, result is between -pi/2 and pi/2
```

# atan2

```hy
FROM: math | atan2
:: atan2(y, x)
both signs are considered
```

# and_

```hy
FROM: operator | and_
'and' as function
```

# or_

```hy
FROM: operator | or_
'or' as function
```

# not_

```hy
FROM: operator | not_
'not' as function
```

# is_

```hy
FROM: operator | is_
'is' as function
```

# xor

```hy
FROM: operator | xor
```

# eq

```hy
FROM: operator | eq
equal
```

# neq

```hy
FROM: operator | neq (<-ne)
non-equal
```

# gt

```hy
FROM: operator | gt
greater than
```

# lt

```hy
FROM: operator | lt
less than
```

# geq

```hy
FROM: operator | geq (<-ge)
greater or equal
```

# leq

```hy
FROM: operator | leq (<-le)
less or equal
```

# matmul

```hy
FROM: operator | matmul
'@' as function
```

# div

```hy
FROM: operator | div (<-truediv)
:: div(a, b)
```

# gt0

```hy
DEFN: fptk | gt0
:: gt0(x)
checks for x > 0
```

# geq0

```hy
DEFN: fptk | geq0
:: geq0(x)
x >= 0
```

# lt0

```hy
DEFN: fptk | lt0
:: lt0(x)
checks for x < 0
```

# leq0

```hy
DEFN: fptk | leq0
:: leq0(x)
x <= 0
```

# minus

```hy
DEFN: fptk | minus
:: minus(x, y) = x - y
```

# dmul

```hy
DEFN: fptk | dmul
:: dmul(*args) = arg1 + arg2 + ...
'dunder mul', '*' operator as a function
```

# dadd

```hy
DEFN: fptk | dadd
:: dadd(*args) = arg1 + arg2 + ...
'dunder add', '+' operator as a function
```

# lmul

```hy
DEFN: fptk | lmul
:: lmul(*args) = arg1 * arg2 * ...
rename of * operator, underlines usage for list
```

# smul

```hy
DEFN: fptk | smul
:: smul(*args) = arg1 * arg2 * ...
rename of * operator, underlines usage for string
```

# mul

```hy
DEFN: fptk | mul
:: mul(*args)
multiplication as a monoid (will not give error when used with 0 or 1 args)
```

# plus

```hy
DEFN: fptk | plus
:: plus(*args)
addition as a monoid (will not give error when used with 0 or 1 args)
```

# sconcat

```hy
DEFN: fptk | sconcat
:: sconcat(*args)
string concantenation as a monoid (will not give error when used with 0 or 1 args)
```

# fnot

```hy
DEFN: fptk | fnot
:: fnot(f, *args, **kwargs)
= not(f(*args, **kwargs))
```

# eq_any

```hy
DEFN: fptk | eq_any
:: eq_any(x, values)
= (or (eq x value1) (eq x value2) ...)
```

# on

```hy
DEFN: fptk | on
:: on(f, check, x, y)
example: (on len eq xs ys) -> (eq (len xs) (len yx))
```

# all_fs

```hy
DEFN: fptk | all_fs
:: all_fs(fs, *args, **kwargs)
checks if all f(*args, **kwargs) are True
```

# any_fs

```hy
DEFN: fptk | any_fs
:: any_fs(fs, *args, **kwargs)
checks if any of f(*args, **kwargs) is True
```

# trueQ

```hy
DEFN: fptk | trueQ
:: trueQ(x)
checks directly via (= x True)
```

# falseQ

```hy
DEFN: fptk | falseQ
:: falseQ(x)
checks directly via (= x False)
```

# oflenQ

```hy
DEFN: fptk | oflenQ
:: oflenQ(n, xs)
checks directly via (= (len xs) n)
```

# zerolenQ

```hy
DEFN: fptk | zerolenQ
:: zerolenQ(xs)
checks directly via (= (len xs) 0)
```

# choice

```hy
FROM: random | choice
:: choice(seq) -> Elem
throws error for empty list
```

# randint

```hy
FROM: random | randint
:: randint(a, b) -> int
returns random integer in range [a, b] including both end points
```

# randfloat

```hy
FROM: random | randfloat (<-uniform)
:: randfloat(a, b) -> float
range is [a, b) or [a, b] depending on rounding
```

# rand01

```hy
FROM: random | rand01 (<-random)
:: rand01() -> float
generates random number in interval [0, 1)
```

# strlen

```hy
DEFN: fptk | strlen
:: strlen(text)
rename of len, underlines usage on strings
```

# str_join

```hy
DEFN: fptk | str_join
:: str_join(ss, sep='')
rearrangement of funcy.str_join, ss is seq of strings
```

# lowercase

```hy
DEFN: fptk | lowercase
:: lowercase(string)
str.lower method as a function
```

# strip

```hy
DEFN: fptk | strip
:: strip(string, chars=None)
str.strip method as a function
```

# lstrip

```hy
DEFN: fptk | lstrip
:: lstrip(string, chars=None)
str.lstrip method as a function
```

# rstrip

```hy
DEFN: fptk | rstrip
:: rstrip(string, chars=None)
str.rstrip method as a function
```

# enlengthen

```hy
DEFN: fptk | enlengthen
:: enlengthen(string, target_len, char=' ', on_tail=True)
adds char to string until target_len reached
```

# re_sub

```hy
FROM: re | re_sub (<-sub)
:: re_sub(rpattern, replacement, string, count=0, flags=0)
```

# re_split

```hy
FROM: re | re_split (<-split)
:: re_split(rpattern, string)
```

# re_find

```hy
FROM: funcy | re_find
:: re_find(rpattern, string, flags=0) -> str
returns first found
```

# re_test

```hy
FROM: funcy | re_test
:: re_test(rpattern, string, ...) -> bool
tests if string has match (not neccessarily whole string)
```

# re_all

```hy
FROM: funcy | re_all
:: re_all(rpattern, string, ...) -> List
```

# file_existsQ

```hy
FROM: os.path | file_existsQ (<-exists)
:: file_existsQ(filename)
also works on folders
```

# fileQ

```hy
FROM: os.path | fileQ (<-isfile)
:: fileQ(filename)
```

# dirQ

```hy
FROM: os.path | dirQ (<-isdir)
:: dirQ(filename)
```

# read_file

```hy
DEFN: fptk | read_file
:: read_file(file_name, encoding='utf-8') -> str
returns whole file content
```

# write_to_file

```hy
DEFN: fptk | write_to_file
:: write_file(text, file_name, mode='w', encoding='utf-8')
modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation
```

# lens

```hy
FROM: lenses | lens
main object of lenses library (for working with immutable structures)
```

# lns

```hy
MACR: fptk._macros | lns
macros for working with lens, see lens macros docs for details
```

# &+

```hy
MACR: fptk._macros | &+
macros for working with lens, see lens macros docs for details
```

# &+>

```hy
MACR: fptk._macros | &+>
macros for working with lens, see lens macros docs for details
```

# l>

```hy
MACR: fptk._macros | l>
macros for working with lens, see lens macros docs for details
```

# l>=

```hy
MACR: fptk._macros | l>=
macros for working with lens, see lens macros docs for details
```

# timing

```hy
MACR: fptk._macros | timing
:: (timing expr1 expr2 ...) -> #(float, Any)
returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)
```

# dt_print

```hy
DEFN: fptk | dt_print
:: dt_printer(* args, fresh_run=False)
starts timer on fresh run, prints time passed since previous call
```

# assertm

```hy
MACR: fptk._macros | assertm
:: (assertm op arg1 arg2)
tests if (op arg1 arg2), for example (= 1 1)
```

# gives_error_typeQ

```hy
MACR: fptk._macros | gives_error_typeQ
example: (assertm gives_error_typeQ (get [1] 2) IndexError)
```