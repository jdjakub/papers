#!/usr/bin/env bash

set -euo pipefail

pandoc plop21-manuscript.md --output plop21-manuscript.tex
pandoc plop21-appendix.md --output plop21-appendix.tex
lualatex plop21-master
bibtex   plop21-master
lualatex plop21-master
lualatex plop21-master

open -a firefox plop21-master.pdf
