#!/usr/bin/env bash

set -euxo pipefail

pandoc manuscript.md --output onward22-manuscript.tex
pandoc appendix.md --output onward22-appendix.tex
lualatex onward22-master

if [ -z "${LITE:-}" ]; then
  bibtex   onward22-master
  lualatex onward22-master
  lualatex onward22-master
fi

open -a firefox onward22-master.pdf
