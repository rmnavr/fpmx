
# fpmx strict typing

fpmx strict typing is simple convenience module for pydantic.

How to load module:
```hy
; via loader:
(require fpmx.loader [load_fpmx])
(load_fpmx "strict_types")

; which is the same as:
(import fpmx.strict.types *) 
```

Basic pydantic workflow:
you create classes inherited from BaseModel, and fields are validated
upon objects creation (by type or whatever user requests).

On my machine pydantic costs:
- 100..150 ms to load
- no more than 20..30% increased time for typechecked functions to execute
  (this obviously varies depending on functions)

# Full list of exported objects

|object|type|description|
|------|----|-----------|
| `BaseModel`     | class (pydantic)   | pydantic decorator for type-checking functions's args
| `StrictInt`     | class (pydantic)   | will be still of int type, but will perform pydantic typecheck when variable is created" 
| `StrictStr`     | class (pydantic)   | will be still of str type, but will perform pydantic typecheck when variable is created" 
| `StrictFloat`   | class (pydantic)   | will be still of float type, but will perform pydantic typecheck when variable is created" 
| `StrictNumber`  | class (fpmx)       | defined as Union[StrictInt, StrictFloat], that's it
| `validate_call` | function (pydantic)| decorator for type-checking functions's args
| `validateF`     | function (fpmx)    | simply validate_call(...) with option `validate_return=True` (thus it also validates return type)


