#!/usr/bin/env bash

set -euo pipefail

pandoc plop21-manuscript.md --output plop21-manuscript.tex
lualatex plop21-master
bibtex   plop21-master
lualatex plop21-master
lualatex plop21-master

open -a firefox plop21-master.pdf
