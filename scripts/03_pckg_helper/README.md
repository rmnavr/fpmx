
# Packaging helper

This script is supposed to be executed before every commit (or at least large commit, or push to github).

Performed actions:
1. Prompts fptk version as given in setup.py
2. Runs tests
3. Generates doc-table for fptk funcs
4. Creates `/fptk_local` for usage in other projs

