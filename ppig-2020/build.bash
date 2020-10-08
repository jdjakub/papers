#!/usr/bin/env bash

set -euo pipefail

pandoc ppig20-doctoral-consortium.md --output ppig20-doctoral-consortium.tex
lualatex ppig20-master
bibtex   ppig20-master
lualatex ppig20-master
lualatex ppig20-master

open -a firefox ppig20-master.pdf
