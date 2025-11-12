#gus

<span title="Your tooltip message">[`Hover over me!`](#riba)</span>


| Group | Functions/Types | Macros |
|-------|-----------------|--------|
| FP: Control flow |  | `case` `branch` `unless` `lif` |
| FP: Composition | `constantly` `identity` `partial` `rpartial` `compose` `rcompose` `ljuxt` `pflip` `flip` | `->` `->>` `as->` `doto` `=>` `=>>` `p:` |
| FP: threading | `lzip` `lmap` `starmap` `lstarmap` `reduce` `reductions` `lreductions` `sums` `lsums` `product` | `fm` `mapm` `lmapm` |
| FP: n-applicators | `nested` `apply_n` | `do_n` `list_n` |
| APL: filtering | `lfilter` `fltr1st` `reject` `lreject` `without` `lwithout` `takewhile` `dropwhile` `filter_split` `lfilter_split` `bisect_at` `lbisect_at` `bisect_by` `lbisect_by` `mask_sel` `lmask_sel` `mask2idxs` `idxs2mask` | `filterm` `lfilterm` |
| APL: iterators and looping | `inf_range` `islice` `lislice` `cycle` `lcycle` `repeat` `lrepeat` `concat` `lconcat` `cat` `lcat` `mapcat` `lmapcat` `pairwise` `with_prev` `with_next` |  |
| APL: working with lists | `flatten` `lprint` `lreversed` `partition` `lpartition` `partition_by` `lpartition_by` `lmulticut_by` |  |
| APL: counting | `count_occurrences` |  |
| Getters: idxs and keys | `nth` `assoc` `first` `second` `third` `fourth` `beforelast` `last` `rest` `butlast` `drop` `take` `pick` | `ncut` |
| Getters: one based index | `get_` `nth_` `slice_` `cut_` |  |
| Getters: keys and attrs | `pluck` `lpluck` `pluck_attr` `lpluck_attr` | `getattrm` `pluckm` `lpluckm` |
| Typing: Base | `dataclass` `Enum` `List` `Tuple` `TypedDict` `Dict` `Union` `Generator` `Any` `Optional` `Callable` `Literal` `Type` `TypeVar` `Generic` `noneQ` `notnoneQ` `oftypeQ` `intQ` `floatQ` `numberQ` `strQ` `dictQ` `listQ` `tupleQ` `setQ` `iteratorQ` `iterableQ` | `of` `f::` `def::` |
| Typing: Strict | `BaseModel` `StrictInt` `StrictStr` `StrictFloat` `StrictNumber` `validate_call` `validateF` |  |
| Math and logic: Basic math | `inc` `dec` `sign` `neg` `floor` `ceil` `half` `double` `squared` `reciprocal` `sqrt` `dist` `hypot` `normalize` `exp` `log` `ln` `log10` `evenQ` `oddQ` `zeroQ` `negativeQ` `positiveQ` |  |
| Math and logic: Ranges | `range_` `lrange_` `clip` |  |
| Math and logic: Trigonometry | `pi` `sin` `cos` `tan` `degrees` `radians` `acos` `asin` `atan` `atan2` |  |
| Math and logic: Base operators to functions | `and_` `or_` `not_` `is_` `xor` `eq` `neq` `gt` `lt` `geq` `leq` `matmul` `div` `gt0` `geq0` `lt0` `leq0` `minus` `dmul` `dadd` `lmul` `smul` `mul` `plus` `sconcat` |  |
| Math and logic: Logic checks | `fnot` `eq_any` `on` `all_fs` `any_fs` `trueQ` `falseQ` `oflenQ` `zerolenQ` |  |
| Math and logic: Random | `choice` `randint` `randfloat` `rand01` |  |
| Strings: Basics | `strlen` `str_join` `lowercase` `strip` `lstrip` `rstrip` `enlengthen` |  |
| Strings: Regex | `re_sub` `re_split` `re_find` `re_test` `re_all` |  |
| IO | `file_existsQ` `fileQ` `dirQ` `read_file` `write_to_file` |  |
| Lens | `lens` | `lns` `&+` `&+>` `l>` `l>=` |
| Benchmarking | `dt_print` | `timing` |
| Testing |  | `assertm` `gives_error_typeQ` |

#riba

ololo
