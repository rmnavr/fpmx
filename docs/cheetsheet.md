
---
fptk docs:
1. You are here -> [Cheetsheet](https://github.com/rmnavr/fptk/blob/main/docs/cheetsheet.md)
2. [Basic macros](https://github.com/rmnavr/fptk/blob/main/docs/macros.md)
3. [Lens related macros](https://github.com/rmnavr/fptk/blob/main/docs/lens.md)
4. [Result type](https://github.com/rmnavr/fptk/blob/main/docs/resultM.md)
---

# Cheetsheet


| Group | Functions/Types | Macros |
|-------|-----------------|--------|
| FP: Control flow |  | <span title="">[`case`](#case)</span> <span title="">[`branch`](#branch)</span> <span title="">[`unless`](#unless)</span> <span title="">[`lif`](#lif)</span> |
| FP: Composition | <span title=":: constantly(val) :: constantly(30) is FUNCTION that always return val no matter the arguments">[`constantly`](#constantly)</span> <span title="identity(n) -> n">[`identity`](#identity)</span> <span title="applicator">[`partial`](#partial)</span> <span title="applicator">[`rpartial`](#rpartial)</span> <span title=":: compose(f1, f2, ..., fn) :: = f1(f2(..fn(***))) ; applicator">[`compose`](#compose)</span> <span title=":: rcompose(f1, f2, ..., fn) :: = fn(..(f2(f1(***)))) ; applicator">[`rcompose`](#rcompose)</span> <span title=":: ljuxt(*fs) :: = [f1, f2, ...](***) ; applicator">[`ljuxt`](#ljuxt)</span> <span title=":: pflip(f, a) :: applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25">[`pflip`](#pflip)</span> <span title=":: flip(f, a, b) = f(b, a) :: calls f with flipped args">[`flip`](#flip)</span> | <span title="">[`->`](#hyruleThreading1)</span> <span title="">[`->>`](#hyruleThreading2)</span> <span title="">[`as->`](#hyruleThreading3)</span> <span title="mutating">[`doto`](#hyruleThreading4)</span> <span title="unification of dot-macro and ->">[`=>`](#FPTKThreading1)</span> <span title="unification of dot-macro and ->>">[`=>>`](#FPTKThreading2)</span> <span title="aplicator, pipe of partials">[`p:`](#PipeOfPartials)</span> |
| FP: threading | <span title=":: lzip(*iterables) -> List :: literally just list(zip(*iterables))">[`lzip`](#lzip)</span> <span title=":: lmap(f, *seqs) -> List :: list version of map">[`lmap`](#lmap)</span> <span title=":: starmap(function, iterable) ::">[`starmap`](#starmap)</span> <span title=":: lstarmap(function, iterable) -> list :: list version of starmap">[`lstarmap`](#lstarmap)</span> <span title=":: reduce(function, sequence[, initial]) -> value :: theory: reduce + monoid = binary-function for free becomes n-arg-function">[`reduce`](#reduce)</span> <span title=":: reductions(f, seq [, acc]) -> generator :: returns sequence of intermetidate values of reduce(f, seq, acc)">[`reductions`](#reductions)</span> <span title=":: lreductions(f, seq [, acc]) -> list :: list version of reductions">[`lreductions`](#lreductions)</span> <span title=":: sums(seq [, acc]) -> generator :: reductions with addition function">[`sums`](#sums)</span> <span title=":: lsums(seq [, acc]) -> list :: list version of sums">[`lsums`](#lsums)</span> <span title=":: product(iterable, /, *, start=1) :: product([2, 3, 5]) = 30">[`product`](#product)</span> | <span title=":: (fm (* it 3)) :: anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'">[`fm`](#fm)</span> <span title=":: (f> (* it 3) 4) :: anonymous function with fm syntax, immediately applicates args">[`f>`](#LambdaWithAppl)</span> <span title="same as map, but expects fm-syntax for func">[`mapm`](#mapm)</span> <span title="same as lmap, but expects fm-syntax for func">[`lmapm`](#lmapm)</span> |
| FP: n-applicators | <span title=":: nested(n, f) :: applicator f(...(f(***)))">[`nested`](#nested)</span> <span title=":: apply_n(n, f, *args, **kwargs) :: f(f(f(...f(*args, **kwargs))">[`apply_n`](#apply_n)</span> | <span title=":: (do_n   n #* body) -> None :: expands to ~ (do body body body ...)">[`do_n`](#do_n)</span> <span title=":: (list_n n #* body) -> List ::">[`list_n`](#list_n)</span> |
| APL: filtering | <span title=":: lfilter(pred, seq) -> List :: funcy list version of extended filter">[`lfilter`](#lfilter)</span> <span title=":: fltr1st(f, seq) -> Optional elem :: returns first found element (or None)">[`fltr1st`](#fltr1st)</span> <span title=":: reject(pred, seq)-> iterator :: same as filter, but checks for False">[`reject`](#reject)</span> <span title=":: lreject(pred, seq) -> List :: list version of reject">[`lreject`](#lreject)</span> <span title=":: without(items, seq) -> generator :: subtracts items from seq (as a sets)">[`without`](#without)</span> <span title=":: lwithout(items, seq) -> list :: list version of reject">[`lwithout`](#lwithout)</span> <span title=":: takewhile([pred, ] seq) :: yields elems of seq as long as they pass pred">[`takewhile`](#takewhile)</span> <span title=":: dropwhile([pred, ] seq) :: mirror of takewhile">[`dropwhile`](#dropwhile)</span> <span title=":: filter_split(pred, seq) -> passed, rejected ::">[`filter_split`](#filter_split)</span> <span title=":: lfilter_split(pred,seq) -> passed, rejected :: list version of filter_split">[`lfilter_split`](#lfilter_split)</span> <span title=":: bisect_at(n, seq) -> start, tail :: len of start will = n, works only with n>=0">[`bisect_at`](#bisect_at)</span> <span title=":: lbisect_at(n, seq) -> start, tail :: list version of bisect_at, but also for n<0, abs(n) will be len of tail">[`lbisect_at`](#lbisect_at)</span> <span title=":: bisect_by(pred, seq) -> taken, dropped :: similar to (takewhile, dropwhile)">[`bisect_by`](#bisect_by)</span> <span title=":: lbisect_by(pred, seq) -> taken, dropped :: list version of lbisect">[`lbisect_by`](#lbisect_by)</span> <span title=":: mask_sel('abc', [1,0,1]) -> iterator: 'a', 'c' ::">[`mask_sel`](#mask_sel)</span> <span title=":: lmask_sel(data, selectors) -> list ::">[`lmask_sel`](#lmask_sel)</span> <span title=":: mask2idxs(mask) -> list :: mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]">[`mask2idxs`](#mask2idxs)</span> <span title=":: idxs2mask(idxs) -> list :: idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]">[`idxs2mask`](#idxs2mask)</span> | <span title=":: (filterm f xs) :: same as filter, but expects fm-syntax for func">[`filterm`](#filterm)</span> <span title=":: (lfilterm f xs) :: list version of lfilterm">[`lfilterm`](#lfilterm)</span> |
| APL: working with lists | <span title=":: flatten(coll) :: flattens to the bottom, non-mutating">[`flatten`](#flatten)</span> <span title=":: lprint(seq, sep=None) :: prints every elem of seq on new line">[`lprint`](#lprint)</span> <span title=":: lreversed(sequence) :: list version of reversed">[`lreversed`](#lreversed)</span> <span title=":: partition(n, seq, *, step=None, tail=False) -> generator :: splits seq to lists of len n, tail=True will allow including fewer than n items">[`partition`](#partition)</span> <span title=":: lpartition(n, seq, *, step=None, tail=False) -> List :: simply list(partition(...))">[`lpartition`](#lpartition)</span> <span title=":: partition_by(f, seq) -> iterator of iterators :: splits when f(item) change">[`partition_by`](#partition_by)</span> <span title=":: lpartition_by(f,seq) -> list of lists :: list(partition_by(...))">[`lpartition_by`](#lpartition_by)</span> <span title=":: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list :: cut at pred(elem)==True elems">[`lmulticut_by`](#lmulticut_by)</span> |  |
| APL: counting | <span title=":: count_occurrences(elem, seq) -> int :: rename of list.count method">[`count_occurrences`](#count_occurrences)</span> |  |
| Getters: idxs and keys | <span title=":: nth(n, seq) -> Optional elem :: 0-based index; works also with dicts">[`nth`](#nth)</span> <span title=":: assoc(xs, k1, v1, k2, v2, ...) -> None :: ≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)">[`assoc`](#assoc)</span> <span title=":: first(seq) -> Optional elem ::">[`first`](#first)</span> <span title=":: second(seq) -> Optional elem ::">[`second`](#second)</span> <span title=":: third(seq) -> Optional elem ::">[`third`](#third)</span> <span title=":: fourth(seq) -> Optional elem ::">[`fourth`](#fourth)</span> <span title=":: beforelast(seq) -> Optional elem ::">[`beforelast`](#beforelast)</span> <span title=":: last(seq) -> Optional elem ::">[`last`](#last)</span> <span title=":: rest(seq) -> List :: drops 1st elem of list">[`rest`](#rest)</span> <span title=":: butlast(seq) -> List :: drops last elem of list">[`butlast`](#butlast)</span> <span title=":: drop(n, seq) -> List :: drops n>=0 elems from start of the list; when n<0, drops from end of the list">[`drop`](#drop)</span> <span title=":: take(n, seq) -> List :: takes n elems from start; when n<0, takes from end of the list">[`take`](#take)</span> <span title=":: pick(ns, seq) -> List :: throws error if some of ns doesn't exist; ns can be list of ints or dict keys">[`pick`](#pick)</span> | <span title="">[`ncut`](#ncut)</span> |
| Getters: one based index | <span title=":: get_(seq, *ns) -> elem :: same as get, but with 1-based index (will throw error for n=0)">[`get_`](#get_)</span> <span title=":: nth_(n, seq) -> Optional elem :: same as nth, but with 1-based index; will return None for n=0">[`nth_`](#nth_)</span> <span title=":: slice_(start, end, step=None) :: similar to slice, but with 1-based index; will throw error for start=0 or end=0">[`slice_`](#slice_)</span> <span title=":: cut_(seq, start, end, step=None) -> List :: similar to cut, but with 1-based index; will throw error for start=0 or end=0">[`cut_`](#cut_)</span> <span title=":: range_(start, end=None, step=1) -> List :: same as range, but with 1-based index">[`range_`](#range_)</span> <span title=":: lrange_(start, end, step=1) -> List :: range including both ends when possible, also works on fractionals">[`lrange_`](#lrange_)</span> |  |
| Getters: keys and attrs | <span title=":: pluck(key, mappings) -> generator :: gets same key (or idx) from every mapping, mappings can be lists of lists/dicts/etc.">[`pluck`](#pluck)</span> <span title=":: lpluck(key, mappings) -> list ::">[`lpluck`](#lpluck)</span> <span title=":: pluck_attr(attr, objects) -> generator :: attr should be given as str">[`pluck_attr`](#pluck_attr)</span> <span title=":: lpluck_attr(attr, objects) -> list :: list version of pluck_attr">[`lpluck_attr`](#lpluck_attr)</span> | <span title=":: (getattrm Object 'attr') (getattrm Object .attr) :: accepts fptk-style .attr syntax">[`getattrm`](#getattrm)</span> <span title=":: (pluckm n xs) (pluckm key ys) (pluckm .attr zs) :: accepts fptk-style .arg syntax">[`pluckm`](#pluckm)</span> <span title="list version of pluckm">[`lpluckm`](#lpluckm)</span> |
| Typing: Base | <span title="">[`dataclass`](#dataclass)</span> <span title="">[`Enum`](#Enum)</span> <span title="">[`List`](#List)</span> <span title="">[`Tuple`](#Tuple)</span> <span title="">[`TypedDict`](#TypedDict)</span> <span title="">[`Dict`](#Dict)</span> <span title="">[`Union`](#Union)</span> <span title="">[`Generator`](#Generator)</span> <span title="">[`Any`](#Any)</span> <span title="">[`Optional`](#Optional)</span> <span title="">[`Callable`](#Callable)</span> <span title="">[`Literal`](#Literal)</span> <span title="">[`Type`](#Type)</span> <span title="">[`TypeVar`](#TypeVar)</span> <span title="">[`Generic`](#Generic)</span> <span title="">[`noneQ`](#noneQ)</span> <span title="">[`notnoneQ`](#notnoneQ)</span> <span title=":: oftypeQ(tp, x) :: checks directly via (= (type x) tp)">[`oftypeQ`](#oftypeQ)</span> <span title=":: intQ(x) :: checks literally if type(x) == int, will also work with StrictInt from pydantic">[`intQ`](#intQ)</span> <span title=":: floatQ(x) :: checks literally if type(x) == float, will also work with StrictFloat from pydantic">[`floatQ`](#floatQ)</span> <span title=":: numberQ(x) :: checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic">[`numberQ`](#numberQ)</span> <span title=":: strQ(x) :: checks literally if type(x) == str, will also work with StrictStr from pydantic">[`strQ`](#strQ)</span> <span title=":: dictQ(x) :: checks literally if type(x) == dict">[`dictQ`](#dictQ)</span> <span title=":: listQ(value) :: checks if value is list">[`listQ`](#listQ)</span> <span title=":: tupleQ(value) :: checks if value is tuple">[`tupleQ`](#tupleQ)</span> <span title=":: setQ(value) :: checks if value is set">[`setQ`](#setQ)</span> <span title=":: iteratorQ(value) :: checks if value is iterator">[`iteratorQ`](#iteratorQ)</span> <span title=":: iterableQ(value) :: checks if value is iterable">[`iterableQ`](#iterableQ)</span> | <span title="example: (of List int) which is equiv to py-code: List[int]">[`of`](#of)</span> <span title="example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]">[`f::`](#Annotator1)</span> <span title="define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))">[`def::`](#Annotator2)</span> |
| Typing: Strict | <span title="">[`BaseModel`](#BaseModel)</span> <span title="will be still of int type, but will perform strict typecheck when variable is created">[`StrictInt`](#StrictInt)</span> <span title="will be still of str type, but will perform strict typecheck when variable is created">[`StrictStr`](#StrictStr)</span> <span title="will be still of float type, but will perform strict typecheck when variable is created">[`StrictFloat`](#StrictFloat)</span> <span title="Union of StrictInt and StrictFloat">[`StrictNumber`](#StrictNumber)</span> <span title="decorator for type-checking func args">[`validate_call`](#validate_call)</span> <span title="same as validate_call but with option validate_return=True set (thus validating args and return type)">[`validateF`](#validateF)</span> |  |
| Math and logic: Basic math | <span title=":: inc(n) :: = n + 1">[`inc`](#inc)</span> <span title=":: dec(n) :: = n - 1">[`dec`](#dec)</span> <span title=":: sign(n) :: will give 0 for n=0">[`sign`](#sign)</span> <span title=":: neg(n) :: = -1 * n">[`neg`](#neg)</span> <span title="floor(1.9) = 1">[`floor`](#floor)</span> <span title="ceil(1.1) = 2">[`ceil`](#ceil)</span> <span title=":: clip(x, lower, upper) :: clips x to fit in lower <= x <= upper limit">[`clip`](#clip)</span> <span title=":: half(x) :: = x/2">[`half`](#half)</span> <span title=":: double(x) :: = x*2">[`double`](#double)</span> <span title=":: squared(x) :: = pow(x,2)">[`squared`](#squared)</span> <span title=":: reciprocal(x) :: = 1/x ; throws error for x=0">[`reciprocal`](#reciprocal)</span> <span title=":: sqrt(n) :: = √n">[`sqrt`](#sqrt)</span> <span title=":: dist(p, q) -> float :: ≈ √((px-qx)² + (py-qy)² ...)">[`dist`](#dist)</span> <span title=":: hypot(*coordinates) :: = √(x² + y² + ...)">[`hypot`](#hypot)</span> <span title=":: normalize(xs) -> xs :: will throw error for zero-len vector">[`normalize`](#normalize)</span> <span title=":: exp(x) ::">[`exp`](#exp)</span> <span title=":: log(x, base=math.e) ::">[`log`](#log)</span> <span title=":: ln(x) :: = math.log(x, math.e) ; coexists with log for clarity">[`ln`](#ln)</span> <span title=":: log10(x) ::">[`log10`](#log10)</span> <span title=":: evenQ(x) ::">[`evenQ`](#evenQ)</span> <span title=":: oddQ(x) ::">[`oddQ`](#oddQ)</span> <span title=":: zeroQ(x) :: checks directly via (= x 0)">[`zeroQ`](#zeroQ)</span> <span title=":: negativeQ(x) :: checks directly via (< x 0)">[`negativeQ`](#negativeQ)</span> <span title=":: positiveQ(x) :: checks directly via (> x 0)">[`positiveQ`](#positiveQ)</span> |  |
| Math and logic: Trigonometry | <span title="literally just float pi=3.14...">[`pi`](#pi)</span> <span title=":: sin(x) :: x is in radians">[`sin`](#sin)</span> <span title=":: cos(x) :: x is in radians">[`cos`](#cos)</span> <span title=":: tan(x) :: x is in radians, will give smth like 1.6E+16 for x = pi">[`tan`](#tan)</span> <span title=":: degrees(x) :: x in radians is converted to degrees">[`degrees`](#degrees)</span> <span title=":: radians(x) :: x in degrees is converted to radians">[`radians`](#radians)</span> <span title=":: acos(x) :: x is in radians, result is between 0 and pi">[`acos`](#acos)</span> <span title=":: asin(x) :: x is in radians, result is between -pi/2 and pi/2">[`asin`](#asin)</span> <span title=":: asin(x) :: x is in radians, result is between -pi/2 and pi/2">[`atan`](#atan)</span> <span title=":: atan2(y, x) :: both signs are considered">[`atan2`](#atan2)</span> |  |
| Math and logic: Base operators to functions | <span title="'and' as function">[`and_`](#and_)</span> <span title="'or' as function">[`or_`](#or_)</span> <span title="'not' as function">[`not_`](#not_)</span> <span title="'is' as function">[`is_`](#is_)</span> <span title="">[`xor`](#xor)</span> <span title="equal">[`eq`](#eq)</span> <span title="non-equal">[`neq`](#neq)</span> <span title="greater than">[`gt`](#gt)</span> <span title="less than">[`lt`](#lt)</span> <span title="greater or equal">[`geq`](#geq)</span> <span title="less or equal">[`leq`](#leq)</span> <span title="'@' as function">[`matmul`](#matmul)</span> <span title=":: div(a, b) ::">[`div`](#div)</span> <span title=":: gt0(x) :: checks for x > 0">[`gt0`](#gt0)</span> <span title=":: geq0(x) :: x >= 0">[`geq0`](#geq0)</span> <span title=":: lt0(x) :: checks for x < 0">[`lt0`](#lt0)</span> <span title=":: leq0(x) :: x <= 0">[`leq0`](#leq0)</span> <span title=":: minus(x, y) = x - y ::">[`minus`](#minus)</span> |  |
| Math and logic: Dunders and Monoids | <span title=":: dmul(*args) = arg1 + arg2 + ... :: 'dunder mul', '*' operator as a function">[`dmul`](#dmul)</span> <span title=":: dadd(*args) = arg1 + arg2 + ... :: 'dunder add', '+' operator as a function">[`dadd`](#dadd)</span> <span title=":: lmul(*args) = arg1 * arg2 * ... :: rename of * operator, underlines usage for list">[`lmul`](#lmul)</span> <span title=":: smul(*args) = arg1 * arg2 * ... :: rename of * operator, underlines usage for string">[`smul`](#smul)</span> <span title=":: mul(*args) :: multiplication as a monoid (will not give error when used with 0 or 1 args)">[`mul`](#mul)</span> <span title=":: plus(*args) :: addition as a monoid (will not give error when used with 0 or 1 args)">[`plus`](#plus)</span> <span title=":: sconcat(*args) :: string concantenation as a monoid (will not give error when used with 0 or 1 args)">[`sconcat`](#sconcat)</span> |  |
| Math and logic: Logic checks | <span title=":: fnot(f, *args, **kwargs) :: = not(f(*args, **kwargs))">[`fnot`](#fnot)</span> <span title=":: eq_any(x, values) :: = (or (eq x value1) (eq x value2) ...)">[`eq_any`](#eq_any)</span> <span title=":: on(f, check, x, y) :: example: (on len eq xs ys) -> (eq (len xs) (len yx))">[`on`](#on)</span> <span title=":: all_fs(fs, *args, **kwargs) :: checks if all f(*args, **kwargs) are True">[`all_fs`](#all_fs)</span> <span title=":: any_fs(fs, *args, **kwargs) :: checks if any of f(*args, **kwargs) is True">[`any_fs`](#any_fs)</span> <span title=":: trueQ(x) :: checks directly via (= x True)">[`trueQ`](#trueQ)</span> <span title=":: falseQ(x) :: checks directly via (= x False)">[`falseQ`](#falseQ)</span> <span title=":: oflenQ(n, xs) :: checks directly via (= (len xs) n)">[`oflenQ`](#oflenQ)</span> <span title=":: zerolenQ(xs) :: checks directly via (= (len xs) 0)">[`zerolenQ`](#zerolenQ)</span> |  |
| Math and logic: Random | <span title=":: choice(seq) -> Elem :: throws error for empty list">[`choice`](#choice)</span> <span title=":: randint(a, b) -> int :: returns random integer in range [a, b] including both end points">[`randint`](#randint)</span> <span title=":: randfloat(a, b) -> float :: range is [a, b) or [a, b] depending on rounding">[`randfloat`](#randfloat)</span> <span title=":: rand01() -> float :: generates random number in interval [0, 1)">[`rand01`](#rand01)</span> |  |
| Strings: Basics | <span title=":: strlen(text) :: rename of len, underlines usage on strings">[`strlen`](#strlen)</span> <span title=":: str_join(ss, sep='') :: rearrangement of funcy.str_join, ss is seq of strings">[`str_join`](#str_join)</span> <span title=":: lowercase(string) :: str.lower method as a function">[`lowercase`](#lowercase)</span> <span title=":: strip(string, chars=None) :: str.strip method as a function">[`strip`](#strip)</span> <span title=":: lstrip(string, chars=None) :: str.lstrip method as a function">[`lstrip`](#lstrip)</span> <span title=":: rstrip(string, chars=None) :: str.rstrip method as a function">[`rstrip`](#rstrip)</span> <span title=":: enlengthen(string, target_len, char=' ', on_tail=True) :: adds char to string until target_len reached">[`enlengthen`](#enlengthen)</span> |  |
| Strings: Regex | <span title=":: re_sub(rpattern, replacement, string, count=0, flags=0) ::">[`re_sub`](#re_sub)</span> <span title=":: re_split(rpattern, string) ::">[`re_split`](#re_split)</span> <span title=":: re_find(rpattern, string, flags=0) -> str :: returns first found">[`re_find`](#re_find)</span> <span title=":: re_test(rpattern, string, ...) -> bool :: tests if string has match (not neccessarily whole string)">[`re_test`](#re_test)</span> <span title=":: re_all(rpattern, string, ...) -> List ::">[`re_all`](#re_all)</span> |  |
| IO | <span title=":: file_existsQ(filename) :: also works on folders">[`file_existsQ`](#file_existsQ)</span> <span title=":: fileQ(filename) ::">[`fileQ`](#fileQ)</span> <span title=":: dirQ(filename) ::">[`dirQ`](#dirQ)</span> <span title=":: read_file(file_name, encoding='utf-8') -> str :: returns whole file content">[`read_file`](#read_file)</span> <span title=":: write_file(text, file_name, mode='w', encoding='utf-8') :: modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation">[`write_to_file`](#write_to_file)</span> |  |
| Lens | <span title="main object of lenses library (for working with immutable structures)">[`lens`](#lens)</span> | <span title="macros for working with lens, see lens macros docs for details">[`lns`](#lns)</span> <span title="macros for working with lens, see lens macros docs for details">[`&+`](#Lens-operator1)</span> <span title="macros for working with lens, see lens macros docs for details">[`&+>`](#Lens-operator2)</span> <span title="macros for working with lens, see lens macros docs for details">[`l>`](#Lens-operator3)</span> <span title="macros for working with lens, see lens macros docs for details">[`l>=`](#Lens-operator4)</span> |
| Benchmarking | <span title=":: dt_printer(* args, fresh_run=False) :: starts timer on fresh run, prints time passed since previous call">[`dt_print`](#dt_print)</span> | <span title=":: (timing expr1 expr2 ...) -> #(float, Any) :: returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)">[`timing`](#timing)</span> |
| Testing |  | <span title=":: (assertm op arg1 arg2) :: tests if (op arg1 arg2), for example (= 1 1)">[`assertm`](#assertm)</span> <span title="example: (assertm gives_error_typeQ (get [1] 2) IndexError)">[`gives_error_typeQ`](#gives_error_typeQ)</span> |
| Monad: Maybe | <span title="Maybe monad. Should be used in annotations only">[`Maybe`](#Maybe)</span> <span title="Just container of Maybe monad">[`Just`](#Just)</span> <span title="Nothing of Maybe monad">[`Nothing`](#Nothing)</span> <span title=":: justQ(maybeValue) -> bool :: throws error when used not on Maybe type">[`justQ`](#justQ)</span> <span title=":: justQ(maybeValue) -> bool :: throws error when used not on Maybe type">[`nothingQ`](#nothingQ)</span> <span title=":: mapM(maybeVal, pureF1, pureF2, ...) -> Maybe :: apply pure function to value stored in Maybe, do nothing for Nothing">[`mapM`](#mapM)</span> <span title=":: bindM(maybeVal, mF1, mF2, ...) -> Maybe :: apply monadic (f :: val -> maybe) to Just, do nothing for Nothing">[`bindM`](#bindM)</span> <span title="returns contained Just value or throws error when not Just">[`unwrapM`](#unwrapM)</span> <span title="returns contained Just value or falls back to default">[`unwrapM_or`](#unwrapM_or)</span> |  |
| Monad: Result | <span title="Result monad. Should be used in annotations only">[`Result`](#Result)</span> <span title="Success container of Result monad">[`Success`](#Success)</span> <span title="Failure container of Result monad">[`Failure`](#Failure)</span> <span title=":: successQ(result) -> bool :: throws error when used not on Result type">[`successQ`](#successQ)</span> <span title=":: failureQ(result) -> bool :: throws error when used not on Result type">[`failureQ`](#failureQ)</span> <span title=":: mapR(result, pureF1, pureF2, ...) -> Result :: apply pure function to value stored in Success, do nothing for Failure">[`mapR`](#mapR)</span> <span title=":: bindR(result, mF1, mF2, ...) -> Result :: apply monadic (f :: val -> Result) to Success, do nothing for Failure">[`bindR`](#bindR)</span> <span title="returns contained Success value or throws error when not Success">[`unwrapR`](#unwrapR)</span> <span title="returns contained Success value or falls back to default">[`unwrapR_or`](#unwrapR_or)</span> <span title="returns contained Failure value or throws error when not Failure">[`unwrapE`](#unwrapE)</span> <span title="returns contained Failure value or falls back to default">[`unwrapE_or`](#unwrapE_or)</span> |  |

# Detailed descriptions

## case

[go up](#Cheetsheet)

```hy
Name: case
Kind: Macro from [hyrule]
```

## branch

[go up](#Cheetsheet)

```hy
Name: branch
Kind: Macro from [hyrule]
```

## unless

[go up](#Cheetsheet)

```hy
Name: unless
Kind: Macro from [hyrule]
```

## lif

[go up](#Cheetsheet)

```hy
Name: lif
Kind: Macro from [hyrule]
```

## constantly

[go up](#Cheetsheet)

```hy
Name: constantly
Kind: Reimport from [hyrule]
Sgnt: constantly(val)
Info: constantly(30) is FUNCTION that always return val no matter the arguments
```

```hy
Help on function constantly in module hyrule.misc:

constantly(value)
    Return a constant function, which ignores its arguments and always
    returns ``value``. ::
    
      (setv answer (constantly 42))
      (answer)           ; => 42
      (answer 1 :foo 2)  ; => 42
```

## identity

[go up](#Cheetsheet)

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

## hyruleThreading1

[go up](#Cheetsheet)

```hy
Name: ->
Kind: Macro from [hyrule]
```

## hyruleThreading2

[go up](#Cheetsheet)

```hy
Name: ->>
Kind: Macro from [hyrule]
```

## hyruleThreading3

[go up](#Cheetsheet)

```hy
Name: as->
Kind: Macro from [hyrule]
```

## hyruleThreading4

[go up](#Cheetsheet)

```hy
Name: doto
Kind: Macro from [hyrule]
Info: mutating
```

## partial

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## FPTKThreading1

[go up](#Cheetsheet)

```hy
Name: =>
Kind: FPTK Macro
Info: unification of dot-macro and ->
```

## FPTKThreading2

[go up](#Cheetsheet)

```hy
Name: =>>
Kind: FPTK Macro
Info: unification of dot-macro and ->>
```

## PipeOfPartials

[go up](#Cheetsheet)

```hy
Name: p:
Kind: FPTK Macro
Info: aplicator, pipe of partials
```

## compose

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## pflip

[go up](#Cheetsheet)

```hy
Name: pflip
Kind: FPTK original
Sgnt: pflip(f, a)
Info: applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25
```

```hy
Help on function pflip in module fptk.flow:

pflip(f, a)
    creates partial applicator for f(a,b) with args a and b flipped;
    example usage: pflip(div, 4)(1) == div(1, 4) == 0.25
```

## flip

[go up](#Cheetsheet)

```hy
Name: flip
Kind: FPTK original
Sgnt: flip(f, a, b) = f(b, a)
Info: calls f with flipped args
```

```hy
Help on function flip in module fptk.flow:

flip(f, a, b)
    flip(f, a, b) = f(b, a)
```

## fm

[go up](#Cheetsheet)

```hy
Name: fm
Kind: FPTK Macro
Sgnt: (fm (* it 3))
Info: anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'
```

## LambdaWithAppl

[go up](#Cheetsheet)

```hy
Name: f>
Kind: FPTK Macro
Sgnt: (f> (* it 3) 4)
Info: anonymous function with fm syntax, immediately applicates args
```

## lzip

[go up](#Cheetsheet)

```hy
Name: lzip
Kind: FPTK original
Sgnt: lzip(*iterables) -> List
Info: literally just list(zip(*iterables))
```

```hy
Help on function lzip in module fptk.flow:

lzip(*iterables)
```

## lmap

[go up](#Cheetsheet)

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

## mapm

[go up](#Cheetsheet)

```hy
Name: mapm
Kind: FPTK Macro
Info: same as map, but expects fm-syntax for func
```

## lmapm

[go up](#Cheetsheet)

```hy
Name: lmapm
Kind: FPTK Macro
Info: same as lmap, but expects fm-syntax for func
```

## starmap

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: lstarmap
Kind: FPTK original
Sgnt: lstarmap(function, iterable) -> list
Info: list version of starmap
```

```hy
Help on function lstarmap in module fptk.flow:

lstarmap(function, iterable)
    literally just list(starmap(function, iterable))
```

## reduce

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## sums

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## do_n

[go up](#Cheetsheet)

```hy
Name: do_n
Kind: Macro from [hyrule]
Sgnt: (do_n   n #* body) -> None
Info: expands to ~ (do body body body ...)
```

## list_n

[go up](#Cheetsheet)

```hy
Name: list_n
Kind: Macro from [hyrule]
Sgnt: (list_n n #* body) -> List
```

## nested

[go up](#Cheetsheet)

```hy
Name: nested
Kind: FPTK original
Sgnt: nested(n, f)
Info: applicator f(...(f(***)))
```

```hy
Help on function nested in module fptk.flow:

nested(n, f)
    constructs function f(f(f(...f))), where nesting is n times deep
```

## apply_n

[go up](#Cheetsheet)

```hy
Name: apply_n
Kind: FPTK original
Sgnt: apply_n(n, f, *args, **kwargs)
Info: f(f(f(...f(*args, **kwargs))
```

```hy
Help on function apply_n in module fptk.flow:

apply_n(n, f, *args, **kwargs)
    applies f to args and kwargs,
    than applies f to result of prev application,
    and this is repeated in total for n times,
    
    n=1 is simply f(args, kwargs)
```

## lfilter

[go up](#Cheetsheet)

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

## filterm

[go up](#Cheetsheet)

```hy
Name: filterm
Kind: FPTK Macro
Sgnt: (filterm f xs)
Info: same as filter, but expects fm-syntax for func
```

## lfilterm

[go up](#Cheetsheet)

```hy
Name: lfilterm
Kind: FPTK Macro
Sgnt: (lfilterm f xs)
Info: list version of lfilterm
```

## fltr1st

[go up](#Cheetsheet)

```hy
Name: fltr1st
Kind: FPTK original
Sgnt: fltr1st(f, seq) -> Optional elem
Info: returns first found element (or None)
```

```hy
Help on function fltr1st in module fptk.apl:

fltr1st(function, iterable)
    returns first found element (via function criteria), returns None if not found
```

## reject

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: without
Kind: FPTK original
Sgnt: without(items, seq) -> generator
Info: subtracts items from seq (as a sets)
```

```hy
Help on function without in module fptk.apl:

without(items, seq)
    returns generator for seq with each item in items removed (does not mutate seq)
```

## lwithout

[go up](#Cheetsheet)

```hy
Name: lwithout
Kind: FPTK original
Sgnt: lwithout(items, seq) -> list
Info: list version of reject
```

```hy
Help on function lwithout in module fptk.apl:

lwithout(items, seq)
    returns seq with each item in items removed (does not mutate seq)
```

## takewhile

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## bisect_at

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: lbisect_at
Kind: FPTK original
Sgnt: lbisect_at(n, seq) -> start, tail
Info: list version of bisect_at, but also for n<0, abs(n) will be len of tail
```

```hy
Help on function lbisect_at in module fptk.apl:

lbisect_at(n, seq)
    splits seq to start and tail lists (returns tuple of lists),
    when n>=0, len of start will be = n (or less, when len(seq) < n),
    when n<0, len of tail will be = n (or less, when len(seq) < abs(n))
```

## bisect_by

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## mask_sel

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: lmask_sel
Kind: FPTK original
Sgnt: lmask_sel(data, selectors) -> list
```

```hy
Help on function lmask_sel in module fptk.apl:

lmask_sel(data, selectors)
    selects by mask: lmask_sel('abc', [1,0,1]) -> ['a', 'c']
```

## mask2idxs

[go up](#Cheetsheet)

```hy
Name: mask2idxs
Kind: FPTK original
Sgnt: mask2idxs(mask) -> list
Info: mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]
```

```hy
Help on function mask2idxs in module fptk.apl:

mask2idxs(mask)
    mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]
```

## idxs2mask

[go up](#Cheetsheet)

```hy
Name: idxs2mask
Kind: FPTK original
Sgnt: idxs2mask(idxs) -> list
Info: idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]
```

```hy
Help on function idxs2mask in module fptk.apl:

idxs2mask(idxs, bools=False)
    idxs is non-sorted list of positive integers like [0 3 2], which will be converted to [1 0 1 1] ;
    setting bools=True will output [True False True True] instead
```

## flatten

[go up](#Cheetsheet)

```hy
Name: flatten
Kind: Reimport from [hyrule]
Sgnt: flatten(coll)
Info: flattens to the bottom, non-mutating
```

```hy
Help on function flatten in module hyrule.iterables:

flatten(coll)
    Recurisvely collect all the elements and subelements of ``coll``,
    depth-first, and return them in a single list. :hy:func:`coll?` is used to
    decide whether objects should be descended into. ::
    
    
      (flatten ["foo" #(1 2) [1 [2 3] 4] "bar"])
        ; => ["foo" 1 2 1 2 3 4 "bar"]
    
    Since iteration is used to collect the elements of ``coll``, dictionaries
    are reduced to lists of keys::
    
      (flatten [{"a" 1  "b" 2} {"c" 3  "d" 4}])
        ; => ["a" "b" "c" "d"]
    
    If ``coll`` isn't a collection at all, it's returned in a singleton list::
    
      (flatten "hello")
        ; => ["hello"]
```

## lprint

[go up](#Cheetsheet)

```hy
Name: lprint
Kind: FPTK original
Sgnt: lprint(seq, sep=None)
Info: prints every elem of seq on new line
```

```hy
Help on function lprint in module fptk.apl:

lprint(seq, sep=None)
    essentially list(map(print, seq)) ;
    with sep='---' (or some other) will print sep between seq elems
```

## lreversed

[go up](#Cheetsheet)

```hy
Name: lreversed
Kind: FPTK original
Sgnt: lreversed(sequence)
Info: list version of reversed
```

```hy
Help on function lreversed in module fptk.apl:

lreversed(sequence)
```

## partition

[go up](#Cheetsheet)

```hy
Name: partition
Kind: FPTK original
Sgnt: partition(n, seq, *, step=None, tail=False) -> generator
Info: splits seq to lists of len n, tail=True will allow including fewer than n items
```

```hy
Help on function partition in module fptk.apl:

partition(n, seq, *, step=None, tail=False)
    splits seq to lists of len n,
    at step offsets apart (step=None defaults to n when not given),
    tail=False will allow fewer than n items at the end;
    returns generator
```

## lpartition

[go up](#Cheetsheet)

```hy
Name: lpartition
Kind: FPTK original
Sgnt: lpartition(n, seq, *, step=None, tail=False) -> List
Info: simply list(partition(...))
```

```hy
Help on function lpartition in module fptk.apl:

lpartition(n, seq, *, step=None, tail=False)
    splits seq to lists of len n,
    at step offsets apart (step=None defaults to n when not given),
    tail=False will allow fewer than n items at the end;
    returns list of lists
```

## partition_by

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## lmulticut_by

[go up](#Cheetsheet)

```hy
Name: lmulticut_by
Kind: FPTK original
Sgnt: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list
Info: cut at pred(elem)==True elems
```

```hy
Help on function lmulticut_by in module fptk.apl:

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

## count_occurrences

[go up](#Cheetsheet)

```hy
Name: count_occurrences
Kind: FPTK original
Sgnt: count_occurrences(elem, seq) -> int
Info: rename of list.count method
```

```hy
Help on function count_occurrences in module fptk.apl:

count_occurrences(elem, seq)
```

## nth

[go up](#Cheetsheet)

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

## assoc

[go up](#Cheetsheet)

```hy
Name: assoc
Kind: Reimport from [hyrule]
Sgnt: assoc(xs, k1, v1, k2, v2, ...) -> None
Info: ≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)
```

```hy
Help on function assoc in module hyrule.collections:

assoc(coll, *kvs, **kwargs)
    Associate key-value pairs by assigning to elements of ``coll``. Thus, ::
    
      (assoc coll  k1 v1  k2 v2  k3 v3)
    
    is equivalent to ::
    
      (setv (get coll k1) v1)
      (setv (get coll k2) v2)
      (setv (get coll k3) v3)
    
    except ``coll`` is evaluated exactly once. Notice that this implies
    the return value is ``None``, not ``coll`` or one of the newly
    assigned elements.
    
    Keyword arguments work like positional arguments with the keyword
    used as a string key, subject to Hy's usual mangling rules. Thus,
    ``(assoc coll :foo-bar 1)`` is equivalent to ``(assoc coll "foo_bar"
    1)`` or ``(setv (get coll "foo_bar") 1)``. Assignments for keyword
    arguments occur after (and thus may override) assignments for
    positional arguments.
```

## ncut

[go up](#Cheetsheet)

```hy
Name: ncut
Kind: Macro from [hyrule]
```

## first

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: third
Kind: FPTK original
Sgnt: third(seq) -> Optional elem
```

```hy
Help on function third in module fptk.getters:

third(seq)
```

## fourth

[go up](#Cheetsheet)

```hy
Name: fourth
Kind: FPTK original
Sgnt: fourth(seq) -> Optional elem
```

```hy
Help on function fourth in module fptk.getters:

fourth(seq)
```

## beforelast

[go up](#Cheetsheet)

```hy
Name: beforelast
Kind: FPTK original
Sgnt: beforelast(seq) -> Optional elem
```

```hy
Help on function beforelast in module fptk.getters:

beforelast(seq)
```

## last

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: rest
Kind: FPTK original
Sgnt: rest(seq) -> List
Info: drops 1st elem of list
```

```hy
Help on function rest in module fptk.getters:

rest(seq)
    drops 1st elem of list
```

## butlast

[go up](#Cheetsheet)

```hy
Name: butlast
Kind: FPTK original
Sgnt: butlast(seq) -> List
Info: drops last elem of list
```

```hy
Help on function butlast in module fptk.getters:

butlast(seq)
    drops last elem of list
```

## drop

[go up](#Cheetsheet)

```hy
Name: drop
Kind: FPTK original
Sgnt: drop(n, seq) -> List
Info: drops n>=0 elems from start of the list; when n<0, drops from end of the list
```

```hy
Help on function drop in module fptk.getters:

drop(n, seq)
    drops n>=0 elems from start of seq; when n<0, drops from end of the seq
```

## take

[go up](#Cheetsheet)

```hy
Name: take
Kind: FPTK original
Sgnt: take(n, seq) -> List
Info: takes n elems from start; when n<0, takes from end of the list
```

```hy
Help on function take in module fptk.getters:

take(n, seq)
    takes n>=0 elems from start of seq; when n<0, takes from end of the seq
```

## pick

[go up](#Cheetsheet)

```hy
Name: pick
Kind: FPTK original
Sgnt: pick(ns, seq) -> List
Info: throws error if some of ns doesn't exist; ns can be list of ints or dict keys
```

```hy
Help on function pick in module fptk.getters:

pick(ns, seq)
    pics elems ns from seq,
    throws error if some of ns doesn't exist,
    ns can be list of dicts keys
```

## get_

[go up](#Cheetsheet)

```hy
Name: get_
Kind: FPTK original
Sgnt: get_(seq, *ns) -> elem
Info: same as get, but with 1-based index (will throw error for n=0)
```

```hy
Help on function get_ in module fptk.getters:

get_(seq, *ns)
    same as hy get macro, but with 1-based index,
    can also work with dict keys,
    will throw error for n=0,
    will throw error if elem not found (just like hy get macro)
```

## nth_

[go up](#Cheetsheet)

```hy
Name: nth_
Kind: FPTK original
Sgnt: nth_(n, seq) -> Optional elem
Info: same as nth, but with 1-based index; will return None for n=0
```

```hy
Help on function nth_ in module fptk.getters:

nth_(n, seq)
    same as nth, but with 1-based index,
    will throw error for n=0,
    will return None if elem not found (just like nth)
```

## slice_

[go up](#Cheetsheet)

```hy
Name: slice_
Kind: FPTK original
Sgnt: slice_(start, end, step=None)
Info: similar to slice, but with 1-based index; will throw error for start=0 or end=0
```

```hy
Help on function slice_ in module fptk.getters:

slice_(start, end, step=None)
    similar to py slice, but:
    - has 1-based index
    - will throw error when start=0 or end=0
```

## cut_

[go up](#Cheetsheet)

```hy
Name: cut_
Kind: FPTK original
Sgnt: cut_(seq, start, end, step=None) -> List
Info: similar to cut, but with 1-based index; will throw error for start=0 or end=0
```

```hy
Help on function cut_ in module fptk.getters:

cut_(seq, start, end, step=None)
    same as hy cut macro, but with 1-based index:
    - will throw error when start=0 or end=0
```

## range_

[go up](#Cheetsheet)

```hy
Name: range_ (= hyrule.thru)
Kind: Reimport
Sgnt: range_(start, end=None, step=1) -> List
Info: same as range, but with 1-based index
```

```hy
Help on function thru in module hyrule.iterables:

thru(a, b=None, step=1)
    A doubly inclusive version of :py:class:`range`. It takes the same
    arguments as ``range``, but includes the endpoint (given a
    compatible start point and step size). ::
    
      (list (thru 3))
        ; => [0 1 2 3]
      (list (thru 0 10 2))
        ; => [0 2 4 6 8 10]
      (list (thru 0 9 2))
        ; => [0 2 4 6 8]
```

## lrange_

[go up](#Cheetsheet)

```hy
Name: lrange_
Kind: FPTK original
Sgnt: lrange_(start, end, step=1) -> List
Info: range including both ends when possible, also works on fractionals
```

```hy
Help on function lrange_ in module fptk.getters:

lrange_(start, end, step=1)
    range including both ends when possible,
    also works on fractionals
```

## getattrm

[go up](#Cheetsheet)

```hy
Name: getattrm
Kind: FPTK Macro
Sgnt: (getattrm Object 'attr') (getattrm Object .attr)
Info: accepts fptk-style .attr syntax
```

## pluck

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## pluckm

[go up](#Cheetsheet)

```hy
Name: pluckm
Kind: FPTK Macro
Sgnt: (pluckm n xs) (pluckm key ys) (pluckm .attr zs)
Info: accepts fptk-style .arg syntax
```

## lpluckm

[go up](#Cheetsheet)

```hy
Name: lpluckm
Kind: FPTK Macro
Info: list version of pluckm
```

## of

[go up](#Cheetsheet)

```hy
Name: of
Kind: Macro from [hyrule]
Info: example: (of List int) which is equiv to py-code: List[int]
```

## Annotator1

[go up](#Cheetsheet)

```hy
Name: f::
Kind: FPTK Macro
Info: example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]
```

## Annotator2

[go up](#Cheetsheet)

```hy
Name: def::
Kind: FPTK Macro
Info: define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))
```

## dataclass

[go up](#Cheetsheet)

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

## Enum

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## noneQ

[go up](#Cheetsheet)

```hy
Name: noneQ (= funcy.isnone)
Kind: Reimport
```

```hy
Help on function isnone in module funcy.primitives:

isnone(x)
```

## notnoneQ

[go up](#Cheetsheet)

```hy
Name: notnoneQ (= funcy.notnone)
Kind: Reimport
```

```hy
Help on function notnone in module funcy.primitives:

notnone(x)
```

## oftypeQ

[go up](#Cheetsheet)

```hy
Name: oftypeQ
Kind: FPTK original
Sgnt: oftypeQ(tp, x)
Info: checks directly via (= (type x) tp)
```

```hy
Help on function oftypeQ in module fptk.typing:

oftypeQ(tp, x)
    checks literally if type(x) == tp
```

## intQ

[go up](#Cheetsheet)

```hy
Name: intQ
Kind: FPTK original
Sgnt: intQ(x)
Info: checks literally if type(x) == int, will also work with StrictInt from pydantic
```

```hy
Help on function intQ in module fptk.typing:

intQ(x)
    checks literally if type(x) == int
```

## floatQ

[go up](#Cheetsheet)

```hy
Name: floatQ
Kind: FPTK original
Sgnt: floatQ(x)
Info: checks literally if type(x) == float, will also work with StrictFloat from pydantic
```

```hy
Help on function floatQ in module fptk.typing:

floatQ(x)
    checks literally if type(x) == float
```

## numberQ

[go up](#Cheetsheet)

```hy
Name: numberQ
Kind: FPTK original
Sgnt: numberQ(x)
Info: checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic
```

```hy
Help on function numberQ in module fptk.typing:

numberQ(x)
    checks literally if type(x) == int or type(x) == float
```

## strQ

[go up](#Cheetsheet)

```hy
Name: strQ
Kind: FPTK original
Sgnt: strQ(x)
Info: checks literally if type(x) == str, will also work with StrictStr from pydantic
```

```hy
Help on function strQ in module fptk.typing:

strQ(x)
    checks literally if type(x) == int or type(x) == float
```

## dictQ

[go up](#Cheetsheet)

```hy
Name: dictQ
Kind: FPTK original
Sgnt: dictQ(x)
Info: checks literally if type(x) == dict
```

```hy
Help on function dictQ in module fptk.typing:

dictQ(x)
    checks literally if type(x) == dict
```

## listQ

[go up](#Cheetsheet)

```hy
Name: listQ (= funcy.is_list)
Kind: Reimport
Sgnt: listQ(value)
Info: checks if value is list
```

## tupleQ

[go up](#Cheetsheet)

```hy
Name: tupleQ (= funcy.is_tuple)
Kind: Reimport
Sgnt: tupleQ(value)
Info: checks if value is tuple
```

## setQ

[go up](#Cheetsheet)

```hy
Name: setQ (= funcy.is_set)
Kind: Reimport
Sgnt: setQ(value)
Info: checks if value is set
```

## iteratorQ

[go up](#Cheetsheet)

```hy
Name: iteratorQ (= funcy.is_iter)
Kind: Reimport
Sgnt: iteratorQ(value)
Info: checks if value is iterator
```

## iterableQ

[go up](#Cheetsheet)

```hy
Name: iterableQ (= funcy.iterable)
Kind: Reimport
Sgnt: iterableQ(value)
Info: checks if value is iterable
```

## BaseModel

[go up](#Cheetsheet)

```hy
Name: BaseModel
Kind: Reimport from [pydantic]
```

```hy
Help on class BaseModel in module pydantic.main:

class BaseModel(builtins.object)
 |  BaseModel(**data: 'Any') -> 'None'
 |  
 |  !!! abstract "Usage Documentation"
 |      [Models](../concepts/models.md)
 |  
 |  A base class for creating Pydantic models.
 |  
 |  Attributes:
 |      __class_vars__: The names of the class variables defined on the model.
 |      __private_attributes__: Metadata about the private attributes of the model.
 |      __signature__: The synthesized `__init__` [`Signature`][inspect.Signature] of the model.
 |  
 |      __pydantic_complete__: Whether model building is completed, or if there are still undefined fields.
 |      __pydantic_core_schema__: The core schema of the model.
 |      __pydantic_custom_init__: Whether the model has a custom `__init__` function.
 |      __pydantic_decorators__: Metadata containing the decorators defined on the model.
 |          This replaces `Model.__validators__` and `Model.__root_validators__` from Pydantic V1.
 |      __pydantic_generic_metadata__: Metadata for generic models; contains data used for a similar purpose to
 |          __args__, __origin__, __parameters__ in typing-module generics. May eventually be replaced by these.
 |      __pydantic_parent_namespace__: Parent namespace of the model, used for automatic rebuilding of models.
 |      __pydantic_post_init__: The name of the post-init method for the model, if defined.
 |      __pydantic_root_model__: Whether the model is a [`RootModel`][pydantic.root_model.RootModel].
 |      __pydantic_serializer__: The `pydantic-core` `SchemaSerializer` used to dump instances of the model.
 |      __pydantic_validator__: The `pydantic-core` `SchemaValidator` used to validate instances of the model.
 |  
 |      __pydantic_fields__: A dictionary of field names and their corresponding [`FieldInfo`][pydantic.fields.FieldInfo] objects.
 |      __pydantic_computed_fields__: A dictionary of computed field names and their corresponding [`ComputedFieldInfo`][pydantic.fields.ComputedFieldInfo] objects.
 |  
 |      __pydantic_extra__: A dictionary containing extra values, if [`extra`][pydantic.config.ConfigDict.extra]
 |          is set to `'allow'`.
 |      __pydantic_fields_set__: The names of fields explicitly set during instantiation.
 |      __pydantic_private__: Values of private attributes set on the model instance.
 |  
 |  Methods defined here:
 |  
 |  __copy__(self) -> 'Self'
 |      Returns a shallow copy of the model.
 |  
 |  __deepcopy__(self, memo: 'dict[int, Any] | None' = None) -> 'Self'
 |      Returns a deep copy of the model.
 |  
 |  __delattr__(self, item: 'str') -> 'Any'
 |      Implement delattr(self, name).
 |  
 |  __eq__(self, other: 'Any') -> 'bool'
 |      Return self==value.
 |  
 |  __getattr__(self, item: 'str') -> 'Any'
 |  
 |  __getstate__(self) -> 'dict[Any, Any]'
 |  
 |  __init__(self, /, **data: 'Any') -> 'None'
 |      Create a new model by parsing and validating input data from keyword arguments.
 |      
 |      Raises [`ValidationError`][pydantic_core.ValidationError] if the input data cannot be
 |      validated to form a valid model.
 |      
 |      `self` is explicitly positional-only to allow `self` as a field name.
 |  
 |  __iter__(self) -> 'TupleGenerator'
 |      So `dict(model)` works.
 |  
 |  __pretty__(self, fmt: 'Callable[[Any], Any]', **kwargs: 'Any') -> 'Generator[Any]'
 |      Used by devtools (https://python-devtools.helpmanual.io/) to pretty print objects.
 |  
 |  __replace__(self, **changes: 'Any') -> 'Self'
 |      # Because we make use of `@dataclass_transform()`, `__replace__` is already synthesized by
 |      # type checkers, so we define the implementation in this `if not TYPE_CHECKING:` block:
 |  
 |  __repr__(self) -> 'str'
 |      Return repr(self).
 |  
 |  __repr_args__(self) -> '_repr.ReprArgs'
 |  
 |  __repr_name__(self) -> 'str'
 |      Name of the instance's class, used in __repr__.
 |  
 |  __repr_recursion__(self, object: 'Any') -> 'str'
 |      Returns the string representation of a recursive object.
 |  
 |  __repr_str__(self, join_str: 'str') -> 'str'
 |  
 |  __rich_repr__(self) -> 'RichReprResult'
 |      Used by Rich (https://rich.readthedocs.io/en/stable/pretty.html) to pretty print objects.
 |  
 |  __setattr__(self, name: 'str', value: 'Any') -> 'None'
 |      Implement setattr(self, name, value).
 |  
 |  __setstate__(self, state: 'dict[Any, Any]') -> 'None'
 |  
 |  __str__(self) -> 'str'
 |      Return str(self).
 |  
 |  copy(self, *, include: 'AbstractSetIntStr | MappingIntStrAny | None' = None, exclude: 'AbstractSetIntStr | MappingIntStrAny | None' = None, update: 'Dict[str, Any] | None' = None, deep: 'bool' = False) -> 'Self'
 |      Returns a copy of the model.
 |      
 |      !!! warning "Deprecated"
 |          This method is now deprecated; use `model_copy` instead.
 |      
 |      If you need `include` or `exclude`, use:
 |      
 |      ```python {test="skip" lint="skip"}
 |      data = self.model_dump(include=include, exclude=exclude, round_trip=True)
 |      data = {**data, **(update or {})}
 |      copied = self.model_validate(data)
 |      ```
 |      
 |      Args:
 |          include: Optional set or mapping specifying which fields to include in the copied model.
 |          exclude: Optional set or mapping specifying which fields to exclude in the copied model.
 |          update: Optional dictionary of field-value pairs to override field values in the copied model.
 |          deep: If True, the values of fields that are Pydantic models will be deep-copied.
 |      
 |      Returns:
 |          A copy of the model with included, excluded and updated fields as specified.
 |  
 |  dict(self, *, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, by_alias: 'bool' = False, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False) -> 'Dict[str, Any]'
 |  
 |  json(self, *, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, by_alias: 'bool' = False, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, encoder: 'Callable[[Any], Any] | None' = PydanticUndefined, models_as_dict: 'bool' = PydanticUndefined, **dumps_kwargs: 'Any') -> 'str'
 |  
 |  model_copy(self, *, update: 'Mapping[str, Any] | None' = None, deep: 'bool' = False) -> 'Self'
 |      !!! abstract "Usage Documentation"
 |          [`model_copy`](../concepts/models.md#model-copy)
 |      
 |      Returns a copy of the model.
 |      
 |      !!! note
 |          The underlying instance's [`__dict__`][object.__dict__] attribute is copied. This
 |          might have unexpected side effects if you store anything in it, on top of the model
 |          fields (e.g. the value of [cached properties][functools.cached_property]).
 |      
 |      Args:
 |          update: Values to change/add in the new model. Note: the data is not validated
 |              before creating the new model. You should trust this data.
 |          deep: Set to `True` to make a deep copy of the model.
 |      
 |      Returns:
 |          New model instance.
 |  
 |  model_dump(self, *, mode: "Literal['json', 'python'] | str" = 'python', include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, exclude_computed_fields: 'bool' = False, round_trip: 'bool' = False, warnings: "bool | Literal['none', 'warn', 'error']" = True, fallback: 'Callable[[Any], Any] | None' = None, serialize_as_any: 'bool' = False) -> 'dict[str, Any]'
 |      !!! abstract "Usage Documentation"
 |          [`model_dump`](../concepts/serialization.md#python-mode)
 |      
 |      Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.
 |      
 |      Args:
 |          mode: The mode in which `to_python` should run.
 |              If mode is 'json', the output will only contain JSON serializable types.
 |              If mode is 'python', the output may contain non-JSON-serializable Python objects.
 |          include: A set of fields to include in the output.
 |          exclude: A set of fields to exclude from the output.
 |          context: Additional context to pass to the serializer.
 |          by_alias: Whether to use the field's alias in the dictionary key if defined.
 |          exclude_unset: Whether to exclude fields that have not been explicitly set.
 |          exclude_defaults: Whether to exclude fields that are set to their default value.
 |          exclude_none: Whether to exclude fields that have a value of `None`.
 |          exclude_computed_fields: Whether to exclude computed fields.
 |              While this can be useful for round-tripping, it is usually recommended to use the dedicated
 |              `round_trip` parameter instead.
 |          round_trip: If True, dumped values should be valid as input for non-idempotent types such as Json[T].
 |          warnings: How to handle serialization errors. False/"none" ignores them, True/"warn" logs errors,
 |              "error" raises a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError].
 |          fallback: A function to call when an unknown value is encountered. If not provided,
 |              a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError] error is raised.
 |          serialize_as_any: Whether to serialize fields with duck-typing serialization behavior.
 |      
 |      Returns:
 |          A dictionary representation of the model.
 |  
 |  model_dump_json(self, *, indent: 'int | None' = None, ensure_ascii: 'bool' = False, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, exclude_computed_fields: 'bool' = False, round_trip: 'bool' = False, warnings: "bool | Literal['none', 'warn', 'error']" = True, fallback: 'Callable[[Any], Any] | None' = None, serialize_as_any: 'bool' = False) -> 'str'
 |      !!! abstract "Usage Documentation"
 |          [`model_dump_json`](../concepts/serialization.md#json-mode)
 |      
 |      Generates a JSON representation of the model using Pydantic's `to_json` method.
 |      
 |      Args:
 |          indent: Indentation to use in the JSON output. If None is passed, the output will be compact.
 |          ensure_ascii: If `True`, the output is guaranteed to have all incoming non-ASCII characters escaped.
 |              If `False` (the default), these characters will be output as-is.
 |          include: Field(s) to include in the JSON output.
 |          exclude: Field(s) to exclude from the JSON output.
 |          context: Additional context to pass to the serializer.
 |          by_alias: Whether to serialize using field aliases.
 |          exclude_unset: Whether to exclude fields that have not been explicitly set.
 |          exclude_defaults: Whether to exclude fields that are set to their default value.
 |          exclude_none: Whether to exclude fields that have a value of `None`.
 |          exclude_computed_fields: Whether to exclude computed fields.
 |              While this can be useful for round-tripping, it is usually recommended to use the dedicated
 |              `round_trip` parameter instead.
 |          round_trip: If True, dumped values should be valid as input for non-idempotent types such as Json[T].
 |          warnings: How to handle serialization errors. False/"none" ignores them, True/"warn" logs errors,
 |              "error" raises a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError].
 |          fallback: A function to call when an unknown value is encountered. If not provided,
 |              a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError] error is raised.
 |          serialize_as_any: Whether to serialize fields with duck-typing serialization behavior.
 |      
 |      Returns:
 |          A JSON string representation of the model.
 |  
 |  model_post_init(self, context: 'Any', /) -> 'None'
 |      Override this method to perform additional initialization after `__init__` and `model_construct`.
 |      This is useful if you want to do some validation that requires the entire model to be initialized.
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  __class_getitem__(typevar_values: 'type[Any] | tuple[type[Any], ...]') -> 'type[BaseModel] | _forward_ref.PydanticRecursiveRef' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  __get_pydantic_core_schema__(source: 'type[BaseModel]', handler: 'GetCoreSchemaHandler', /) -> 'CoreSchema' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  __get_pydantic_json_schema__(core_schema: 'CoreSchema', handler: 'GetJsonSchemaHandler', /) -> 'JsonSchemaValue' from pydantic._internal._model_construction.ModelMetaclass
 |      Hook into generating the model's JSON schema.
 |      
 |      Args:
 |          core_schema: A `pydantic-core` CoreSchema.
 |              You can ignore this argument and call the handler with a new CoreSchema,
 |              wrap this CoreSchema (`{'type': 'nullable', 'schema': current_schema}`),
 |              or just call the handler with the original schema.
 |          handler: Call into Pydantic's internal JSON schema generation.
 |              This will raise a `pydantic.errors.PydanticInvalidForJsonSchema` if JSON schema
 |              generation fails.
 |              Since this gets called by `BaseModel.model_json_schema` you can override the
 |              `schema_generator` argument to that function to change JSON schema generation globally
 |              for a type.
 |      
 |      Returns:
 |          A JSON schema, as a Python object.
 |  
 |  __pydantic_init_subclass__(**kwargs: 'Any') -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |      This is intended to behave just like `__init_subclass__`, but is called by `ModelMetaclass`
 |      only after basic class initialization is complete. In particular, attributes like `model_fields` will
 |      be present when this is called, but forward annotations are not guaranteed to be resolved yet,
 |      meaning that creating an instance of the class may fail.
 |      
 |      This is necessary because `__init_subclass__` will always be called by `type.__new__`,
 |      and it would require a prohibitively large refactor to the `ModelMetaclass` to ensure that
 |      `type.__new__` was called in such a manner that the class would already be sufficiently initialized.
 |      
 |      This will receive the same `kwargs` that would be passed to the standard `__init_subclass__`, namely,
 |      any kwargs passed to the class definition that aren't used internally by Pydantic.
 |      
 |      Args:
 |          **kwargs: Any keyword arguments passed to the class definition that aren't used internally
 |              by Pydantic.
 |      
 |      Note:
 |          You may want to override [`__pydantic_on_complete__()`][pydantic.main.BaseModel.__pydantic_on_complete__]
 |          instead, which is called once the class and its fields are fully initialized and ready for validation.
 |  
 |  __pydantic_on_complete__() -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |      This is called once the class and its fields are fully initialized and ready to be used.
 |      
 |      This typically happens when the class is created (just before
 |      [`__pydantic_init_subclass__()`][pydantic.main.BaseModel.__pydantic_init_subclass__] is called on the superclass),
 |      except when forward annotations are used that could not immediately be resolved.
 |      In that case, it will be called later, when the model is rebuilt automatically or explicitly using
 |      [`model_rebuild()`][pydantic.main.BaseModel.model_rebuild].
 |  
 |  construct(_fields_set: 'set[str] | None' = None, **values: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  from_orm(obj: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  model_construct(_fields_set: 'set[str] | None' = None, **values: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Creates a new instance of the `Model` class with validated data.
 |      
 |      Creates a new model setting `__dict__` and `__pydantic_fields_set__` from trusted or pre-validated data.
 |      Default values are respected, but no other validation is performed.
 |      
 |      !!! note
 |          `model_construct()` generally respects the `model_config.extra` setting on the provided model.
 |          That is, if `model_config.extra == 'allow'`, then all extra passed values are added to the model instance's `__dict__`
 |          and `__pydantic_extra__` fields. If `model_config.extra == 'ignore'` (the default), then all extra passed values are ignored.
 |          Because no validation is performed with a call to `model_construct()`, having `model_config.extra == 'forbid'` does not result in
 |          an error if extra values are passed, but they will be ignored.
 |      
 |      Args:
 |          _fields_set: A set of field names that were originally explicitly set during instantiation. If provided,
 |              this is directly used for the [`model_fields_set`][pydantic.BaseModel.model_fields_set] attribute.
 |              Otherwise, the field names from the `values` argument will be used.
 |          values: Trusted or pre-validated data dictionary.
 |      
 |      Returns:
 |          A new instance of the `Model` class with validated data.
 |  
 |  model_json_schema(by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}', schema_generator: 'type[GenerateJsonSchema]' = <class 'pydantic.json_schema.GenerateJsonSchema'>, mode: 'JsonSchemaMode' = 'validation', *, union_format: "Literal['any_of', 'primitive_type_array']" = 'any_of') -> 'dict[str, Any]' from pydantic._internal._model_construction.ModelMetaclass
 |      Generates a JSON schema for a model class.
 |      
 |      Args:
 |          by_alias: Whether to use attribute aliases or not.
 |          ref_template: The reference template.
 |          union_format: The format to use when combining schemas from unions together. Can be one of:
 |      
 |              - `'any_of'`: Use the [`anyOf`](https://json-schema.org/understanding-json-schema/reference/combining#anyOf)
 |              keyword to combine schemas (the default).
 |              - `'primitive_type_array'`: Use the [`type`](https://json-schema.org/understanding-json-schema/reference/type)
 |              keyword as an array of strings, containing each type of the combination. If any of the schemas is not a primitive
 |              type (`string`, `boolean`, `null`, `integer` or `number`) or contains constraints/metadata, falls back to
 |              `any_of`.
 |          schema_generator: To override the logic used to generate the JSON schema, as a subclass of
 |              `GenerateJsonSchema` with your desired modifications
 |          mode: The mode in which to generate the schema.
 |      
 |      Returns:
 |          The JSON schema for the given model class.
 |  
 |  model_parametrized_name(params: 'tuple[type[Any], ...]') -> 'str' from pydantic._internal._model_construction.ModelMetaclass
 |      Compute the class name for parametrizations of generic classes.
 |      
 |      This method can be overridden to achieve a custom naming scheme for generic BaseModels.
 |      
 |      Args:
 |          params: Tuple of types of the class. Given a generic class
 |              `Model` with 2 type variables and a concrete model `Model[str, int]`,
 |              the value `(str, int)` would be passed to `params`.
 |      
 |      Returns:
 |          String representing the new class where `params` are passed to `cls` as type variables.
 |      
 |      Raises:
 |          TypeError: Raised when trying to generate concrete names for non-generic models.
 |  
 |  model_rebuild(*, force: 'bool' = False, raise_errors: 'bool' = True, _parent_namespace_depth: 'int' = 2, _types_namespace: 'MappingNamespace | None' = None) -> 'bool | None' from pydantic._internal._model_construction.ModelMetaclass
 |      Try to rebuild the pydantic-core schema for the model.
 |      
 |      This may be necessary when one of the annotations is a ForwardRef which could not be resolved during
 |      the initial attempt to build the schema, and automatic rebuilding fails.
 |      
 |      Args:
 |          force: Whether to force the rebuilding of the model schema, defaults to `False`.
 |          raise_errors: Whether to raise errors, defaults to `True`.
 |          _parent_namespace_depth: The depth level of the parent namespace, defaults to 2.
 |          _types_namespace: The types namespace, defaults to `None`.
 |      
 |      Returns:
 |          Returns `None` if the schema is already "complete" and rebuilding was not required.
 |          If rebuilding _was_ required, returns `True` if rebuilding was successful, otherwise `False`.
 |  
 |  model_validate(obj: 'Any', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, from_attributes: 'bool | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Validate a pydantic model instance.
 |      
 |      Args:
 |          obj: The object to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          from_attributes: Whether to extract data from object attributes.
 |          context: Additional context to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Raises:
 |          ValidationError: If the object could not be validated.
 |      
 |      Returns:
 |          The validated model instance.
 |  
 |  model_validate_json(json_data: 'str | bytes | bytearray', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      !!! abstract "Usage Documentation"
 |          [JSON Parsing](../concepts/json.md#json-parsing)
 |      
 |      Validate the given JSON data against the Pydantic model.
 |      
 |      Args:
 |          json_data: The JSON data to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          context: Extra variables to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Returns:
 |          The validated Pydantic model.
 |      
 |      Raises:
 |          ValidationError: If `json_data` is not a JSON string or the object could not be validated.
 |  
 |  model_validate_strings(obj: 'Any', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Validate the given object with string data against the Pydantic model.
 |      
 |      Args:
 |          obj: The object containing string data to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          context: Extra variables to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Returns:
 |          The validated Pydantic model.
 |  
 |  parse_file(path: 'str | Path', *, content_type: 'str | None' = None, encoding: 'str' = 'utf8', proto: 'DeprecatedParseProtocol | None' = None, allow_pickle: 'bool' = False) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  parse_obj(obj: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  parse_raw(b: 'str | bytes', *, content_type: 'str | None' = None, encoding: 'str' = 'utf8', proto: 'DeprecatedParseProtocol | None' = None, allow_pickle: 'bool' = False) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  schema(by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}') -> 'Dict[str, Any]' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  schema_json(*, by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}', **dumps_kwargs: 'Any') -> 'str' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  update_forward_refs(**localns: 'Any') -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  validate(value: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  ----------------------------------------------------------------------
 |  Readonly properties defined here:
 |  
 |  __fields_set__
 |  
 |  model_extra
 |      Get extra fields set during validation.
 |      
 |      Returns:
 |          A dictionary of extra fields, or `None` if `config.extra` is not set to `"allow"`.
 |  
 |  model_fields_set
 |      Returns the set of fields that have been explicitly set on this model instance.
 |      
 |      Returns:
 |          A set of strings representing the fields that have been set,
 |              i.e. that were not filled from defaults.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __pydantic_extra__
 |  
 |  __pydantic_fields_set__
 |  
 |  __pydantic_private__
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |  
 |  __abstractmethods__ = frozenset()
 |  
 |  __annotations__ = {}
 |  
 |  __hash__ = None
 |  
 |  __pydantic_complete__ = False
 |  
 |  __pydantic_core_schema__ = <pydantic._internal._mock_val_ser.MockCoreS...
 |  
 |  __pydantic_decorators__ = DecoratorInfos(validators={}, field_validato...
 |  
 |  __pydantic_parent_namespace__ = None
 |  
 |  __pydantic_root_model__ = False
 |  
 |  __pydantic_serializer__ = <pydantic._internal._mock_val_ser.MockValSer...
 |  
 |  __pydantic_validator__ = <pydantic._internal._mock_val_ser.MockValSer ...
 |  
 |  model_computed_fields = {}
 |  
 |  model_config = {}
 |  
 |  model_fields = {}
```

## StrictInt

[go up](#Cheetsheet)

```hy
Name: StrictInt
Kind: Reimport from [pydantic]
Info: will be still of int type, but will perform strict typecheck when variable is created
```

```hy
Help on _AnnotatedAlias in module builtins:

Annotated = class int(object)
 |  int([x]) -> integer
 |  int(x, base=10) -> integer
 |  
 |  Convert a number or string to an integer, or return 0 if no arguments
 |  are given.  If x is a number, return x.__int__().  For floating point
 |  numbers, this truncates towards zero.
 |  
 |  If x is not a number or if base is given, then x must be a string,
 |  bytes, or bytearray instance representing an integer literal in the
 |  given base.  The literal can be preceded by '+' or '-' and be surrounded
 |  by whitespace.  The base defaults to 10.  Valid bases are 0 and 2-36.
 |  Base 0 means to interpret the base from the string as an integer literal.
 |  >>> int('0b100', base=0)
 |  4
 |  
 |  Built-in subclasses:
 |      bool
 |  
 |  Methods defined here:
 |  
 |  __abs__(self, /)
 |      abs(self)
 |  
 |  __add__(self, value, /)
 |      Return self+value.
 |  
 |  __and__(self, value, /)
 |      Return self&value.
 |  
 |  __bool__(self, /)
 |      True if self else False
 |  
 |  __ceil__(...)
 |      Ceiling of an Integral returns itself.
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
 |  __floor__(...)
 |      Flooring an Integral returns itself.
 |  
 |  __floordiv__(self, value, /)
 |      Return self//value.
 |  
 |  __format__(self, format_spec, /)
 |      Default object formatter.
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
 |  __index__(self, /)
 |      Return self converted to an integer, if self is suitable for use as an index into a list.
 |  
 |  __int__(self, /)
 |      int(self)
 |  
 |  __invert__(self, /)
 |      ~self
 |  
 |  __le__(self, value, /)
 |      Return self<=value.
 |  
 |  __lshift__(self, value, /)
 |      Return self<<value.
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
 |  __or__(self, value, /)
 |      Return self|value.
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
 |  __rand__(self, value, /)
 |      Return value&self.
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
 |  __rlshift__(self, value, /)
 |      Return value<<self.
 |  
 |  __rmod__(self, value, /)
 |      Return value%self.
 |  
 |  __rmul__(self, value, /)
 |      Return value*self.
 |  
 |  __ror__(self, value, /)
 |      Return value|self.
 |  
 |  __round__(...)
 |      Rounding an Integral returns itself.
 |      
 |      Rounding with an ndigits argument also returns an integer.
 |  
 |  __rpow__(self, value, mod=None, /)
 |      Return pow(value, self, mod).
 |  
 |  __rrshift__(self, value, /)
 |      Return value>>self.
 |  
 |  __rshift__(self, value, /)
 |      Return self>>value.
 |  
 |  __rsub__(self, value, /)
 |      Return value-self.
 |  
 |  __rtruediv__(self, value, /)
 |      Return value/self.
 |  
 |  __rxor__(self, value, /)
 |      Return value^self.
 |  
 |  __sizeof__(self, /)
 |      Returns size in memory, in bytes.
 |  
 |  __sub__(self, value, /)
 |      Return self-value.
 |  
 |  __truediv__(self, value, /)
 |      Return self/value.
 |  
 |  __trunc__(...)
 |      Truncating an Integral returns itself.
 |  
 |  __xor__(self, value, /)
 |      Return self^value.
 |  
 |  as_integer_ratio(self, /)
 |      Return integer ratio.
 |      
 |      Return a pair of integers, whose ratio is exactly equal to the original int
 |      and with a positive denominator.
 |      
 |      >>> (10).as_integer_ratio()
 |      (10, 1)
 |      >>> (-10).as_integer_ratio()
 |      (-10, 1)
 |      >>> (0).as_integer_ratio()
 |      (0, 1)
 |  
 |  bit_count(self, /)
 |      Number of ones in the binary representation of the absolute value of self.
 |      
 |      Also known as the population count.
 |      
 |      >>> bin(13)
 |      '0b1101'
 |      >>> (13).bit_count()
 |      3
 |  
 |  bit_length(self, /)
 |      Number of bits necessary to represent self in binary.
 |      
 |      >>> bin(37)
 |      '0b100101'
 |      >>> (37).bit_length()
 |      6
 |  
 |  conjugate(...)
 |      Returns self, the complex conjugate of any int.
 |  
 |  to_bytes(self, /, length, byteorder, *, signed=False)
 |      Return an array of bytes representing an integer.
 |      
 |      length
 |        Length of bytes object to use.  An OverflowError is raised if the
 |        integer is not representable with the given number of bytes.
 |      byteorder
 |        The byte order used to represent the integer.  If byteorder is 'big',
 |        the most significant byte is at the beginning of the byte array.  If
 |        byteorder is 'little', the most significant byte is at the end of the
 |        byte array.  To request the native byte order of the host system, use
 |        `sys.byteorder' as the byte order value.
 |      signed
 |        Determines whether two's complement is used to represent the integer.
 |        If signed is False and a negative integer is given, an OverflowError
 |        is raised.
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  from_bytes(bytes, byteorder, *, signed=False) from builtins.type
 |      Return the integer represented by the given array of bytes.
 |      
 |      bytes
 |        Holds the array of bytes to convert.  The argument must either
 |        support the buffer protocol or be an iterable object producing bytes.
 |        Bytes and bytearray are examples of built-in objects that support the
 |        buffer protocol.
 |      byteorder
 |        The byte order used to represent the integer.  If byteorder is 'big',
 |        the most significant byte is at the beginning of the byte array.  If
 |        byteorder is 'little', the most significant byte is at the end of the
 |        byte array.  To request the native byte order of the host system, use
 |        `sys.byteorder' as the byte order value.
 |      signed
 |        Indicates whether two's complement is used to represent the integer.
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
 |  denominator
 |      the denominator of a rational number in lowest terms
 |  
 |  imag
 |      the imaginary part of a complex number
 |  
 |  numerator
 |      the numerator of a rational number in lowest terms
 |  
 |  real
 |      the real part of a complex number
```

## StrictStr

[go up](#Cheetsheet)

```hy
Name: StrictStr
Kind: Reimport from [pydantic]
Info: will be still of str type, but will perform strict typecheck when variable is created
```

```hy
Help on _AnnotatedAlias in module builtins:

Annotated = class str(object)
 |  str(object='') -> str
 |  str(bytes_or_buffer[, encoding[, errors]]) -> str
 |  
 |  Create a new string object from the given object. If encoding or
 |  errors is specified, then the object must expose a data buffer
 |  that will be decoded using the given encoding and error handler.
 |  Otherwise, returns the result of object.__str__() (if defined)
 |  or repr(object).
 |  encoding defaults to sys.getdefaultencoding().
 |  errors defaults to 'strict'.
 |  
 |  Methods defined here:
 |  
 |  __add__(self, value, /)
 |      Return self+value.
 |  
 |  __contains__(self, key, /)
 |      Return key in self.
 |  
 |  __eq__(self, value, /)
 |      Return self==value.
 |  
 |  __format__(self, format_spec, /)
 |      Return a formatted version of the string as described by format_spec.
 |  
 |  __ge__(self, value, /)
 |      Return self>=value.
 |  
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 |  
 |  __getitem__(self, key, /)
 |      Return self[key].
 |  
 |  __getnewargs__(...)
 |  
 |  __gt__(self, value, /)
 |      Return self>value.
 |  
 |  __hash__(self, /)
 |      Return hash(self).
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __le__(self, value, /)
 |      Return self<=value.
 |  
 |  __len__(self, /)
 |      Return len(self).
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
 |  __repr__(self, /)
 |      Return repr(self).
 |  
 |  __rmod__(self, value, /)
 |      Return value%self.
 |  
 |  __rmul__(self, value, /)
 |      Return value*self.
 |  
 |  __sizeof__(self, /)
 |      Return the size of the string in memory, in bytes.
 |  
 |  __str__(self, /)
 |      Return str(self).
 |  
 |  capitalize(self, /)
 |      Return a capitalized version of the string.
 |      
 |      More specifically, make the first character have upper case and the rest lower
 |      case.
 |  
 |  casefold(self, /)
 |      Return a version of the string suitable for caseless comparisons.
 |  
 |  center(self, width, fillchar=' ', /)
 |      Return a centered string of length width.
 |      
 |      Padding is done using the specified fill character (default is a space).
 |  
 |  count(...)
 |      S.count(sub[, start[, end]]) -> int
 |      
 |      Return the number of non-overlapping occurrences of substring sub in
 |      string S[start:end].  Optional arguments start and end are
 |      interpreted as in slice notation.
 |  
 |  encode(self, /, encoding='utf-8', errors='strict')
 |      Encode the string using the codec registered for encoding.
 |      
 |      encoding
 |        The encoding in which to encode the string.
 |      errors
 |        The error handling scheme to use for encoding errors.
 |        The default is 'strict' meaning that encoding errors raise a
 |        UnicodeEncodeError.  Other possible values are 'ignore', 'replace' and
 |        'xmlcharrefreplace' as well as any other name registered with
 |        codecs.register_error that can handle UnicodeEncodeErrors.
 |  
 |  endswith(...)
 |      S.endswith(suffix[, start[, end]]) -> bool
 |      
 |      Return True if S ends with the specified suffix, False otherwise.
 |      With optional start, test S beginning at that position.
 |      With optional end, stop comparing S at that position.
 |      suffix can also be a tuple of strings to try.
 |  
 |  expandtabs(self, /, tabsize=8)
 |      Return a copy where all tab characters are expanded using spaces.
 |      
 |      If tabsize is not given, a tab size of 8 characters is assumed.
 |  
 |  find(...)
 |      S.find(sub[, start[, end]]) -> int
 |      
 |      Return the lowest index in S where substring sub is found,
 |      such that sub is contained within S[start:end].  Optional
 |      arguments start and end are interpreted as in slice notation.
 |      
 |      Return -1 on failure.
 |  
 |  format(...)
 |      S.format(*args, **kwargs) -> str
 |      
 |      Return a formatted version of S, using substitutions from args and kwargs.
 |      The substitutions are identified by braces ('{' and '}').
 |  
 |  format_map(...)
 |      S.format_map(mapping) -> str
 |      
 |      Return a formatted version of S, using substitutions from mapping.
 |      The substitutions are identified by braces ('{' and '}').
 |  
 |  index(...)
 |      S.index(sub[, start[, end]]) -> int
 |      
 |      Return the lowest index in S where substring sub is found,
 |      such that sub is contained within S[start:end].  Optional
 |      arguments start and end are interpreted as in slice notation.
 |      
 |      Raises ValueError when the substring is not found.
 |  
 |  isalnum(self, /)
 |      Return True if the string is an alpha-numeric string, False otherwise.
 |      
 |      A string is alpha-numeric if all characters in the string are alpha-numeric and
 |      there is at least one character in the string.
 |  
 |  isalpha(self, /)
 |      Return True if the string is an alphabetic string, False otherwise.
 |      
 |      A string is alphabetic if all characters in the string are alphabetic and there
 |      is at least one character in the string.
 |  
 |  isascii(self, /)
 |      Return True if all characters in the string are ASCII, False otherwise.
 |      
 |      ASCII characters have code points in the range U+0000-U+007F.
 |      Empty string is ASCII too.
 |  
 |  isdecimal(self, /)
 |      Return True if the string is a decimal string, False otherwise.
 |      
 |      A string is a decimal string if all characters in the string are decimal and
 |      there is at least one character in the string.
 |  
 |  isdigit(self, /)
 |      Return True if the string is a digit string, False otherwise.
 |      
 |      A string is a digit string if all characters in the string are digits and there
 |      is at least one character in the string.
 |  
 |  isidentifier(self, /)
 |      Return True if the string is a valid Python identifier, False otherwise.
 |      
 |      Call keyword.iskeyword(s) to test whether string s is a reserved identifier,
 |      such as "def" or "class".
 |  
 |  islower(self, /)
 |      Return True if the string is a lowercase string, False otherwise.
 |      
 |      A string is lowercase if all cased characters in the string are lowercase and
 |      there is at least one cased character in the string.
 |  
 |  isnumeric(self, /)
 |      Return True if the string is a numeric string, False otherwise.
 |      
 |      A string is numeric if all characters in the string are numeric and there is at
 |      least one character in the string.
 |  
 |  isprintable(self, /)
 |      Return True if the string is printable, False otherwise.
 |      
 |      A string is printable if all of its characters are considered printable in
 |      repr() or if it is empty.
 |  
 |  isspace(self, /)
 |      Return True if the string is a whitespace string, False otherwise.
 |      
 |      A string is whitespace if all characters in the string are whitespace and there
 |      is at least one character in the string.
 |  
 |  istitle(self, /)
 |      Return True if the string is a title-cased string, False otherwise.
 |      
 |      In a title-cased string, upper- and title-case characters may only
 |      follow uncased characters and lowercase characters only cased ones.
 |  
 |  isupper(self, /)
 |      Return True if the string is an uppercase string, False otherwise.
 |      
 |      A string is uppercase if all cased characters in the string are uppercase and
 |      there is at least one cased character in the string.
 |  
 |  join(self, iterable, /)
 |      Concatenate any number of strings.
 |      
 |      The string whose method is called is inserted in between each given string.
 |      The result is returned as a new string.
 |      
 |      Example: '.'.join(['ab', 'pq', 'rs']) -> 'ab.pq.rs'
 |  
 |  ljust(self, width, fillchar=' ', /)
 |      Return a left-justified string of length width.
 |      
 |      Padding is done using the specified fill character (default is a space).
 |  
 |  lower(self, /)
 |      Return a copy of the string converted to lowercase.
 |  
 |  lstrip(self, chars=None, /)
 |      Return a copy of the string with leading whitespace removed.
 |      
 |      If chars is given and not None, remove characters in chars instead.
 |  
 |  partition(self, sep, /)
 |      Partition the string into three parts using the given separator.
 |      
 |      This will search for the separator in the string.  If the separator is found,
 |      returns a 3-tuple containing the part before the separator, the separator
 |      itself, and the part after it.
 |      
 |      If the separator is not found, returns a 3-tuple containing the original string
 |      and two empty strings.
 |  
 |  removeprefix(self, prefix, /)
 |      Return a str with the given prefix string removed if present.
 |      
 |      If the string starts with the prefix string, return string[len(prefix):].
 |      Otherwise, return a copy of the original string.
 |  
 |  removesuffix(self, suffix, /)
 |      Return a str with the given suffix string removed if present.
 |      
 |      If the string ends with the suffix string and that suffix is not empty,
 |      return string[:-len(suffix)]. Otherwise, return a copy of the original
 |      string.
 |  
 |  replace(self, old, new, count=-1, /)
 |      Return a copy with all occurrences of substring old replaced by new.
 |      
 |        count
 |          Maximum number of occurrences to replace.
 |          -1 (the default value) means replace all occurrences.
 |      
 |      If the optional argument count is given, only the first count occurrences are
 |      replaced.
 |  
 |  rfind(...)
 |      S.rfind(sub[, start[, end]]) -> int
 |      
 |      Return the highest index in S where substring sub is found,
 |      such that sub is contained within S[start:end].  Optional
 |      arguments start and end are interpreted as in slice notation.
 |      
 |      Return -1 on failure.
 |  
 |  rindex(...)
 |      S.rindex(sub[, start[, end]]) -> int
 |      
 |      Return the highest index in S where substring sub is found,
 |      such that sub is contained within S[start:end].  Optional
 |      arguments start and end are interpreted as in slice notation.
 |      
 |      Raises ValueError when the substring is not found.
 |  
 |  rjust(self, width, fillchar=' ', /)
 |      Return a right-justified string of length width.
 |      
 |      Padding is done using the specified fill character (default is a space).
 |  
 |  rpartition(self, sep, /)
 |      Partition the string into three parts using the given separator.
 |      
 |      This will search for the separator in the string, starting at the end. If
 |      the separator is found, returns a 3-tuple containing the part before the
 |      separator, the separator itself, and the part after it.
 |      
 |      If the separator is not found, returns a 3-tuple containing two empty strings
 |      and the original string.
 |  
 |  rsplit(self, /, sep=None, maxsplit=-1)
 |      Return a list of the substrings in the string, using sep as the separator string.
 |      
 |        sep
 |          The separator used to split the string.
 |      
 |          When set to None (the default value), will split on any whitespace
 |          character (including \\n \\r \\t \\f and spaces) and will discard
 |          empty strings from the result.
 |        maxsplit
 |          Maximum number of splits (starting from the left).
 |          -1 (the default value) means no limit.
 |      
 |      Splitting starts at the end of the string and works to the front.
 |  
 |  rstrip(self, chars=None, /)
 |      Return a copy of the string with trailing whitespace removed.
 |      
 |      If chars is given and not None, remove characters in chars instead.
 |  
 |  split(self, /, sep=None, maxsplit=-1)
 |      Return a list of the substrings in the string, using sep as the separator string.
 |      
 |        sep
 |          The separator used to split the string.
 |      
 |          When set to None (the default value), will split on any whitespace
 |          character (including \\n \\r \\t \\f and spaces) and will discard
 |          empty strings from the result.
 |        maxsplit
 |          Maximum number of splits (starting from the left).
 |          -1 (the default value) means no limit.
 |      
 |      Note, str.split() is mainly useful for data that has been intentionally
 |      delimited.  With natural text that includes punctuation, consider using
 |      the regular expression module.
 |  
 |  splitlines(self, /, keepends=False)
 |      Return a list of the lines in the string, breaking at line boundaries.
 |      
 |      Line breaks are not included in the resulting list unless keepends is given and
 |      true.
 |  
 |  startswith(...)
 |      S.startswith(prefix[, start[, end]]) -> bool
 |      
 |      Return True if S starts with the specified prefix, False otherwise.
 |      With optional start, test S beginning at that position.
 |      With optional end, stop comparing S at that position.
 |      prefix can also be a tuple of strings to try.
 |  
 |  strip(self, chars=None, /)
 |      Return a copy of the string with leading and trailing whitespace removed.
 |      
 |      If chars is given and not None, remove characters in chars instead.
 |  
 |  swapcase(self, /)
 |      Convert uppercase characters to lowercase and lowercase characters to uppercase.
 |  
 |  title(self, /)
 |      Return a version of the string where each word is titlecased.
 |      
 |      More specifically, words start with uppercased characters and all remaining
 |      cased characters have lower case.
 |  
 |  translate(self, table, /)
 |      Replace each character in the string using the given translation table.
 |      
 |        table
 |          Translation table, which must be a mapping of Unicode ordinals to
 |          Unicode ordinals, strings, or None.
 |      
 |      The table must implement lookup/indexing via __getitem__, for instance a
 |      dictionary or list.  If this operation raises LookupError, the character is
 |      left untouched.  Characters mapped to None are deleted.
 |  
 |  upper(self, /)
 |      Return a copy of the string converted to uppercase.
 |  
 |  zfill(self, width, /)
 |      Pad a numeric string with zeros on the left, to fill a field of the given width.
 |      
 |      The string is never truncated.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs) from builtins.type
 |      Create and return a new object.  See help(type) for accurate signature.
 |  
 |  maketrans(...)
 |      Return a translation table usable for str.translate().
 |      
 |      If there is only one argument, it must be a dictionary mapping Unicode
 |      ordinals (integers) or characters to Unicode ordinals, strings or None.
 |      Character keys will be then converted to ordinals.
 |      If there are two arguments, they must be strings of equal length, and
 |      in the resulting dictionary, each character in x will be mapped to the
 |      character at the same position in y. If there is a third argument, it
 |      must be a string, whose characters will be mapped to None in the result.
```

## StrictFloat

[go up](#Cheetsheet)

```hy
Name: StrictFloat
Kind: Reimport from [pydantic]
Info: will be still of float type, but will perform strict typecheck when variable is created
```

```hy
Help on _AnnotatedAlias in module builtins:

Annotated = class float(object)
 |  Annotated(x=0, /)
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

## StrictNumber

[go up](#Cheetsheet)

```hy
Name: StrictNumber
Kind: FPTK original
Info: Union of StrictInt and StrictFloat
```

## validate_call

[go up](#Cheetsheet)

```hy
Name: validate_call
Kind: Reimport from [pydantic]
Info: decorator for type-checking func args
```

```hy
Help on function validate_call in module pydantic.validate_call_decorator:

validate_call(func: 'AnyCallableT | None' = None, /, *, config: 'ConfigDict | None' = None, validate_return: 'bool' = False) -> 'AnyCallableT | Callable[[AnyCallableT], AnyCallableT]'
    !!! abstract "Usage Documentation"
        [Validation Decorator](../concepts/validation_decorator.md)
    
    Returns a decorated wrapper around the function that validates the arguments and, optionally, the return value.
    
    Usage may be either as a plain decorator `@validate_call` or with arguments `@validate_call(...)`.
    
    Args:
        func: The function to be decorated.
        config: The configuration dictionary.
        validate_return: Whether to validate the return value.
    
    Returns:
        The decorated function.
```

## validateF

[go up](#Cheetsheet)

```hy
Name: validateF
Kind: FPTK original
Info: same as validate_call but with option validate_return=True set (thus validating args and return type)
```

## inc

[go up](#Cheetsheet)

```hy
Name: inc
Kind: Reimport from [hyrule]
Sgnt: inc(n)
Info: = n + 1
```

```hy
Help on function inc in module hyrule.misc:

inc(n)
    Shorthand for ``(+ n 1)``. The name stands for "increment".
```

## dec

[go up](#Cheetsheet)

```hy
Name: dec
Kind: Reimport from [hyrule]
Sgnt: dec(n)
Info: = n - 1
```

```hy
Help on function dec in module hyrule.misc:

dec(n)
    Shorthand for ``(- n 1)``. The name stands for "decrement".
```

## sign

[go up](#Cheetsheet)

```hy
Name: sign
Kind: Reimport from [hyrule]
Sgnt: sign(n)
Info: will give 0 for n=0
```

```hy
Help on function sign in module hyrule.misc:

sign(x)
    Return -1 for negative ``x``, 1 for positive ``x``, and 0 for
    ``x`` equal to 0. The implementation is exactly ::
    
    
      (cond
        (< x 0) -1
        (> x 0)  1
        (= x 0)  0
        True     (raise TypeError))
    
    with the corresponding consequences for special cases like negative
    zero and NaN.
```

## neg

[go up](#Cheetsheet)

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

## floor

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## clip

[go up](#Cheetsheet)

```hy
Name: clip
Kind: FPTK original
Sgnt: clip(x, lower, upper)
Info: clips x to fit in lower <= x <= upper limit
```

```hy
Help on function clip in module fptk.mathnlogic:

clip(x, lower, upper)
    clips x to fit in lower <= x <= upper limit
```

## half

[go up](#Cheetsheet)

```hy
Name: half
Kind: FPTK original
Sgnt: half(x)
Info: = x/2
```

```hy
Help on function half in module fptk.mathnlogic:

half(x)
    half(x) = x / 2
```

## double

[go up](#Cheetsheet)

```hy
Name: double
Kind: FPTK original
Sgnt: double(x)
Info: = x*2
```

```hy
Help on function double in module fptk.mathnlogic:

double(x)
    double(x) = x * 2
```

## squared

[go up](#Cheetsheet)

```hy
Name: squared
Kind: FPTK original
Sgnt: squared(x)
Info: = pow(x,2)
```

```hy
Help on function squared in module fptk.mathnlogic:

squared(x)
    squared(x) = pow(x, 2)
```

## reciprocal

[go up](#Cheetsheet)

```hy
Name: reciprocal
Kind: FPTK original
Sgnt: reciprocal(x)
Info: = 1/x ; throws error for x=0
```

```hy
Help on function reciprocal in module fptk.mathnlogic:

reciprocal(x)
    reciprocal(x) = 1 / x
```

## sqrt

[go up](#Cheetsheet)

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

## dist

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: normalize
Kind: FPTK original
Sgnt: normalize(xs) -> xs
Info: will throw error for zero-len vector
```

```hy
Help on function normalize in module fptk.mathnlogic:

normalize(xs)
    devides each coord of vector to vectors norm,
    example: norm of [1, 2, 3] = sqrt(1 + 4 + 9) = sqrt(14) ~= 3.74,
    so will return [1/3.74, 2/3.74, 3/3.74]
    ---
    will throw error for norm == 0
```

## exp

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: ln
Kind: FPTK original
Sgnt: ln(x)
Info: = math.log(x, math.e) ; coexists with log for clarity
```

```hy
Help on function ln in module fptk.mathnlogic:

ln(x)
```

## log10

[go up](#Cheetsheet)

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

## evenQ

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: zeroQ
Kind: FPTK original
Sgnt: zeroQ(x)
Info: checks directly via (= x 0)
```

```hy
Help on function zeroQ in module fptk.mathnlogic:

zeroQ(x)
    checks literally if x == 0
```

## negativeQ

[go up](#Cheetsheet)

```hy
Name: negativeQ
Kind: FPTK original
Sgnt: negativeQ(x)
Info: checks directly via (< x 0)
```

```hy
Help on function negativeQ in module fptk.mathnlogic:

negativeQ(x)
    checks literally if x < 0
```

## positiveQ

[go up](#Cheetsheet)

```hy
Name: positiveQ
Kind: FPTK original
Sgnt: positiveQ(x)
Info: checks directly via (> x 0)
```

```hy
Help on function positiveQ in module fptk.mathnlogic:

positiveQ(x)
    checks literally if x > 0
```

## pi

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## and_

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## matmul

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## gt0

[go up](#Cheetsheet)

```hy
Name: gt0
Kind: FPTK original
Sgnt: gt0(x)
Info: checks for x > 0
```

```hy
Help on function gt0 in module fptk.mathnlogic:

gt0(x)
    checks for x > 0
```

## geq0

[go up](#Cheetsheet)

```hy
Name: geq0
Kind: FPTK original
Sgnt: geq0(x)
Info: x >= 0
```

```hy
Help on function geq0 in module fptk.mathnlogic:

geq0(x)
    checks for x >= 0
```

## lt0

[go up](#Cheetsheet)

```hy
Name: lt0
Kind: FPTK original
Sgnt: lt0(x)
Info: checks for x < 0
```

```hy
Help on function lt0 in module fptk.mathnlogic:

lt0(x)
    checks for x < 0
```

## leq0

[go up](#Cheetsheet)

```hy
Name: leq0
Kind: FPTK original
Sgnt: leq0(x)
Info: x <= 0
```

```hy
Help on function leq0 in module fptk.mathnlogic:

leq0(x)
    checks for x <= 0
```

## minus

[go up](#Cheetsheet)

```hy
Name: minus
Kind: FPTK original
Sgnt: minus(x, y) = x - y
```

```hy
Help on function minus in module fptk.mathnlogic:

minus(x, y)
    minux(x, y) = x - y
```

## dmul

[go up](#Cheetsheet)

```hy
Name: dmul
Kind: FPTK original
Sgnt: dmul(*args) = arg1 + arg2 + ...
Info: 'dunder mul', '*' operator as a function
```

```hy
Help on function dmul in module fptk.mathnlogic:

dmul(*args)
    dmul(a1, a2, ...) = a1 * a2 * ...
    dunder mul, '*' operator as a function
```

## dadd

[go up](#Cheetsheet)

```hy
Name: dadd
Kind: FPTK original
Sgnt: dadd(*args) = arg1 + arg2 + ...
Info: 'dunder add', '+' operator as a function
```

```hy
Help on function dadd in module fptk.mathnlogic:

dadd(*args)
    dadd(a1, a2, ...) = a1 + a2 + ...
    dunder add, '+' operator as a function
```

## lmul

[go up](#Cheetsheet)

```hy
Name: lmul
Kind: FPTK original
Sgnt: lmul(*args) = arg1 * arg2 * ...
Info: rename of * operator, underlines usage for list
```

```hy
Help on function lmul in module fptk.mathnlogic:

lmul(*args)
    lmul(list, n, ...) = list * n * ...
    rename of * operator, can be used to underline usage on list
```

## smul

[go up](#Cheetsheet)

```hy
Name: smul
Kind: FPTK original
Sgnt: smul(*args) = arg1 * arg2 * ...
Info: rename of * operator, underlines usage for string
```

```hy
Help on function smul in module fptk.mathnlogic:

smul(*args)
    smul(s, n, ...) = s * n * ...
    rename of * operator, can be used to underline usage on string
```

## mul

[go up](#Cheetsheet)

```hy
Name: mul
Kind: FPTK original
Sgnt: mul(*args)
Info: multiplication as a monoid (will not give error when used with 0 or 1 args)
```

```hy
Help on function mul in module fptk.mathnlogic:

mul(*args)
    mul(a1, a2, ...) = 1 * a1 * a2 * ...
    multiplication as a monoid with identity = 1,
    can be used with 0 or 1 arg
```

## plus

[go up](#Cheetsheet)

```hy
Name: plus
Kind: FPTK original
Sgnt: plus(*args)
Info: addition as a monoid (will not give error when used with 0 or 1 args)
```

```hy
Help on function plus in module fptk.mathnlogic:

plus(*args)
    plus(a1, a2, ...) = 0 + a1 + a2 + ...
    addition as a monoid with identity = 0
```

## sconcat

[go up](#Cheetsheet)

```hy
Name: sconcat
Kind: FPTK original
Sgnt: sconcat(*args)
Info: string concantenation as a monoid (will not give error when used with 0 or 1 args)
```

```hy
Help on function sconcat in module fptk.mathnlogic:

sconcat(*args)
    sconcat(s1, s2, ...) = '' + s1 + s2 + ...
    string concantenation as a monoid with identity = '',
    can be used with 0 or 1 args
```

## fnot

[go up](#Cheetsheet)

```hy
Name: fnot
Kind: FPTK original
Sgnt: fnot(f, *args, **kwargs)
Info: = not(f(*args, **kwargs))
```

```hy
Help on function fnot in module fptk.mathnlogic:

fnot(f, *args, **kwargs)
    fnot(f, *args, **kwargs) = not(f(*args, **kwargs))
```

## eq_any

[go up](#Cheetsheet)

```hy
Name: eq_any
Kind: FPTK original
Sgnt: eq_any(x, values)
Info: = (or (eq x value1) (eq x value2) ...)
```

```hy
Help on function eq_any in module fptk.mathnlogic:

eq_any(x, values)
    eq_any(x, [v1, v2, ...]) = or(eq(x, v1), eq(x, v2), ...)
```

## on

[go up](#Cheetsheet)

```hy
Name: on
Kind: FPTK original
Sgnt: on(f, check, x, y)
Info: example: (on len eq xs ys) -> (eq (len xs) (len yx))
```

```hy
Help on function on in module fptk.mathnlogic:

on(f, check, x, y)
    on(f, check, x, y) = check(f(x), f(y))
    inspired by Haskell's 'on' function
```

## all_fs

[go up](#Cheetsheet)

```hy
Name: all_fs
Kind: FPTK original
Sgnt: all_fs(fs, *args, **kwargs)
Info: checks if all f(*args, **kwargs) are True
```

```hy
Help on function all_fs in module fptk.mathnlogic:

all_fs(fs, *args, **kwargs)
    all_fs([f1, f2, ...], *args, **kwargs) = and(f1(*args, **kwargs), f2, ...)
```

## any_fs

[go up](#Cheetsheet)

```hy
Name: any_fs
Kind: FPTK original
Sgnt: any_fs(fs, *args, **kwargs)
Info: checks if any of f(*args, **kwargs) is True
```

```hy
Help on function any_fs in module fptk.mathnlogic:

any_fs(fs, *args, **kwargs)
    all_fs([f1, f2, ...], *args, **kwargs) = or(f1(*args, **kwargs), f2, ...)
```

## trueQ

[go up](#Cheetsheet)

```hy
Name: trueQ
Kind: FPTK original
Sgnt: trueQ(x)
Info: checks directly via (= x True)
```

```hy
Help on function trueQ in module fptk.mathnlogic:

trueQ(x)
    checks literally if x == True
```

## falseQ

[go up](#Cheetsheet)

```hy
Name: falseQ
Kind: FPTK original
Sgnt: falseQ(x)
Info: checks directly via (= x False)
```

```hy
Help on function falseQ in module fptk.mathnlogic:

falseQ(x)
    checks literally if x == False
```

## oflenQ

[go up](#Cheetsheet)

```hy
Name: oflenQ
Kind: FPTK original
Sgnt: oflenQ(n, xs)
Info: checks directly via (= (len xs) n)
```

```hy
Help on function oflenQ in module fptk.mathnlogic:

oflenQ(n, xs)
    checks literally if len(xs) == n
```

## zerolenQ

[go up](#Cheetsheet)

```hy
Name: zerolenQ
Kind: FPTK original
Sgnt: zerolenQ(xs)
Info: checks directly via (= (len xs) 0)
```

```hy
Help on function zerolenQ in module fptk.mathnlogic:

zerolenQ(xs)
    checks literally if len(xs) == 0
```

## choice

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

## strlen

[go up](#Cheetsheet)

```hy
Name: strlen
Kind: FPTK original
Sgnt: strlen(text)
Info: rename of len, underlines usage on strings
```

```hy
Help on function strlen in module fptk.strings:

strlen(text)
    rename of len, underlines usage on strings
```

## str_join

[go up](#Cheetsheet)

```hy
Name: str_join
Kind: FPTK original
Sgnt: str_join(ss, sep='')
Info: rearrangement of funcy.str_join, ss is seq of strings
```

```hy
Help on function str_join in module fptk.strings:

str_join(ss, sep='')
    str_join(['1', '2', '3'], '-') = '1-2-3'
```

## lowercase

[go up](#Cheetsheet)

```hy
Name: lowercase
Kind: FPTK original
Sgnt: lowercase(string)
Info: str.lower method as a function
```

```hy
Help on function lowercase in module fptk.strings:

lowercase(string: str) -> str
    str.lower method as a function
```

## strip

[go up](#Cheetsheet)

```hy
Name: strip
Kind: FPTK original
Sgnt: strip(string, chars=None)
Info: str.strip method as a function
```

```hy
Help on function strip in module fptk.strings:

strip(string: str, chars=None) -> str
    str.strip method as a function, 
    removes leading and trailing whitespaces (or chars when given)
```

## lstrip

[go up](#Cheetsheet)

```hy
Name: lstrip
Kind: FPTK original
Sgnt: lstrip(string, chars=None)
Info: str.lstrip method as a function
```

```hy
Help on function lstrip in module fptk.strings:

lstrip(string: str, chars=None) -> str
    str.lstrip method as a function
```

## rstrip

[go up](#Cheetsheet)

```hy
Name: rstrip
Kind: FPTK original
Sgnt: rstrip(string, chars=None)
Info: str.rstrip method as a function
```

```hy
Help on function rstrip in module fptk.strings:

rstrip(string: str, chars=None) -> str
    str.rstrip method as a function
```

## enlengthen

[go up](#Cheetsheet)

```hy
Name: enlengthen
Kind: FPTK original
Sgnt: enlengthen(string, target_len, char=' ', on_tail=True)
Info: adds char to string until target_len reached
```

```hy
Help on function enlengthen in module fptk.strings:

enlengthen(target_len: int, string: str, char: str = ' ', on_tail: bool = True, force_len: bool = False) -> str
    appends char to string until target_len reached
    
    - if len(string) > target_len, will return string with no change
    - with on_tail=False will prepend chars rather than append
    - with force_len=True will cut string to target_len if required (taking on_tail option into account)
    - when len(char)> 1 is given, repeats it's pattern, but still ensures target_len
```

## re_sub

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: re_all
Kind: Reimport from [funcy]
Sgnt: re_all(rpattern, string, ...) -> List
```

```hy
Help on function re_all in module funcy.strings:

re_all(regex, s, flags=0)
    Lists all matches of regex in s, presents them in simplest possible form
```

## file_existsQ

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

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

[go up](#Cheetsheet)

```hy
Name: read_file
Kind: FPTK original
Sgnt: read_file(file_name, encoding='utf-8') -> str
Info: returns whole file content
```

```hy
Help on function read_file in module fptk.IO:

read_file(file_name: str, encoding: str = 'utf-8')
    returns whole file content
```

## write_to_file

[go up](#Cheetsheet)

```hy
Name: write_to_file
Kind: FPTK original
Sgnt: write_file(text, file_name, mode='w', encoding='utf-8')
Info: modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation
```

```hy
Help on function write_to_file in module fptk.IO:

write_to_file(text: str, file_name: str, mode: str = 'w', encoding: str = 'utf-8')
    writes text to file_name;
    modes:
    - 'w' - (over)write
    - 'a' - append
    - 'x' - exclusive creation
    - ...
    - see more at help(open)
```

## lens

[go up](#Cheetsheet)

```hy
Name: lens
Kind: Reimport from [lenses]
Info: main object of lenses library (for working with immutable structures)
```

```hy
Help on UnboundLens in module lenses.ui:

UnboundLens(TrivialIso())
```

## lns

[go up](#Cheetsheet)

```hy
Name: lns
Kind: FPTK Macro
Info: macros for working with lens, see lens macros docs for details
```

## Lens operator1

[go up](#Cheetsheet)

```hy
Name: &+
Kind: FPTK Macro
Info: macros for working with lens, see lens macros docs for details
```

## Lens operator2

[go up](#Cheetsheet)

```hy
Name: &+>
Kind: FPTK Macro
Info: macros for working with lens, see lens macros docs for details
```

## Lens operator3

[go up](#Cheetsheet)

```hy
Name: l>
Kind: FPTK Macro
Info: macros for working with lens, see lens macros docs for details
```

## Lens operator4

[go up](#Cheetsheet)

```hy
Name: l>=
Kind: FPTK Macro
Info: macros for working with lens, see lens macros docs for details
```

## timing

[go up](#Cheetsheet)

```hy
Name: timing
Kind: FPTK Macro
Sgnt: (timing expr1 expr2 ...) -> #(float, Any)
Info: returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)
```

## dt_print

[go up](#Cheetsheet)

```hy
Name: dt_print
Kind: FPTK original
Sgnt: dt_printer(* args, fresh_run=False)
Info: starts timer on fresh run, prints time passed since previous call
```

```hy
Help on function dt_print in module fptk.benchmark:

dt_print(*args, fresh_run=False, last_T=[None])
    on first run, starts the timer (and print message that it started)
    on subsequent runs prints how many time (in seconds) have passed since previous call
    #
    call with fresh_run = True to reset timer
    #
    last_T should not be touched by user!
    it is used for storing time of previous run between runs
```

## assertm

[go up](#Cheetsheet)

```hy
Name: assertm
Kind: FPTK Macro
Sgnt: (assertm op arg1 arg2)
Info: tests if (op arg1 arg2), for example (= 1 1)
```

## gives_error_typeQ

[go up](#Cheetsheet)

```hy
Name: gives_error_typeQ
Kind: FPTK Macro
Info: example: (assertm gives_error_typeQ (get [1] 2) IndexError)
```

## Maybe

[go up](#Cheetsheet)

```hy
Name: Maybe
Kind: Reimport from [fptk.monads.maybeM]
Info: Maybe monad. Should be used in annotations only
```

```hy
Help on class Maybe in module fptk.monads.maybeM:

class Maybe(pydantic.main.BaseModel, typing.Generic)
 |  Maybe(*, container: Union[fptk.monads.maybeM._Just, fptk.monads.maybeM._Nothing]) -> None
 |  
 |  Method resolution order:
 |      Maybe
 |      pydantic.main.BaseModel
 |      typing.Generic
 |      builtins.object
 |  
 |  Methods defined here:
 |  
 |  __repr__(self)
 |      Return repr(self).
 |  
 |  __str__(self)
 |      Return str(self).
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |  
 |  __abstractmethods__ = frozenset()
 |  
 |  __annotations__ = {'container': typing.Union[fptk.monads.maybeM._Just,...
 |  
 |  __class_vars__ = set()
 |  
 |  __orig_bases__ = (<class 'pydantic.main.BaseModel'>, typing.Generic[~J...
 |  
 |  __parameters__ = (~J,)
 |  
 |  __private_attributes__ = {}
 |  
 |  __pydantic_complete__ = True
 |  
 |  __pydantic_computed_fields__ = {}
 |  
 |  __pydantic_core_schema__ = {'cls': <class 'fptk.monads.maybeM.Maybe'>,...
 |  
 |  __pydantic_custom_init__ = False
 |  
 |  __pydantic_decorators__ = DecoratorInfos(validators={}, field_validato...
 |  
 |  __pydantic_fields__ = {'container': FieldInfo(annotation=Union[_Just, ...
 |  
 |  __pydantic_generic_metadata__ = {'args': (), 'origin': None, 'paramete...
 |  
 |  __pydantic_parent_namespace__ = None
 |  
 |  __pydantic_post_init__ = None
 |  
 |  __pydantic_serializer__ = SchemaSerializer(serializer=Model(
 |      Model...
 |  
 |  __pydantic_setattr_handlers__ = {}
 |  
 |  __pydantic_validator__ = SchemaValidator(title="Maybe", validator=Mode...
 |  
 |  __signature__ = <Signature (*, container: Union[fptk.monads.maybeM._Ju...
 |  
 |  model_config = {}
 |  
 |  ----------------------------------------------------------------------
 |  Methods inherited from pydantic.main.BaseModel:
 |  
 |  __copy__(self) -> 'Self'
 |      Returns a shallow copy of the model.
 |  
 |  __deepcopy__(self, memo: 'dict[int, Any] | None' = None) -> 'Self'
 |      Returns a deep copy of the model.
 |  
 |  __delattr__(self, item: 'str') -> 'Any'
 |      Implement delattr(self, name).
 |  
 |  __eq__(self, other: 'Any') -> 'bool'
 |      Return self==value.
 |  
 |  __getattr__(self, item: 'str') -> 'Any'
 |  
 |  __getstate__(self) -> 'dict[Any, Any]'
 |  
 |  __init__(self, /, **data: 'Any') -> 'None'
 |      Create a new model by parsing and validating input data from keyword arguments.
 |      
 |      Raises [`ValidationError`][pydantic_core.ValidationError] if the input data cannot be
 |      validated to form a valid model.
 |      
 |      `self` is explicitly positional-only to allow `self` as a field name.
 |  
 |  __iter__(self) -> 'TupleGenerator'
 |      So `dict(model)` works.
 |  
 |  __pretty__(self, fmt: 'Callable[[Any], Any]', **kwargs: 'Any') -> 'Generator[Any]'
 |      Used by devtools (https://python-devtools.helpmanual.io/) to pretty print objects.
 |  
 |  __replace__(self, **changes: 'Any') -> 'Self'
 |      # Because we make use of `@dataclass_transform()`, `__replace__` is already synthesized by
 |      # type checkers, so we define the implementation in this `if not TYPE_CHECKING:` block:
 |  
 |  __repr_args__(self) -> '_repr.ReprArgs'
 |  
 |  __repr_name__(self) -> 'str'
 |      Name of the instance's class, used in __repr__.
 |  
 |  __repr_recursion__(self, object: 'Any') -> 'str'
 |      Returns the string representation of a recursive object.
 |  
 |  __repr_str__(self, join_str: 'str') -> 'str'
 |  
 |  __rich_repr__(self) -> 'RichReprResult'
 |      Used by Rich (https://rich.readthedocs.io/en/stable/pretty.html) to pretty print objects.
 |  
 |  __setattr__(self, name: 'str', value: 'Any') -> 'None'
 |      Implement setattr(self, name, value).
 |  
 |  __setstate__(self, state: 'dict[Any, Any]') -> 'None'
 |  
 |  copy(self, *, include: 'AbstractSetIntStr | MappingIntStrAny | None' = None, exclude: 'AbstractSetIntStr | MappingIntStrAny | None' = None, update: 'Dict[str, Any] | None' = None, deep: 'bool' = False) -> 'Self'
 |      Returns a copy of the model.
 |      
 |      !!! warning "Deprecated"
 |          This method is now deprecated; use `model_copy` instead.
 |      
 |      If you need `include` or `exclude`, use:
 |      
 |      ```python {test="skip" lint="skip"}
 |      data = self.model_dump(include=include, exclude=exclude, round_trip=True)
 |      data = {**data, **(update or {})}
 |      copied = self.model_validate(data)
 |      ```
 |      
 |      Args:
 |          include: Optional set or mapping specifying which fields to include in the copied model.
 |          exclude: Optional set or mapping specifying which fields to exclude in the copied model.
 |          update: Optional dictionary of field-value pairs to override field values in the copied model.
 |          deep: If True, the values of fields that are Pydantic models will be deep-copied.
 |      
 |      Returns:
 |          A copy of the model with included, excluded and updated fields as specified.
 |  
 |  dict(self, *, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, by_alias: 'bool' = False, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False) -> 'Dict[str, Any]'
 |  
 |  json(self, *, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, by_alias: 'bool' = False, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, encoder: 'Callable[[Any], Any] | None' = PydanticUndefined, models_as_dict: 'bool' = PydanticUndefined, **dumps_kwargs: 'Any') -> 'str'
 |  
 |  model_copy(self, *, update: 'Mapping[str, Any] | None' = None, deep: 'bool' = False) -> 'Self'
 |      !!! abstract "Usage Documentation"
 |          [`model_copy`](../concepts/models.md#model-copy)
 |      
 |      Returns a copy of the model.
 |      
 |      !!! note
 |          The underlying instance's [`__dict__`][object.__dict__] attribute is copied. This
 |          might have unexpected side effects if you store anything in it, on top of the model
 |          fields (e.g. the value of [cached properties][functools.cached_property]).
 |      
 |      Args:
 |          update: Values to change/add in the new model. Note: the data is not validated
 |              before creating the new model. You should trust this data.
 |          deep: Set to `True` to make a deep copy of the model.
 |      
 |      Returns:
 |          New model instance.
 |  
 |  model_dump(self, *, mode: "Literal['json', 'python'] | str" = 'python', include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, exclude_computed_fields: 'bool' = False, round_trip: 'bool' = False, warnings: "bool | Literal['none', 'warn', 'error']" = True, fallback: 'Callable[[Any], Any] | None' = None, serialize_as_any: 'bool' = False) -> 'dict[str, Any]'
 |      !!! abstract "Usage Documentation"
 |          [`model_dump`](../concepts/serialization.md#python-mode)
 |      
 |      Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.
 |      
 |      Args:
 |          mode: The mode in which `to_python` should run.
 |              If mode is 'json', the output will only contain JSON serializable types.
 |              If mode is 'python', the output may contain non-JSON-serializable Python objects.
 |          include: A set of fields to include in the output.
 |          exclude: A set of fields to exclude from the output.
 |          context: Additional context to pass to the serializer.
 |          by_alias: Whether to use the field's alias in the dictionary key if defined.
 |          exclude_unset: Whether to exclude fields that have not been explicitly set.
 |          exclude_defaults: Whether to exclude fields that are set to their default value.
 |          exclude_none: Whether to exclude fields that have a value of `None`.
 |          exclude_computed_fields: Whether to exclude computed fields.
 |              While this can be useful for round-tripping, it is usually recommended to use the dedicated
 |              `round_trip` parameter instead.
 |          round_trip: If True, dumped values should be valid as input for non-idempotent types such as Json[T].
 |          warnings: How to handle serialization errors. False/"none" ignores them, True/"warn" logs errors,
 |              "error" raises a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError].
 |          fallback: A function to call when an unknown value is encountered. If not provided,
 |              a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError] error is raised.
 |          serialize_as_any: Whether to serialize fields with duck-typing serialization behavior.
 |      
 |      Returns:
 |          A dictionary representation of the model.
 |  
 |  model_dump_json(self, *, indent: 'int | None' = None, ensure_ascii: 'bool' = False, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, exclude_computed_fields: 'bool' = False, round_trip: 'bool' = False, warnings: "bool | Literal['none', 'warn', 'error']" = True, fallback: 'Callable[[Any], Any] | None' = None, serialize_as_any: 'bool' = False) -> 'str'
 |      !!! abstract "Usage Documentation"
 |          [`model_dump_json`](../concepts/serialization.md#json-mode)
 |      
 |      Generates a JSON representation of the model using Pydantic's `to_json` method.
 |      
 |      Args:
 |          indent: Indentation to use in the JSON output. If None is passed, the output will be compact.
 |          ensure_ascii: If `True`, the output is guaranteed to have all incoming non-ASCII characters escaped.
 |              If `False` (the default), these characters will be output as-is.
 |          include: Field(s) to include in the JSON output.
 |          exclude: Field(s) to exclude from the JSON output.
 |          context: Additional context to pass to the serializer.
 |          by_alias: Whether to serialize using field aliases.
 |          exclude_unset: Whether to exclude fields that have not been explicitly set.
 |          exclude_defaults: Whether to exclude fields that are set to their default value.
 |          exclude_none: Whether to exclude fields that have a value of `None`.
 |          exclude_computed_fields: Whether to exclude computed fields.
 |              While this can be useful for round-tripping, it is usually recommended to use the dedicated
 |              `round_trip` parameter instead.
 |          round_trip: If True, dumped values should be valid as input for non-idempotent types such as Json[T].
 |          warnings: How to handle serialization errors. False/"none" ignores them, True/"warn" logs errors,
 |              "error" raises a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError].
 |          fallback: A function to call when an unknown value is encountered. If not provided,
 |              a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError] error is raised.
 |          serialize_as_any: Whether to serialize fields with duck-typing serialization behavior.
 |      
 |      Returns:
 |          A JSON string representation of the model.
 |  
 |  model_post_init(self, context: 'Any', /) -> 'None'
 |      Override this method to perform additional initialization after `__init__` and `model_construct`.
 |      This is useful if you want to do some validation that requires the entire model to be initialized.
 |  
 |  ----------------------------------------------------------------------
 |  Class methods inherited from pydantic.main.BaseModel:
 |  
 |  __class_getitem__(typevar_values: 'type[Any] | tuple[type[Any], ...]') -> 'type[BaseModel] | _forward_ref.PydanticRecursiveRef' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  __get_pydantic_core_schema__(source: 'type[BaseModel]', handler: 'GetCoreSchemaHandler', /) -> 'CoreSchema' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  __get_pydantic_json_schema__(core_schema: 'CoreSchema', handler: 'GetJsonSchemaHandler', /) -> 'JsonSchemaValue' from pydantic._internal._model_construction.ModelMetaclass
 |      Hook into generating the model's JSON schema.
 |      
 |      Args:
 |          core_schema: A `pydantic-core` CoreSchema.
 |              You can ignore this argument and call the handler with a new CoreSchema,
 |              wrap this CoreSchema (`{'type': 'nullable', 'schema': current_schema}`),
 |              or just call the handler with the original schema.
 |          handler: Call into Pydantic's internal JSON schema generation.
 |              This will raise a `pydantic.errors.PydanticInvalidForJsonSchema` if JSON schema
 |              generation fails.
 |              Since this gets called by `BaseModel.model_json_schema` you can override the
 |              `schema_generator` argument to that function to change JSON schema generation globally
 |              for a type.
 |      
 |      Returns:
 |          A JSON schema, as a Python object.
 |  
 |  __pydantic_init_subclass__(**kwargs: 'Any') -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |      This is intended to behave just like `__init_subclass__`, but is called by `ModelMetaclass`
 |      only after basic class initialization is complete. In particular, attributes like `model_fields` will
 |      be present when this is called, but forward annotations are not guaranteed to be resolved yet,
 |      meaning that creating an instance of the class may fail.
 |      
 |      This is necessary because `__init_subclass__` will always be called by `type.__new__`,
 |      and it would require a prohibitively large refactor to the `ModelMetaclass` to ensure that
 |      `type.__new__` was called in such a manner that the class would already be sufficiently initialized.
 |      
 |      This will receive the same `kwargs` that would be passed to the standard `__init_subclass__`, namely,
 |      any kwargs passed to the class definition that aren't used internally by Pydantic.
 |      
 |      Args:
 |          **kwargs: Any keyword arguments passed to the class definition that aren't used internally
 |              by Pydantic.
 |      
 |      Note:
 |          You may want to override [`__pydantic_on_complete__()`][pydantic.main.BaseModel.__pydantic_on_complete__]
 |          instead, which is called once the class and its fields are fully initialized and ready for validation.
 |  
 |  __pydantic_on_complete__() -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |      This is called once the class and its fields are fully initialized and ready to be used.
 |      
 |      This typically happens when the class is created (just before
 |      [`__pydantic_init_subclass__()`][pydantic.main.BaseModel.__pydantic_init_subclass__] is called on the superclass),
 |      except when forward annotations are used that could not immediately be resolved.
 |      In that case, it will be called later, when the model is rebuilt automatically or explicitly using
 |      [`model_rebuild()`][pydantic.main.BaseModel.model_rebuild].
 |  
 |  construct(_fields_set: 'set[str] | None' = None, **values: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  from_orm(obj: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  model_construct(_fields_set: 'set[str] | None' = None, **values: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Creates a new instance of the `Model` class with validated data.
 |      
 |      Creates a new model setting `__dict__` and `__pydantic_fields_set__` from trusted or pre-validated data.
 |      Default values are respected, but no other validation is performed.
 |      
 |      !!! note
 |          `model_construct()` generally respects the `model_config.extra` setting on the provided model.
 |          That is, if `model_config.extra == 'allow'`, then all extra passed values are added to the model instance's `__dict__`
 |          and `__pydantic_extra__` fields. If `model_config.extra == 'ignore'` (the default), then all extra passed values are ignored.
 |          Because no validation is performed with a call to `model_construct()`, having `model_config.extra == 'forbid'` does not result in
 |          an error if extra values are passed, but they will be ignored.
 |      
 |      Args:
 |          _fields_set: A set of field names that were originally explicitly set during instantiation. If provided,
 |              this is directly used for the [`model_fields_set`][pydantic.BaseModel.model_fields_set] attribute.
 |              Otherwise, the field names from the `values` argument will be used.
 |          values: Trusted or pre-validated data dictionary.
 |      
 |      Returns:
 |          A new instance of the `Model` class with validated data.
 |  
 |  model_json_schema(by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}', schema_generator: 'type[GenerateJsonSchema]' = <class 'pydantic.json_schema.GenerateJsonSchema'>, mode: 'JsonSchemaMode' = 'validation', *, union_format: "Literal['any_of', 'primitive_type_array']" = 'any_of') -> 'dict[str, Any]' from pydantic._internal._model_construction.ModelMetaclass
 |      Generates a JSON schema for a model class.
 |      
 |      Args:
 |          by_alias: Whether to use attribute aliases or not.
 |          ref_template: The reference template.
 |          union_format: The format to use when combining schemas from unions together. Can be one of:
 |      
 |              - `'any_of'`: Use the [`anyOf`](https://json-schema.org/understanding-json-schema/reference/combining#anyOf)
 |              keyword to combine schemas (the default).
 |              - `'primitive_type_array'`: Use the [`type`](https://json-schema.org/understanding-json-schema/reference/type)
 |              keyword as an array of strings, containing each type of the combination. If any of the schemas is not a primitive
 |              type (`string`, `boolean`, `null`, `integer` or `number`) or contains constraints/metadata, falls back to
 |              `any_of`.
 |          schema_generator: To override the logic used to generate the JSON schema, as a subclass of
 |              `GenerateJsonSchema` with your desired modifications
 |          mode: The mode in which to generate the schema.
 |      
 |      Returns:
 |          The JSON schema for the given model class.
 |  
 |  model_parametrized_name(params: 'tuple[type[Any], ...]') -> 'str' from pydantic._internal._model_construction.ModelMetaclass
 |      Compute the class name for parametrizations of generic classes.
 |      
 |      This method can be overridden to achieve a custom naming scheme for generic BaseModels.
 |      
 |      Args:
 |          params: Tuple of types of the class. Given a generic class
 |              `Model` with 2 type variables and a concrete model `Model[str, int]`,
 |              the value `(str, int)` would be passed to `params`.
 |      
 |      Returns:
 |          String representing the new class where `params` are passed to `cls` as type variables.
 |      
 |      Raises:
 |          TypeError: Raised when trying to generate concrete names for non-generic models.
 |  
 |  model_rebuild(*, force: 'bool' = False, raise_errors: 'bool' = True, _parent_namespace_depth: 'int' = 2, _types_namespace: 'MappingNamespace | None' = None) -> 'bool | None' from pydantic._internal._model_construction.ModelMetaclass
 |      Try to rebuild the pydantic-core schema for the model.
 |      
 |      This may be necessary when one of the annotations is a ForwardRef which could not be resolved during
 |      the initial attempt to build the schema, and automatic rebuilding fails.
 |      
 |      Args:
 |          force: Whether to force the rebuilding of the model schema, defaults to `False`.
 |          raise_errors: Whether to raise errors, defaults to `True`.
 |          _parent_namespace_depth: The depth level of the parent namespace, defaults to 2.
 |          _types_namespace: The types namespace, defaults to `None`.
 |      
 |      Returns:
 |          Returns `None` if the schema is already "complete" and rebuilding was not required.
 |          If rebuilding _was_ required, returns `True` if rebuilding was successful, otherwise `False`.
 |  
 |  model_validate(obj: 'Any', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, from_attributes: 'bool | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Validate a pydantic model instance.
 |      
 |      Args:
 |          obj: The object to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          from_attributes: Whether to extract data from object attributes.
 |          context: Additional context to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Raises:
 |          ValidationError: If the object could not be validated.
 |      
 |      Returns:
 |          The validated model instance.
 |  
 |  model_validate_json(json_data: 'str | bytes | bytearray', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      !!! abstract "Usage Documentation"
 |          [JSON Parsing](../concepts/json.md#json-parsing)
 |      
 |      Validate the given JSON data against the Pydantic model.
 |      
 |      Args:
 |          json_data: The JSON data to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          context: Extra variables to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Returns:
 |          The validated Pydantic model.
 |      
 |      Raises:
 |          ValidationError: If `json_data` is not a JSON string or the object could not be validated.
 |  
 |  model_validate_strings(obj: 'Any', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Validate the given object with string data against the Pydantic model.
 |      
 |      Args:
 |          obj: The object containing string data to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          context: Extra variables to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Returns:
 |          The validated Pydantic model.
 |  
 |  parse_file(path: 'str | Path', *, content_type: 'str | None' = None, encoding: 'str' = 'utf8', proto: 'DeprecatedParseProtocol | None' = None, allow_pickle: 'bool' = False) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  parse_obj(obj: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  parse_raw(b: 'str | bytes', *, content_type: 'str | None' = None, encoding: 'str' = 'utf8', proto: 'DeprecatedParseProtocol | None' = None, allow_pickle: 'bool' = False) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  schema(by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}') -> 'Dict[str, Any]' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  schema_json(*, by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}', **dumps_kwargs: 'Any') -> 'str' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  update_forward_refs(**localns: 'Any') -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  validate(value: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  ----------------------------------------------------------------------
 |  Readonly properties inherited from pydantic.main.BaseModel:
 |  
 |  __fields_set__
 |  
 |  model_extra
 |      Get extra fields set during validation.
 |      
 |      Returns:
 |          A dictionary of extra fields, or `None` if `config.extra` is not set to `"allow"`.
 |  
 |  model_fields_set
 |      Returns the set of fields that have been explicitly set on this model instance.
 |      
 |      Returns:
 |          A set of strings representing the fields that have been set,
 |              i.e. that were not filled from defaults.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from pydantic.main.BaseModel:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __pydantic_extra__
 |  
 |  __pydantic_fields_set__
 |  
 |  __pydantic_private__
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes inherited from pydantic.main.BaseModel:
 |  
 |  __hash__ = None
 |  
 |  __pydantic_root_model__ = False
 |  
 |  model_computed_fields = {}
 |  
 |  model_fields = {'container': FieldInfo(annotation=Union[_Just, _Nothin...
 |  
 |  ----------------------------------------------------------------------
 |  Class methods inherited from typing.Generic:
 |  
 |  __init_subclass__(*args, **kwargs) from pydantic._internal._model_construction.ModelMetaclass
 |      This method is called when a class is subclassed.
 |      
 |      The default implementation does nothing. It may be
 |      overridden to extend subclasses.
```

## Just

[go up](#Cheetsheet)

```hy
Name: Just
Kind: Reimport from [fptk.monads.maybeM]
Info: Just container of Maybe monad
```

```hy
Help on function Just in module fptk.monads.maybeM:

Just(value)
```

## Nothing

[go up](#Cheetsheet)

```hy
Name: Nothing
Kind: Reimport from [fptk.monads.maybeM]
Info: Nothing of Maybe monad
```

```hy
Help on Maybe in module fptk.monads.maybeM object:

class Maybe(pydantic.main.BaseModel, typing.Generic)
 |  Maybe(*, container: Union[fptk.monads.maybeM._Just, fptk.monads.maybeM._Nothing]) -> None
 |  
 |  Method resolution order:
 |      Maybe
 |      pydantic.main.BaseModel
 |      typing.Generic
 |      builtins.object
 |  
 |  Methods defined here:
 |  
 |  __repr__(self)
 |      Return repr(self).
 |  
 |  __str__(self)
 |      Return str(self).
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |  
 |  __abstractmethods__ = frozenset()
 |  
 |  __annotations__ = {'container': typing.Union[fptk.monads.maybeM._Just,...
 |  
 |  __class_vars__ = set()
 |  
 |  __orig_bases__ = (<class 'pydantic.main.BaseModel'>, typing.Generic[~J...
 |  
 |  __parameters__ = (~J,)
 |  
 |  __private_attributes__ = {}
 |  
 |  __pydantic_complete__ = True
 |  
 |  __pydantic_computed_fields__ = {}
 |  
 |  __pydantic_core_schema__ = {'cls': <class 'fptk.monads.maybeM.Maybe'>,...
 |  
 |  __pydantic_custom_init__ = False
 |  
 |  __pydantic_decorators__ = DecoratorInfos(validators={}, field_validato...
 |  
 |  __pydantic_fields__ = {'container': FieldInfo(annotation=Union[_Just, ...
 |  
 |  __pydantic_generic_metadata__ = {'args': (), 'origin': None, 'paramete...
 |  
 |  __pydantic_parent_namespace__ = None
 |  
 |  __pydantic_post_init__ = None
 |  
 |  __pydantic_serializer__ = SchemaSerializer(serializer=Model(
 |      Model...
 |  
 |  __pydantic_setattr_handlers__ = {}
 |  
 |  __pydantic_validator__ = SchemaValidator(title="Maybe", validator=Mode...
 |  
 |  __signature__ = <Signature (*, container: Union[fptk.monads.maybeM._Ju...
 |  
 |  model_config = {}
 |  
 |  ----------------------------------------------------------------------
 |  Methods inherited from pydantic.main.BaseModel:
 |  
 |  __copy__(self) -> 'Self'
 |      Returns a shallow copy of the model.
 |  
 |  __deepcopy__(self, memo: 'dict[int, Any] | None' = None) -> 'Self'
 |      Returns a deep copy of the model.
 |  
 |  __delattr__(self, item: 'str') -> 'Any'
 |      Implement delattr(self, name).
 |  
 |  __eq__(self, other: 'Any') -> 'bool'
 |      Return self==value.
 |  
 |  __getattr__(self, item: 'str') -> 'Any'
 |  
 |  __getstate__(self) -> 'dict[Any, Any]'
 |  
 |  __init__(self, /, **data: 'Any') -> 'None'
 |      Create a new model by parsing and validating input data from keyword arguments.
 |      
 |      Raises [`ValidationError`][pydantic_core.ValidationError] if the input data cannot be
 |      validated to form a valid model.
 |      
 |      `self` is explicitly positional-only to allow `self` as a field name.
 |  
 |  __iter__(self) -> 'TupleGenerator'
 |      So `dict(model)` works.
 |  
 |  __pretty__(self, fmt: 'Callable[[Any], Any]', **kwargs: 'Any') -> 'Generator[Any]'
 |      Used by devtools (https://python-devtools.helpmanual.io/) to pretty print objects.
 |  
 |  __replace__(self, **changes: 'Any') -> 'Self'
 |      # Because we make use of `@dataclass_transform()`, `__replace__` is already synthesized by
 |      # type checkers, so we define the implementation in this `if not TYPE_CHECKING:` block:
 |  
 |  __repr_args__(self) -> '_repr.ReprArgs'
 |  
 |  __repr_name__(self) -> 'str'
 |      Name of the instance's class, used in __repr__.
 |  
 |  __repr_recursion__(self, object: 'Any') -> 'str'
 |      Returns the string representation of a recursive object.
 |  
 |  __repr_str__(self, join_str: 'str') -> 'str'
 |  
 |  __rich_repr__(self) -> 'RichReprResult'
 |      Used by Rich (https://rich.readthedocs.io/en/stable/pretty.html) to pretty print objects.
 |  
 |  __setattr__(self, name: 'str', value: 'Any') -> 'None'
 |      Implement setattr(self, name, value).
 |  
 |  __setstate__(self, state: 'dict[Any, Any]') -> 'None'
 |  
 |  copy(self, *, include: 'AbstractSetIntStr | MappingIntStrAny | None' = None, exclude: 'AbstractSetIntStr | MappingIntStrAny | None' = None, update: 'Dict[str, Any] | None' = None, deep: 'bool' = False) -> 'Self'
 |      Returns a copy of the model.
 |      
 |      !!! warning "Deprecated"
 |          This method is now deprecated; use `model_copy` instead.
 |      
 |      If you need `include` or `exclude`, use:
 |      
 |      ```python {test="skip" lint="skip"}
 |      data = self.model_dump(include=include, exclude=exclude, round_trip=True)
 |      data = {**data, **(update or {})}
 |      copied = self.model_validate(data)
 |      ```
 |      
 |      Args:
 |          include: Optional set or mapping specifying which fields to include in the copied model.
 |          exclude: Optional set or mapping specifying which fields to exclude in the copied model.
 |          update: Optional dictionary of field-value pairs to override field values in the copied model.
 |          deep: If True, the values of fields that are Pydantic models will be deep-copied.
 |      
 |      Returns:
 |          A copy of the model with included, excluded and updated fields as specified.
 |  
 |  dict(self, *, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, by_alias: 'bool' = False, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False) -> 'Dict[str, Any]'
 |  
 |  json(self, *, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, by_alias: 'bool' = False, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, encoder: 'Callable[[Any], Any] | None' = PydanticUndefined, models_as_dict: 'bool' = PydanticUndefined, **dumps_kwargs: 'Any') -> 'str'
 |  
 |  model_copy(self, *, update: 'Mapping[str, Any] | None' = None, deep: 'bool' = False) -> 'Self'
 |      !!! abstract "Usage Documentation"
 |          [`model_copy`](../concepts/models.md#model-copy)
 |      
 |      Returns a copy of the model.
 |      
 |      !!! note
 |          The underlying instance's [`__dict__`][object.__dict__] attribute is copied. This
 |          might have unexpected side effects if you store anything in it, on top of the model
 |          fields (e.g. the value of [cached properties][functools.cached_property]).
 |      
 |      Args:
 |          update: Values to change/add in the new model. Note: the data is not validated
 |              before creating the new model. You should trust this data.
 |          deep: Set to `True` to make a deep copy of the model.
 |      
 |      Returns:
 |          New model instance.
 |  
 |  model_dump(self, *, mode: "Literal['json', 'python'] | str" = 'python', include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, exclude_computed_fields: 'bool' = False, round_trip: 'bool' = False, warnings: "bool | Literal['none', 'warn', 'error']" = True, fallback: 'Callable[[Any], Any] | None' = None, serialize_as_any: 'bool' = False) -> 'dict[str, Any]'
 |      !!! abstract "Usage Documentation"
 |          [`model_dump`](../concepts/serialization.md#python-mode)
 |      
 |      Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.
 |      
 |      Args:
 |          mode: The mode in which `to_python` should run.
 |              If mode is 'json', the output will only contain JSON serializable types.
 |              If mode is 'python', the output may contain non-JSON-serializable Python objects.
 |          include: A set of fields to include in the output.
 |          exclude: A set of fields to exclude from the output.
 |          context: Additional context to pass to the serializer.
 |          by_alias: Whether to use the field's alias in the dictionary key if defined.
 |          exclude_unset: Whether to exclude fields that have not been explicitly set.
 |          exclude_defaults: Whether to exclude fields that are set to their default value.
 |          exclude_none: Whether to exclude fields that have a value of `None`.
 |          exclude_computed_fields: Whether to exclude computed fields.
 |              While this can be useful for round-tripping, it is usually recommended to use the dedicated
 |              `round_trip` parameter instead.
 |          round_trip: If True, dumped values should be valid as input for non-idempotent types such as Json[T].
 |          warnings: How to handle serialization errors. False/"none" ignores them, True/"warn" logs errors,
 |              "error" raises a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError].
 |          fallback: A function to call when an unknown value is encountered. If not provided,
 |              a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError] error is raised.
 |          serialize_as_any: Whether to serialize fields with duck-typing serialization behavior.
 |      
 |      Returns:
 |          A dictionary representation of the model.
 |  
 |  model_dump_json(self, *, indent: 'int | None' = None, ensure_ascii: 'bool' = False, include: 'IncEx | None' = None, exclude: 'IncEx | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, exclude_unset: 'bool' = False, exclude_defaults: 'bool' = False, exclude_none: 'bool' = False, exclude_computed_fields: 'bool' = False, round_trip: 'bool' = False, warnings: "bool | Literal['none', 'warn', 'error']" = True, fallback: 'Callable[[Any], Any] | None' = None, serialize_as_any: 'bool' = False) -> 'str'
 |      !!! abstract "Usage Documentation"
 |          [`model_dump_json`](../concepts/serialization.md#json-mode)
 |      
 |      Generates a JSON representation of the model using Pydantic's `to_json` method.
 |      
 |      Args:
 |          indent: Indentation to use in the JSON output. If None is passed, the output will be compact.
 |          ensure_ascii: If `True`, the output is guaranteed to have all incoming non-ASCII characters escaped.
 |              If `False` (the default), these characters will be output as-is.
 |          include: Field(s) to include in the JSON output.
 |          exclude: Field(s) to exclude from the JSON output.
 |          context: Additional context to pass to the serializer.
 |          by_alias: Whether to serialize using field aliases.
 |          exclude_unset: Whether to exclude fields that have not been explicitly set.
 |          exclude_defaults: Whether to exclude fields that are set to their default value.
 |          exclude_none: Whether to exclude fields that have a value of `None`.
 |          exclude_computed_fields: Whether to exclude computed fields.
 |              While this can be useful for round-tripping, it is usually recommended to use the dedicated
 |              `round_trip` parameter instead.
 |          round_trip: If True, dumped values should be valid as input for non-idempotent types such as Json[T].
 |          warnings: How to handle serialization errors. False/"none" ignores them, True/"warn" logs errors,
 |              "error" raises a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError].
 |          fallback: A function to call when an unknown value is encountered. If not provided,
 |              a [`PydanticSerializationError`][pydantic_core.PydanticSerializationError] error is raised.
 |          serialize_as_any: Whether to serialize fields with duck-typing serialization behavior.
 |      
 |      Returns:
 |          A JSON string representation of the model.
 |  
 |  model_post_init(self, context: 'Any', /) -> 'None'
 |      Override this method to perform additional initialization after `__init__` and `model_construct`.
 |      This is useful if you want to do some validation that requires the entire model to be initialized.
 |  
 |  ----------------------------------------------------------------------
 |  Class methods inherited from pydantic.main.BaseModel:
 |  
 |  __class_getitem__(typevar_values: 'type[Any] | tuple[type[Any], ...]') -> 'type[BaseModel] | _forward_ref.PydanticRecursiveRef' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  __get_pydantic_core_schema__(source: 'type[BaseModel]', handler: 'GetCoreSchemaHandler', /) -> 'CoreSchema' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  __get_pydantic_json_schema__(core_schema: 'CoreSchema', handler: 'GetJsonSchemaHandler', /) -> 'JsonSchemaValue' from pydantic._internal._model_construction.ModelMetaclass
 |      Hook into generating the model's JSON schema.
 |      
 |      Args:
 |          core_schema: A `pydantic-core` CoreSchema.
 |              You can ignore this argument and call the handler with a new CoreSchema,
 |              wrap this CoreSchema (`{'type': 'nullable', 'schema': current_schema}`),
 |              or just call the handler with the original schema.
 |          handler: Call into Pydantic's internal JSON schema generation.
 |              This will raise a `pydantic.errors.PydanticInvalidForJsonSchema` if JSON schema
 |              generation fails.
 |              Since this gets called by `BaseModel.model_json_schema` you can override the
 |              `schema_generator` argument to that function to change JSON schema generation globally
 |              for a type.
 |      
 |      Returns:
 |          A JSON schema, as a Python object.
 |  
 |  __pydantic_init_subclass__(**kwargs: 'Any') -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |      This is intended to behave just like `__init_subclass__`, but is called by `ModelMetaclass`
 |      only after basic class initialization is complete. In particular, attributes like `model_fields` will
 |      be present when this is called, but forward annotations are not guaranteed to be resolved yet,
 |      meaning that creating an instance of the class may fail.
 |      
 |      This is necessary because `__init_subclass__` will always be called by `type.__new__`,
 |      and it would require a prohibitively large refactor to the `ModelMetaclass` to ensure that
 |      `type.__new__` was called in such a manner that the class would already be sufficiently initialized.
 |      
 |      This will receive the same `kwargs` that would be passed to the standard `__init_subclass__`, namely,
 |      any kwargs passed to the class definition that aren't used internally by Pydantic.
 |      
 |      Args:
 |          **kwargs: Any keyword arguments passed to the class definition that aren't used internally
 |              by Pydantic.
 |      
 |      Note:
 |          You may want to override [`__pydantic_on_complete__()`][pydantic.main.BaseModel.__pydantic_on_complete__]
 |          instead, which is called once the class and its fields are fully initialized and ready for validation.
 |  
 |  __pydantic_on_complete__() -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |      This is called once the class and its fields are fully initialized and ready to be used.
 |      
 |      This typically happens when the class is created (just before
 |      [`__pydantic_init_subclass__()`][pydantic.main.BaseModel.__pydantic_init_subclass__] is called on the superclass),
 |      except when forward annotations are used that could not immediately be resolved.
 |      In that case, it will be called later, when the model is rebuilt automatically or explicitly using
 |      [`model_rebuild()`][pydantic.main.BaseModel.model_rebuild].
 |  
 |  construct(_fields_set: 'set[str] | None' = None, **values: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  from_orm(obj: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  model_construct(_fields_set: 'set[str] | None' = None, **values: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Creates a new instance of the `Model` class with validated data.
 |      
 |      Creates a new model setting `__dict__` and `__pydantic_fields_set__` from trusted or pre-validated data.
 |      Default values are respected, but no other validation is performed.
 |      
 |      !!! note
 |          `model_construct()` generally respects the `model_config.extra` setting on the provided model.
 |          That is, if `model_config.extra == 'allow'`, then all extra passed values are added to the model instance's `__dict__`
 |          and `__pydantic_extra__` fields. If `model_config.extra == 'ignore'` (the default), then all extra passed values are ignored.
 |          Because no validation is performed with a call to `model_construct()`, having `model_config.extra == 'forbid'` does not result in
 |          an error if extra values are passed, but they will be ignored.
 |      
 |      Args:
 |          _fields_set: A set of field names that were originally explicitly set during instantiation. If provided,
 |              this is directly used for the [`model_fields_set`][pydantic.BaseModel.model_fields_set] attribute.
 |              Otherwise, the field names from the `values` argument will be used.
 |          values: Trusted or pre-validated data dictionary.
 |      
 |      Returns:
 |          A new instance of the `Model` class with validated data.
 |  
 |  model_json_schema(by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}', schema_generator: 'type[GenerateJsonSchema]' = <class 'pydantic.json_schema.GenerateJsonSchema'>, mode: 'JsonSchemaMode' = 'validation', *, union_format: "Literal['any_of', 'primitive_type_array']" = 'any_of') -> 'dict[str, Any]' from pydantic._internal._model_construction.ModelMetaclass
 |      Generates a JSON schema for a model class.
 |      
 |      Args:
 |          by_alias: Whether to use attribute aliases or not.
 |          ref_template: The reference template.
 |          union_format: The format to use when combining schemas from unions together. Can be one of:
 |      
 |              - `'any_of'`: Use the [`anyOf`](https://json-schema.org/understanding-json-schema/reference/combining#anyOf)
 |              keyword to combine schemas (the default).
 |              - `'primitive_type_array'`: Use the [`type`](https://json-schema.org/understanding-json-schema/reference/type)
 |              keyword as an array of strings, containing each type of the combination. If any of the schemas is not a primitive
 |              type (`string`, `boolean`, `null`, `integer` or `number`) or contains constraints/metadata, falls back to
 |              `any_of`.
 |          schema_generator: To override the logic used to generate the JSON schema, as a subclass of
 |              `GenerateJsonSchema` with your desired modifications
 |          mode: The mode in which to generate the schema.
 |      
 |      Returns:
 |          The JSON schema for the given model class.
 |  
 |  model_parametrized_name(params: 'tuple[type[Any], ...]') -> 'str' from pydantic._internal._model_construction.ModelMetaclass
 |      Compute the class name for parametrizations of generic classes.
 |      
 |      This method can be overridden to achieve a custom naming scheme for generic BaseModels.
 |      
 |      Args:
 |          params: Tuple of types of the class. Given a generic class
 |              `Model` with 2 type variables and a concrete model `Model[str, int]`,
 |              the value `(str, int)` would be passed to `params`.
 |      
 |      Returns:
 |          String representing the new class where `params` are passed to `cls` as type variables.
 |      
 |      Raises:
 |          TypeError: Raised when trying to generate concrete names for non-generic models.
 |  
 |  model_rebuild(*, force: 'bool' = False, raise_errors: 'bool' = True, _parent_namespace_depth: 'int' = 2, _types_namespace: 'MappingNamespace | None' = None) -> 'bool | None' from pydantic._internal._model_construction.ModelMetaclass
 |      Try to rebuild the pydantic-core schema for the model.
 |      
 |      This may be necessary when one of the annotations is a ForwardRef which could not be resolved during
 |      the initial attempt to build the schema, and automatic rebuilding fails.
 |      
 |      Args:
 |          force: Whether to force the rebuilding of the model schema, defaults to `False`.
 |          raise_errors: Whether to raise errors, defaults to `True`.
 |          _parent_namespace_depth: The depth level of the parent namespace, defaults to 2.
 |          _types_namespace: The types namespace, defaults to `None`.
 |      
 |      Returns:
 |          Returns `None` if the schema is already "complete" and rebuilding was not required.
 |          If rebuilding _was_ required, returns `True` if rebuilding was successful, otherwise `False`.
 |  
 |  model_validate(obj: 'Any', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, from_attributes: 'bool | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Validate a pydantic model instance.
 |      
 |      Args:
 |          obj: The object to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          from_attributes: Whether to extract data from object attributes.
 |          context: Additional context to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Raises:
 |          ValidationError: If the object could not be validated.
 |      
 |      Returns:
 |          The validated model instance.
 |  
 |  model_validate_json(json_data: 'str | bytes | bytearray', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      !!! abstract "Usage Documentation"
 |          [JSON Parsing](../concepts/json.md#json-parsing)
 |      
 |      Validate the given JSON data against the Pydantic model.
 |      
 |      Args:
 |          json_data: The JSON data to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          context: Extra variables to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Returns:
 |          The validated Pydantic model.
 |      
 |      Raises:
 |          ValidationError: If `json_data` is not a JSON string or the object could not be validated.
 |  
 |  model_validate_strings(obj: 'Any', *, strict: 'bool | None' = None, extra: 'ExtraValues | None' = None, context: 'Any | None' = None, by_alias: 'bool | None' = None, by_name: 'bool | None' = None) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |      Validate the given object with string data against the Pydantic model.
 |      
 |      Args:
 |          obj: The object containing string data to validate.
 |          strict: Whether to enforce types strictly.
 |          extra: Whether to ignore, allow, or forbid extra data during model validation.
 |              See the [`extra` configuration value][pydantic.ConfigDict.extra] for details.
 |          context: Extra variables to pass to the validator.
 |          by_alias: Whether to use the field's alias when validating against the provided input data.
 |          by_name: Whether to use the field's name when validating against the provided input data.
 |      
 |      Returns:
 |          The validated Pydantic model.
 |  
 |  parse_file(path: 'str | Path', *, content_type: 'str | None' = None, encoding: 'str' = 'utf8', proto: 'DeprecatedParseProtocol | None' = None, allow_pickle: 'bool' = False) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  parse_obj(obj: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  parse_raw(b: 'str | bytes', *, content_type: 'str | None' = None, encoding: 'str' = 'utf8', proto: 'DeprecatedParseProtocol | None' = None, allow_pickle: 'bool' = False) -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  schema(by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}') -> 'Dict[str, Any]' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  schema_json(*, by_alias: 'bool' = True, ref_template: 'str' = '#/$defs/{model}', **dumps_kwargs: 'Any') -> 'str' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  update_forward_refs(**localns: 'Any') -> 'None' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  validate(value: 'Any') -> 'Self' from pydantic._internal._model_construction.ModelMetaclass
 |  
 |  ----------------------------------------------------------------------
 |  Readonly properties inherited from pydantic.main.BaseModel:
 |  
 |  __fields_set__
 |  
 |  model_extra
 |      Get extra fields set during validation.
 |      
 |      Returns:
 |          A dictionary of extra fields, or `None` if `config.extra` is not set to `"allow"`.
 |  
 |  model_fields_set
 |      Returns the set of fields that have been explicitly set on this model instance.
 |      
 |      Returns:
 |          A set of strings representing the fields that have been set,
 |              i.e. that were not filled from defaults.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from pydantic.main.BaseModel:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __pydantic_extra__
 |  
 |  __pydantic_fields_set__
 |  
 |  __pydantic_private__
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes inherited from pydantic.main.BaseModel:
 |  
 |  __hash__ = None
 |  
 |  __pydantic_root_model__ = False
 |  
 |  model_computed_fields = {}
 |  
 |  model_fields = {'container': FieldInfo(annotation=Union[_Just, _Nothin...
 |  
 |  ----------------------------------------------------------------------
 |  Class methods inherited from typing.Generic:
 |  
 |  __init_subclass__(*args, **kwargs) from pydantic._internal._model_construction.ModelMetaclass
 |      This method is called when a class is subclassed.
 |      
 |      The default implementation does nothing. It may be
 |      overridden to extend subclasses.
```

## justQ

[go up](#Cheetsheet)

```hy
Name: justQ
Kind: Reimport from [fptk.monads.maybeM]
Sgnt: justQ(maybeValue) -> bool
Info: throws error when used not on Maybe type
```

```hy
Help on function justQ in module fptk.monads.maybeM:

justQ(maybeM: fptk.monads.maybeM.Maybe) -> bool
```

## nothingQ

[go up](#Cheetsheet)

```hy
Name: nothingQ
Kind: Reimport from [fptk.monads.maybeM]
Sgnt: justQ(maybeValue) -> bool
Info: throws error when used not on Maybe type
```

```hy
Help on function nothingQ in module fptk.monads.maybeM:

nothingQ(maybeM: fptk.monads.maybeM.Maybe) -> bool
```

## mapM

[go up](#Cheetsheet)

```hy
Name: mapM
Kind: Reimport from [fptk.monads.maybeM]
Sgnt: mapM(maybeVal, pureF1, pureF2, ...) -> Maybe
Info: apply pure function to value stored in Maybe, do nothing for Nothing
```

```hy
Help on function mapM in module fptk.monads.maybeM:

mapM(maybeM: fptk.monads.maybeM.Maybe, *fs) -> fptk.monads.maybeM.Maybe
```

## bindM

[go up](#Cheetsheet)

```hy
Name: bindM
Kind: Reimport from [fptk.monads.maybeM]
Sgnt: bindM(maybeVal, mF1, mF2, ...) -> Maybe
Info: apply monadic (f :: val -> maybe) to Just, do nothing for Nothing
```

```hy
Help on function bindM in module fptk.monads.maybeM:

bindM(maybeM: fptk.monads.maybeM.Maybe, *fs) -> fptk.monads.maybeM.Maybe
```

## unwrapM

[go up](#Cheetsheet)

```hy
Name: unwrapM
Kind: Reimport from [fptk.monads.maybeM]
Info: returns contained Just value or throws error when not Just
```

```hy
Help on function unwrapM in module fptk.monads.maybeM:

unwrapM(maybeM: fptk.monads.maybeM.Maybe) -> ~J
    throws error on Nothing
```

## unwrapM_or

[go up](#Cheetsheet)

```hy
Name: unwrapM_or
Kind: Reimport from [fptk.monads.maybeM]
Info: returns contained Just value or falls back to default
```

```hy
Help on function unwrapM_or in module fptk.monads.maybeM:

unwrapM_or(maybeM: fptk.monads.maybeM.Maybe, default: ~J) -> ~J
```

## Result

[go up](#Cheetsheet)

```hy
Name: Result
Kind: Reimport from [fptk.monads.resultM]
Info: Result monad. Should be used in annotations only
```

## Success

[go up](#Cheetsheet)

```hy
Name: Success
Kind: Reimport from [fptk.monads.resultM]
Info: Success container of Result monad
```

```hy
Help on function Success in module fptk.monads.resultM:

Success(value)
```

## Failure

[go up](#Cheetsheet)

```hy
Name: Failure
Kind: Reimport from [fptk.monads.resultM]
Info: Failure container of Result monad
```

```hy
Help on function Failure in module fptk.monads.resultM:

Failure(value)
```

## successQ

[go up](#Cheetsheet)

```hy
Name: successQ
Kind: Reimport from [fptk.monads.resultM]
Sgnt: successQ(result) -> bool
Info: throws error when used not on Result type
```

```hy
Help on function successQ in module fptk.monads.resultM:

successQ(resultM: fptk.monads.resultM.Result) -> bool
```

## failureQ

[go up](#Cheetsheet)

```hy
Name: failureQ
Kind: Reimport from [fptk.monads.resultM]
Sgnt: failureQ(result) -> bool
Info: throws error when used not on Result type
```

```hy
Help on function failureQ in module fptk.monads.resultM:

failureQ(resultM: fptk.monads.resultM.Result) -> bool
```

## mapR

[go up](#Cheetsheet)

```hy
Name: mapR
Kind: Reimport from [fptk.monads.resultM]
Sgnt: mapR(result, pureF1, pureF2, ...) -> Result
Info: apply pure function to value stored in Success, do nothing for Failure
```

```hy
Help on function mapR in module fptk.monads.resultM:

mapR(resultM: fptk.monads.resultM.Result, *fs) -> fptk.monads.resultM.Result
```

## bindR

[go up](#Cheetsheet)

```hy
Name: bindR
Kind: Reimport from [fptk.monads.resultM]
Sgnt: bindR(result, mF1, mF2, ...) -> Result
Info: apply monadic (f :: val -> Result) to Success, do nothing for Failure
```

```hy
Help on function bindR in module fptk.monads.resultM:

bindR(resultM: fptk.monads.resultM.Result, *fs) -> fptk.monads.resultM.Result
```

## unwrapR

[go up](#Cheetsheet)

```hy
Name: unwrapR
Kind: Reimport from [fptk.monads.resultM]
Info: returns contained Success value or throws error when not Success
```

```hy
Help on function unwrapR in module fptk.monads.resultM:

unwrapR(resultM: fptk.monads.resultM.Result) -> ~S
    throws error when on Failure track
```

## unwrapR_or

[go up](#Cheetsheet)

```hy
Name: unwrapR_or
Kind: Reimport from [fptk.monads.resultM]
Info: returns contained Success value or falls back to default
```

```hy
Help on function unwrapR_or in module fptk.monads.resultM:

unwrapR_or(resultM: fptk.monads.resultM.Result, default: ~S) -> ~S
```

## unwrapE

[go up](#Cheetsheet)

```hy
Name: unwrapE
Kind: Reimport from [fptk.monads.resultM]
Info: returns contained Failure value or throws error when not Failure
```

```hy
Help on function unwrapE in module fptk.monads.resultM:

unwrapE(resultM: fptk.monads.resultM.Result) -> ~F
    throws error when on Success track
```

## unwrapE_or

[go up](#Cheetsheet)

```hy
Name: unwrapE_or
Kind: Reimport from [fptk.monads.resultM]
Info: returns contained Failure value or falls back to default
```

```hy
Help on function unwrapE_or in module fptk.monads.resultM:

unwrapE_or(resultM: fptk.monads.resultM.Result, default: ~F) -> ~F
```