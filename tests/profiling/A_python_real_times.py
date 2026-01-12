from time import time as _get_time

_import_lenses      = False
_import_strictT     = False
_import_monads      = False

# Imports ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1
_tGlob = _get_time()
# ================================================================

# hy (import)
_t = _get_time()
import hy
_r1 = f"{(_get_time() - _t) :.3f} sec | hy (will be 0 if called from hy file)"

# loader
_t = _get_time()
hy.eval(hy.read(f"(require fptk [load_fptk])"))
_r2 = f"{(_get_time() - _t) :.3f} sec | require fptk [load_fptk]"

_t = _get_time()
from fptk.core import *
_r3 = f"{(_get_time() - _t) :.3f} sec | import fptk.core *"

# core macros (require)
_t = _get_time()
hy.eval(hy.read(f"(require fptk.core *)"))
_r4 = f"{(_get_time() - _t) :.3f} sec | require fptk.core *"

if _import_lenses:
    _t = _get_time()
    from fptk.lenses import *
    hy.eval(hy.read(f"(require fptk.lenses *)"))
    _r5 = f"{(_get_time() - _t) :.3f} sec | import fptk.lenses * , require fptk.lenses *"

if _import_strictT:
    _t = _get_time()
    from fptk.strict.types import *
    _r6 = f"{(_get_time() - _t) :.3f} sec | import fptk.strict.types *"

if _import_monads:
    _t = _get_time()
    from fptk.strict.monads import *
    _r7 = f"{(_get_time() - _t) :.3f} sec | import fptk.strict.monads *"

# ================================================================
_rGlob = f"{(_get_time() - _tGlob) :.3f} sec | Total time"
# _____________________________________________________________________________/ }}}1

print("Import from python:")
print(_r1)
print(_r2)
print(_r3)
print(_r4)
_import_lenses  and print(_r5) # this is syntax for one-liner if-then
_import_strictT and print(_r6)
_import_monads  and print(_r7)
print("-------------")
print(_rGlob)
print("")







# Archive: attempt to make importer (eventually couldn't make macros work):
# Injector ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\ {{{1

# import importlib
# import inspect
# 
# def inject_to_caller(caller_globals, module_name, *, caption="", timed=False):
#     # aims to immitate «from module import *»
#     _t0 = _get_time()
#     #
#     module = importlib.import_module(module_name)
#     for name in dir(module):
#         if not name.startswith('_'):
#             caller_globals[name] = getattr(module, name)
#     _t1 = _get_time()
#     #
#     if timed:
#         print(f"{(_t1 - _t0) :.3f} sec | {caption}")
# 
# def load_fptk(*submodules: str, timed=False) -> None:
#     caller_globals = inspect.currentframe().f_back.f_globals
#     #
#     if "core" in submodules:
#         inject_to_caller(caller_globals, "fptk.core.funcs", caption="core (fns)", timed=timed)
#         # 
#         # Injecting hy macro:
#         # 1) this will add '_hy_macros' item to globals() of this __init__.py
#         _t0 = _get_time()
#         # 2) we copy it and inject it back:
#         #hy.eval(hy.read("(require fptk.core.funcs *)"))
#         # caller_globals["_hy_macros"] = globals()["_hy_macros"]
#         _t1 = _get_time()
#         if timed:
#             print(f"{(_t1 - _t0) :.3f} sec | macros")
#     if "lenses" in submodules:
#         inject_to_caller(caller_globals, "fptk.lenses", caption="lenses (fns)", timed=timed)
#     if "strict" in submodules:
#         inject_to_caller(caller_globals, "fptk.strict", caption="strict (fns)", timed=timed)
#     if "monads" in submodules:
#         inject_to_caller(caller_globals, "fptk.monads", caption="monads (fns)", timed=timed)

# _____________________________________________________________________________/ }}}1

