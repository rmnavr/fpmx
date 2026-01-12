import subprocess
from time import time as _get_time

def run_cmd_str(command):
    subprocess.run(command, shell=False, check=False, text=True, capture_output=False)

# python.exe currently is same as python_.lnk in my home PC

_t = _get_time()
subprocess.run("python empty_python.py")
_r1 = f"{(_get_time() - _t) :.3f} sec | <empty Python>"

_t = _get_time()
subprocess.run("hy empty_hy.hy")
_r2 = f"{(_get_time() - _t) :.3f} sec | <empty Hy>"

_t = _get_time()
subprocess.run("python A_python_real_times.py")
_r3 = f"{(_get_time() - _t) :.3f} sec | Python"

_t = _get_time()
subprocess.run("hy B_call_python_from_hy.hy")
_r4 = f"{(_get_time() - _t) :.3f} sec | Python from hy"

_t = _get_time()
subprocess.run("hy C_hy_with_loader.hy")
_r5 = f"{(_get_time() - _t) :.3f} sec | Hy (with loader)"

_t = _get_time()
subprocess.run("hy D_hy_direct.hy")
_r6 = f"{(_get_time() - _t) :.3f} sec | Hy (direct import/require)"

print("\n\n=======================================================")
print(_r1)
print(_r2)
print(_r3)
print(_r4)
print(_r5)
print(_r6)


