
# fptk strict typing

Strict typing is simple convenience module for pydantic.

Basic pydantic workflow:
you create classes inherited from BaseModel, and fields are validated
upon objects creation (by type or whatever user requests).

# Full list of exported objects

|object|type|description|
|------|----|-----------|
| BaseModel     | class (pydantic)   | pydantic decorator for type-checking functions's args
| StrictInt     | class (pydantic)   | will be still of int type, but will perform pydantic typecheck when variable is created" 
| StrictStr     | class (pydantic)   | will be still of str type, but will perform pydantic typecheck when variable is created" 
| StrictFloat   | class (pydantic)   | will be still of float type, but will perform pydantic typecheck when variable is created" 
| StrictNumber  | class (fptk)       | defined as Union[StrictInt, StrictFloat], that's it
| validate_call | function (pydantic)| decorator for type-checking functions's args
| validateF     | function (fptk)    | simply validate_call(...) with option `validate_return=True` (thus it also validates return type)

