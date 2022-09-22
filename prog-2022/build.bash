#!/usr/bin/env bash

set -euxo pipefail

pandoc prog22-manuscript.md --output prog22-manuscript.tex
pandoc prog22-alldims.md --output prog22-alldims.tex
pandoc prog22-appendix.md --output prog22-appendix.tex
lualatex prog22-master

if [ -z "${LITE:-}" ]; then
  bibtex   prog22-master
  lualatex prog22-master
  lualatex prog22-master
fi

open -a firefox prog22-master.pdf
