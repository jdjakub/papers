#!/usr/bin/env bash

set -euo pipefail

pandoc manuscript-prog.md --output manuscript-prog.tex
lualatex ccs20-prog
biber    ccs20-prog
lualatex ccs20-prog
lualatex ccs20-prog

open -a firefox ccs20-prog.pdf
