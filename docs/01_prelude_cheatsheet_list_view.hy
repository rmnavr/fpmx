
=== Checks ===
;: math:
FROM: funcy           | evenQ (<-even)           :: evenQ(x)
FROM: funcy           | oddQ (<-odd)             :: oddQ(x)
DEFN: fpmx            | zeroQ                    :: zeroQ(x)  ; checks directly via (= x 0)
DEFN: fpmx            | negativeQ                :: negativeQ(x)  ; checks directly via (< x 0)
DEFN: fpmx            | positiveQ                :: positiveQ(x)  ; checks directly via (> x 0)
;: type checks:
FROM: funcy           | noneQ (<-isnone)
FROM: funcy           | notnoneQ (<-notnone)
DEFN: fpmx            | oftypeQ                  :: oftypeQ(tp, x)  ; checks directly via (= (type x) tp)
DEFN: fpmx            | ofinstQ                  :: ofinstQ(tp, x)  ; checks directly via (isinstance x tp)
DEFN: fpmx            | intQ                     :: intQ(x)  ; checks literally if type(x) == int, will also work with StrictInt from pydantic
DEFN: fpmx            | floatQ                   :: floatQ(x)  ; checks literally if type(x) == float, will also work with StrictFloat from pydantic
DEFN: fpmx            | numberQ                  :: numberQ(x)  ; checks for intQ or floatQ, will also work with StrictInt/StrictFloat from pydantic
DEFN: fpmx            | strQ                     :: strQ(x)  ; checks literally if type(x) == str, will also work with StrictStr from pydantic
DEFN: fpmx            | dictQ                    :: dictQ(x)  ; checks literally if type(x) == dict
FROM: funcy           | listQ (<-is_list)        :: listQ(value)  ; checks if value is list
FROM: funcy           | tupleQ (<-is_tuple)      :: tupleQ(value)  ; checks if value is tuple
FROM: funcy           | setQ (<-is_set)          :: setQ(value)  ; checks if value is set
FROM: funcy           | iteratorQ (<-is_iter)    :: iteratorQ(value)  ; checks if value is iterator
FROM: funcy           | iterableQ (<-iterable)   :: iterableQ(value)  ; checks if value is iterable
;: etc:
DEFN: fpmx            | trueQ                    :: trueQ(x)  ; checks directly via (= x True)
DEFN: fpmx            | falseQ                   :: falseQ(x)  ; checks directly via (= x False)
DEFN: fpmx            | oflenQ                   :: oflenQ(n, xs)  ; checks directly via (= (len xs) n)
DEFN: fpmx            | zerolenQ                 :: zerolenQ(xs)  ; checks directly via (= (len xs) 0)

=== Math ===
;: basics:
DEFN: fpmx            | dec                      :: inc(n)  ; = n + 1
DEFN: fpmx            | inc                      :: dec(n)  ; = n - 1
DEFN: fpmx            | sign                     :: sign(n)  ; will give 0 for n=0
;: multiples:
DEFN: fpmx            | half                     :: half(x)  ; = x/2
DEFN: fpmx            | double                   :: double(x)  ; = x*2
DEFN: fpmx            | reciprocal               :: reciprocal(x)  ; = 1/x ; throws error for x=0
;: rounding:
FROM: math            | floor                    ; floor(1.9) = 1
FROM: math            | ceil                     ; ceil(1.1) = 2
DEFN: fpmx            | round_to                 :: round_to(n, step)  ; rounds to closest multiple of step: round_to(9.1, 1.5) == 9.0
DEFN: fpmx            | clip                     :: clip(x, lower, upper)  ; clips x to fit in lower <= x <= upper limit
FROM: math            | approx_eq (<-isclose)    ; approx_eq(a, b, *, rel_tol=1e-09, abs_tol=0.0)
;: squaring:
FROM: math            | sqrt                     :: sqrt(n)  ; = √n
DEFN: fpmx            | squared                  :: squared(x)  ; = pow(x,2)
FROM: math            | dist                     :: dist(p, q) -> float  ; ≈ √((px-qx)² + (py-qy)² ...)
FROM: math            | hypot                    :: hypot(*coordinates)  ; = √(x² + y² + ...)
DEFN: fpmx            | normalize                :: normalize(xs) -> xs  ; will throw error for zero-len vector
;: exponents:
INFO: py              | pow /builtin/
FROM: math            | exp                      :: exp(x)
FROM: math            | log                      :: log(x, base=math.e)
DEFN: fpmx            | ln                       :: ln(x)  ; = math.log(x, math.e) ; coexists with log for clarity
FROM: math            | log10                    :: log10(x)
;: trigonometry:
FROM: math            | pi                       ; literally just float pi=3.14...
FROM: math            | sin                      :: sin(x)  ; x is in radians
FROM: math            | cos                      :: cos(x)  ; x is in radians
FROM: math            | tan                      :: tan(x)  ; x is in radians, will give smth like 1.6E+16 for x = pi
FROM: math            | degrees                  :: degrees(x)  ; x in radians is converted to degrees
FROM: math            | radians                  :: radians(x)  ; x in degrees is converted to radians
FROM: math            | acos                     :: acos(x)  ; x is in radians, result is between 0 and pi
FROM: math            | asin                     :: asin(x)  ; x is in radians, result is between -pi/2 and pi/2
FROM: math            | atan                     :: asin(x)  ; x is in radians, result is between -pi/2 and pi/2
FROM: math            | atan2                    :: atan2(y, x)  ; both signs are considered
;: random:
FROM: random          | choice                   :: choice(seq) -> Elem  ; throws error for empty list
FROM: random          | rand_int (<-randint)     :: rand_int(a, b) -> int  ; returns random integer in range [a, b] including both end points
FROM: random          | rand_float (<-uniform)   :: rand_float(a, b) -> float  ; range is [a, b) or [a, b] depending on rounding
FROM: random          | rand01 (<-random)        :: rand01() -> float  ; generates random number in interval [0, 1)
;: reductions:
FROM: funcy           | sums                     :: sums(seq [, acc]) -> generator  ; reductions with addition function
FROM: funcy           | lsums                    :: lsums(seq [, acc]) -> list  ; list version of sums
FROM: math            | product (<-prod)         :: product(iterable, /, *, start=1)  ; product([2, 3, 5]) = 30

=== Operator to functions ===
;: math:
DEFN: fpmx            | minus                    :: minus(x, y) = x - y
FROM: operator        | neg                      :: neg(n)  ; = -1 * n
FROM: operator        | mod                      :: mod(5, 2)  ; = 1
FROM: operator        | matmul                   ; '@' as function
FROM: operator        | div (<-truediv)          :: div(a, b)
;: logics:
FROM: operator        | and_                     ; 'and' as function
FROM: operator        | or_                      ; 'or' as function
FROM: operator        | not_                     ; 'not' as function
FROM: operator        | is_                      ; 'is' as function
FROM: operator        | xor
FROM: operator        | eq                       ; equal
FROM: operator        | neq (<-ne)               ; non-equal
FROM: operator        | gt                       ; greater than
FROM: operator        | lt                       ; less than
FROM: operator        | geq (<-ge)               ; greater or equal
FROM: operator        | leq (<-le)               ; less or equal
DEFN: fpmx            | gt0                      :: gt0(x)  ; checks for x > 0
DEFN: fpmx            | geq0                     :: geq0(x)  ; x >= 0
DEFN: fpmx            | lt0                      :: lt0(x)  ; checks for x < 0
DEFN: fpmx            | leq0                     :: leq0(x)  ; x <= 0
;: dunders:
DEFN: fpmx            | mul                      :: mul(*args)  ; literally just mul(a,b,c,...)=a*b*c*...; can also be used with 0 or 1 arg
DEFN: fpmx            | smul                     :: smul(*args)  ; synonim of mul (with underlined usage on strings)
DEFN: fpmx            | lmul                     :: lmul(*args)  ; synonim of mul (with underlined usage on lists)
DEFN: fpmx            | plus                     :: plus(*args)  ; literally just plus(a,b,c,...)=a+b+c...; can also be used with 0 or 1 arg
DEFN: fpmx            | sconcat                  :: sconcat(*args)  ; string concantenation as a monoid (will not give error when used with 0 or 1 args)

=== Strings ===
;: basics:
DEFN: fpmx            | strlen                   :: strlen(text)  ; rename of len, underlines usage on strings
DEFN: fpmx            | str_join                 :: str_join(ss, sep='')  ; rearrangement of funcy.str_join, ss is seq of strings
DEFN: fpmx            | enlengthen               :: enlengthen(target_len, string, char=' ', on_tail=True)  ; adds char to string until target_len reached
;: methods to functions:
DEFN: fpmx            | lowercase                :: lowercase(string)  ; str.lower method as a function
DEFN: fpmx            | strip                    :: strip(string, chars=None)  ; str.strip method as a function
DEFN: fpmx            | lstrip                   :: lstrip(string, chars=None)  ; str.lstrip method as a function
DEFN: fpmx            | rstrip                   :: rstrip(string, chars=None)  ; str.rstrip method as a function
;: regex:
FROM: re              | re_sub (<-sub)           :: re_sub(rpattern, replacement, string, count=0, flags=0)
FROM: re              | re_split (<-split)       :: re_split(rpattern, string)
FROM: funcy           | re_find                  :: re_find(rpattern, string, flags=0) -> str  ; returns first found
FROM: funcy           | re_test                  :: re_test(rpattern, string, ...) -> bool  ; tests if string has match (not neccessarily whole string)
FROM: funcy           | re_all                   :: re_all(rpattern, string, ...) -> List  ; returns tuples if groups requested like via r'a(b)(c)d'

=== Getters ===
;: basic:
INFO: hy              | . /macro/                :: (. xs [n1] [n2] ...) -> xs[n1][n2]...  ; throws error when not found
INFO: hy              | get /macro/              :: (get xs n #* keys) -> xs[n][key1]...  ; throws error when not found
FROM: fpmx/hyrule     | assoc                    :: assoc(xs, k1, v1, k2, v2, ...) -> None  ; ≈ (setv (get xs k1) v1 (get xs k2) v2) ; also possible: (assoc xs :x 1)
FROM: funcy           | nth                      :: nth(n, seq) -> Optional elem  ; 0-based index; works also with dicts
INFO: py              | slice /builtin/          :: (slice start end step)  ; returns empty list when not found
INFO: hy              | cut /macro/              :: (cut xs start end step) -> (get xs (slice start end step)) -> List  ; returns empty list when none found
FROM: funcy           | first                    :: first(seq) -> Optional elem
FROM: funcy           | second                   :: second(seq) -> Optional elem
DEFN: fpmx            | third                    :: third(seq) -> Optional elem
DEFN: fpmx            | fourth                   :: fourth(seq) -> Optional elem
DEFN: fpmx            | fifth                    :: fifth(seq) -> Optional elem
DEFN: fpmx            | beforelast               :: beforelast(seq) -> Optional elem
FROM: funcy           | last                     :: last(seq) -> Optional elem
MACR: fpmx/hyrule     | ncut
;: list:
DEFN: fpmx            | rest                     :: rest(seq) -> List  ; drops 1st elem of list
DEFN: fpmx            | butlast                  :: butlast(seq) -> List  ; drops last elem of list
DEFN: fpmx            | drop                     :: drop(n, seq) -> List  ; drops n>=0 elems from start of the list; when n<0, drops from end of the list
DEFN: fpmx            | take                     :: take(n, seq) -> List  ; takes n elems from start; when n<0, takes from end of the list
DEFN: fpmx            | pick                     :: pick(ns, seq) -> List  ; throws error if some of ns doesn't exist; ns can be list of ints or dict keys
;: attrs and bulk:
INFO: py              | getattr /builtin/        :: getattr(object, name[, default]) -> value  ; arg name should be given as str
FROM: funcy           | pluck                    :: pluck(key, mappings) -> generator  ; gets same key (or idx) from every mapping, mappings can be lists of lists/dicts/etc.
FROM: funcy           | lpluck                   :: lpluck(key, mappings) -> list
FROM: funcy           | pluck_attr               :: pluck_attr(attr, objects) -> generator  ; attr should be given as str
FROM: funcy           | lpluck_attr              :: lpluck_attr(attr, objects) -> list  ; list version of pluck_attr
MACR: fpmx            | pluckm                   :: (pluckm n xs) (pluckm key ys) (pluckm .attr zs)  ; accepts fpmx-style .arg syntax
MACR: fpmx            | lpluckm                  ; list version of pluckm
MACR: fpmx            | getattrm                 :: (getattrm Object 'attr') (getattrm Object .attr)  ; accepts fpmx-style .attr syntax
;: mask:
FROM: itertools       | mask_sel (<-compress)    :: mask_sel('abc', [1,0,1]) -> iterator: 'a', 'c'
DEFN: fpmx            | lmask_sel                :: lmask_sel(data, selectors) -> list
DEFN: fpmx            | mask2idxs                :: mask2idxs(mask) -> list  ; mask is list like [1 0 1 0] or [True False True False], which will be converted to [0 2]
DEFN: fpmx            | idxs2mask                :: idxs2mask(idxs) -> list  ; idxs is non-sorted list of integers like [0 3 2], which will be converted to [1 0 1 1]

=== Typing ===
;: all:
FROM: typing          | List
FROM: typing          | Tuple
FROM: typing          | Dict
FROM: typing          | Union
FROM: typing          | TypedDict
FROM: typing          | NamedTuple
FROM: typing          | Optional
FROM: typing          | Generator
FROM: typing          | Any
FROM: typing          | Callable
FROM: typing          | Literal
FROM: typing          | Type
FROM: typing          | TypeVar
FROM: typing          | Generic
FROM: enum            | Enum
SETV: fpmx            | number                   ; simply Union(int, float)
FROM: dataclasses     | dataclass
FROM: dataclasses     | upd_field (<-replace)    ; non-mutating
FROM: dataclasses     | dc_field (<-field)       ; dataclasses.field
MACR: fpmx/hyrule     | of                       ; example: (of List int) which is equiv to py-code: List[int]
MACR: fpmx            | def::                    ; define func with Haskell-style signature; example: (def:: int -> int => float fdivide [x y] (/ x y))
MACR: fpmx            | f::                      ; example: (f:: int -> int => (of Tuple int str)) will produce: Callable[[int, int], Tuple[int,str]]

=== IO ===
;: all:
FROM: os.path         | file_existsQ (<-exists)  :: file_existsQ(filename)  ; also works on folders
FROM: os.path         | fileQ (<-isfile)         :: fileQ(filename)
FROM: os.path         | dirQ (<-isdir)           :: dirQ(filename)
DEFN: fpmx            | read_file                :: read_file(file_name, encoding='utf-8') -> str  ; returns whole file content
DEFN: fpmx            | write_to_file            :: write_file(text, file_name, mode='w', encoding='utf-8')  ; modes: 'w' - (over)write, 'a' - append, 'x' - exclusive creation

=== APL ===
;: generating ranges:
FROM: itertools       | inf_range (<-count)      :: inf_range(start [, step])  ; inf_range(10) -> generator: 10, 11, 12, ...
FROM: itertools       | cycle                    :: cycle(p)  ; cycle('AB') -> A B A B ...
DEFN: fpmx            | lcycle                   :: lcycle(p, n) -> list  ; takes first n elems from cycle(p)
FROM: itertools       | repeat                   :: repeat(elem [, n])  ; repeat(10,3) -> 10 10 10
DEFN: fpmx            | lrepeat                  :: lrepeat(elem, n) -> list  ; unlike in repeat, n has to be provided
FROM: funcy           | pairwise                 :: pairwise(seq) -> iterator  ; supposed to be used in loops, will produce no elems for seq with len <= 1
FROM: funcy           | with_prev                :: with_prev(seq, fill=None) -> iterator  ; supposed to be used in loops
FROM: funcy           | with_next                :: with_next(seq, fill=None) -> iterator  ; supposed to be used in loops
DEFN: fpmx            | range_                   :: range_(start, end=None, step=1) -> range  ; same as range, but both ends included
DEFN: fpmx            | lrange_                  :: lrange_(start, end, step=1) -> List  ; range including both ends when possible, also works on fractionals
;: iterators utils:
FROM: itertools       | islice                   :: islice(iterable, start, stop[, step])  ; list(islice(inf_range(10), 2)) == [10, 11]
DEFN: fpmx            | lislice                  ; list version of islice: lislice
;: list concatenation:
FROM: funcy           | cat                      :: cat(seqs)  ; non-variadic version of concat
FROM: funcy           | lcat                     :: lcat(seqs)  ; non-variadic version of concat
FROM: itertools       | concat (<-chain)         :: concat(*seqs) -> iterator  ; variadic vertion of cat
DEFN: fpmx            | lconcat                  :: lconcat(*seqs) -> list  ; literally just list(concat(*seqs))
FROM: funcy           | mapcat                   :: mapcat(f, *seqs)  ; maps, then concatenates
FROM: funcy           | lmapcat                  :: lmapcat(f, *seqs)  ; maps, then concatenates
;: sorting:
INFO: py              | reversed /bultin/        :: reversed(sequence) -> iterator
DEFN: fpmx            | lreversed                :: lreversed(sequence)  ; list version of reversed
;: filtering:
INFO: py              | in /builtin/             :: (in 1 [0 1 2])
INFO: py              | filter /builtin/         :: filter(function or None, iterable) -> filter object  ; when f=None, checks if elems are True
FROM: funcy           | lfilter                  :: lfilter(pred, seq) -> List  ; funcy list version of extended filter
DEFN: fpmx            | fltr1st                  :: fltr1st(f, seq) -> Optional elem  ; returns first found element (or None)
FROM: funcy           | reject (<-remove)        :: reject(pred, seq)-> iterator  ; same as filter, but checks for False
FROM: funcy           | lreject (<-lremove)      :: lreject(pred, seq) -> List  ; list version of reject
DEFN: fpmx            | without                  :: without(items, seq) -> generator  ; subtracts items from seq (as a sets)
DEFN: fpmx            | lwithout                 :: lwithout(items, seq) -> list  ; list version of reject
FROM: funcy           | takewhile                :: takewhile([pred, ] seq)  ; yields elems of seq as long as they pass pred
FROM: funcy           | dropwhile                :: dropwhile([pred, ] seq)  ; mirror of takewhile
FROM: funcy           | filter_split (<-split)   :: filter_split(pred, seq) -> passed, rejected
FROM: funcy           | lfilter_split (<-lsplit) :: lfilter_split(pred,seq) -> passed, rejected  ; list version of filter_split
;: cutting and grouping:
FROM: itertools       | combinations             :: combinations([1,2,3], 2) = [(1,2), (1,3), (2,3)]
DEFN: fpmx            | lcombinations            ; list version of 'combinations'
FROM: fpmx/hyrule     | flatten                  :: flatten(coll)  ; recursively flattens to the bottom
FROM: funcy           | bisect_at (<-split_at)   :: bisect_at(n, seq) -> start, tail  ; len of start will = n, works only with n>=0
DEFN: fpmx            | lbisect_at               :: lbisect_at(n, seq) -> start, tail  ; list version of bisect_at, but also for n<0, abs(n) will be len of tail
FROM: funcy           | bisect_by (<-split_by)   :: bisect_by(pred, seq) -> taken, dropped  ; similar to (takewhile, dropwhile)
FROM: funcy           | lbisect_by (<-lsplit_by) :: lbisect_by(pred, seq) -> taken, dropped  ; list version of lbisect
DEFN: fpmx            | partition                :: partition(n, seq, *, step=None, tail=False) -> generator  ; splits seq to lists of len n, tail=True will allow including fewer than n items
DEFN: fpmx            | lpartition               :: lpartition(n, seq, *, step=None, tail=False) -> List  ; simply list(partition(...))
FROM: funcy           | partition_by             :: partition_by(f, seq) -> iterator of iterators  ; splits when f(item) change
FROM: funcy           | lpartition_by            :: lpartition_by(f,seq) -> list of lists  ; list(partition_by(...))
FROM: funcy           | group_by                 :: group_by(f, seq) -> defaultdict(list)  ; groups elems of seq keyed by the result of f
DEFN: fpmx            | lmulticut_by             :: lmulticut_by(pred, seq, keep_border=True, merge_border=False) -> list  ; cut at pred(elem)==True elems

=== FP ===
;: control flow:
INFO: py              | if /builtin/             :: (if check true false)
INFO: hy              | cond /builtin/           :: (cond check1 do1 check2 do2 True doT)
INFO: hy              | case /builtin/           :: (case 10 10 True 20 False else None)
MACR: fpmx/hyrule     | case
MACR: fpmx/hyrule     | unless
MACR: fpmx/hyrule     | lif
MACR: fpmx/hyrule     | branch
;: lambdas:
MACR: fpmx            | fm                       :: (fm (* it 3))  ; anonymous function that accepts args in form of 'it' or '%1', '%2', ... '%9'
MACR: fpmx            | f>                       :: (f> (* it 3) 4)  ; anonymous function with fm syntax, immediately applicates args
MACR: fpmx            | mapm                     ; same as map, but expects fm-syntax for func
MACR: fpmx            | lmapm                    ; same as lmap, but expects fm-syntax for func
MACR: fpmx            | filterm                  :: (filterm f xs)  ; same as filter, but expects fm-syntax for func
MACR: fpmx            | lfilterm                 :: (lfilterm f xs)  ; list version of lfilterm
;: map zip reduce:
INFO: py              | zip /base/               :: zip(*iterables) -> zip object
DEFN: fpmx            | lzip                     :: lzip(*iterables) -> List  ; literally just list(zip(*iterables))
INFO: py              | map /base/               :: map(func, *iterables) -> map object
FROM: funcy           | lmap                     :: lmap(f, *seqs) -> List  ; list version of map
FROM: itertools       | starmap                  :: starmap(function, iterable)
DEFN: fpmx            | lstarmap                 :: lstarmap(function, iterable) -> list  ; list version of starmap
FROM: functools       | reduce                   :: reduce(function, sequence[, initial]) -> value  ; theory: reduce + monoid = binary-function for free becomes n-arg-function
FROM: funcy           | reductions               :: reductions(f, seq [, acc]) -> generator  ; returns sequence of intermetidate values of reduce(f, seq, acc)
FROM: funcy           | lreductions              :: lreductions(f, seq [, acc]) -> list  ; list version of reductions
;: function composition:
FROM: funcy           | identity                 ; identity(n) -> n
DEFN: fpmx            | constantly               :: constantly(val)  ; constantly(30) is FUNCTION that always return val no matter the arguments
FROM: funcy           | compose                  :: compose(f1, f2, ..., fn)  ; = f1(f2(..fn(***))) ; applicator
FROM: funcy           | rcompose                 :: rcompose(f1, f2, ..., fn)  ; = fn(..(f2(f1(***)))) ; applicator
FROM: funcy           | ljuxt                    :: ljuxt(*fs)  ; = [f1, f2, ...](***) ; applicator
DEFN: fpmx            | nested                   :: nested(n, f)  ; applicator f(...(f(***)))
DEFN: fpmx            | apply_n                  :: apply_n(n, f, *args, **kwargs)  ; f(f(f(...f(*args, **kwargs))
FROM: funcy           | partial                  ; applicator
FROM: funcy           | rpartial                 ; applicator
DEFN: fpmx            | flip                     :: flip(f, a, b) = f(b, a)  ; calls f with flipped args
DEFN: fpmx            | pflip                    :: pflip(f, a)  ; applicator for function f(a,b) of 2 args; example: pflip(div, 4)(1) == 0.25
MACR: fpmx/hyrule     | do_n                     :: (do_n   n #* body) -> None  ; expands to ~ (do body body body ...)
MACR: fpmx/hyrule     | list_n                   :: (list_n n #* body) -> List
MACR: fpmx/hyrule     | ->
MACR: fpmx/hyrule     | ->>
MACR: fpmx/hyrule     | as->
MACR: fpmx/hyrule     | doto                     ; mutating
MACR: fpmx            | =>                       ; unification of dot-macro and ->
MACR: fpmx            | =>>                      ; unification of dot-macro and ->>
MACR: fpmx            | p:                       ; aplicator, pipe of partials
;: logic checks in FP style:
DEFN: fpmx            | fnot                     :: fnot(f, *args, **kwargs)  ; = not(f(*args, **kwargs))
DEFN: fpmx            | eq_any                   :: eq_any(x, values)  ; = (or (eq x value1) (eq x value2) ...)
DEFN: fpmx            | on                       :: on(f, check, x, y)  ; example: (on len eq xs ys) -> (eq (len xs) (len yx))
DEFN: fpmx            | all_fs                   :: all_fs(fs, *args, **kwargs)  ; checks if all f(*args, **kwargs) are True
DEFN: fpmx            | any_fs                   :: any_fs(fs, *args, **kwargs)  ; checks if any of f(*args, **kwargs) is True

=== Misc ===
;: one-based index getters:
DEFN: fpmx            | get_                     :: get_(seq, *ns) -> elem  ; same as get, but with 1-based index (will throw error for n=0)
DEFN: fpmx            | nth_                     :: nth_(n, seq) -> Optional elem  ; same as nth, but with 1-based index; will return None for n=0
DEFN: fpmx            | slice_                   :: slice_(start, end, step=None)  ; similar to slice, but with 1-based index; will throw error for start=0 or end=0
DEFN: fpmx            | cut_                     :: cut_(seq, start, end, step=None) -> List  ; similar to cut, but with 1-based index; will throw error for start=0 or end=0
;: benchmarking:
FROM: time            | cur_time (<-time)        :: cur_time()  ; gets current time in seconds
DEFN: fpmx            | dt_print                 :: dt_print(* args, fresh_run=False)  ; starts timer on fresh run, prints time passed since previous call
MACR: fpmx            | timing                   :: (timing expr1 expr2 ...) -> #(float, Any)  ; returns time (in seconds) and result of execution of (fn [] expr1 expr2 ...)
;: testing:
MACR: fpmx            | assertm                  :: (assertm op arg1 arg2)  ; tests if (op arg1 arg2), for example (= 1 1)
MACR: fpmx            | gives_error_typeQ        ; example: (assertm gives_error_typeQ (get [1] 2) IndexError)
;: misc:
FROM: pprint          | pprint                   ; standard python pprint function
DEFN: fpmx            | lprint                   :: lprint(seq, sep=None)  ; prints every elem of seq on new line
MACR: fpmx/hyrule     | comment

