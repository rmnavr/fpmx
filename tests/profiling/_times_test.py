import subprocess
from time import time as _get_time

def run_cmd_str(command):
    subprocess.run(command, shell=True, check=False, text=True, capture_output=True)

# python.exe currently is same as python_.lnk in my home PC
_t = _get_time()
subprocess.run("python empty_python.py")
_r1 = f"{(_get_time() - _t) :.3f} sec | <empty Python>"

_t = _get_time()
subprocess.run("hy empty_hy.hy")
_r2 = f"{(_get_time() - _t) :.3f} sec | <empty Hy>"

_t = _get_time()
subprocess.run("hy normal_core.hy")
_r3 = f"{(_get_time() - _t) :.3f} sec | normal_core"

_t = _get_time()
subprocess.run("hy loader_core.hy")
_r4 = f"{(_get_time() - _t) :.3f} sec | loader_core"

_t = _get_time()
subprocess.run("hy normal_all.hy")
_r5 = f"{(_get_time() - _t) :.3f} sec | normal_all"

_t = _get_time()
subprocess.run("hy loader_all.hy")
_r6 = f"{(_get_time() - _t) :.3f} sec | loader_all"

print("\n\n=======================================================")
print(_r1)
print(_r2)
print(_r3)
print(_r4)
print(_r5)
print(_r6)


