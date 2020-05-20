#!/usr/bin/env bash

set -euo pipefail

pandoc manuscript-acm.md --output manuscript-acm.tex
lualatex ccs20-acm

open -a firefox ccs20-acm.pdf
