#!/usr/bin/env bash

set -euo pipefail

pandoc prog22-manuscript.md --output prog22-manuscript.tex
pandoc prog22-appendix.md --output prog22-appendix.tex
lualatex prog22-master

echo gonna check for lite now.
#if [[ -z "$LITE" ]]; then
  bibtex   prog22-master
  lualatex prog22-master
  lualatex prog22-master
#fi

echo gonna try and open the file now.
open -a firefox prog22-master.pdf
