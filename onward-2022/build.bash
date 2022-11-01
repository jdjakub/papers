#!/usr/bin/env bash

set -euxo pipefail

pandoc manuscript.md --output onward22-manuscript.tex
pandoc appendix.md --output onward22-appendix.tex
lualatex onward22-master

# A quick cosmetic rebuild via
# $ LITE=y ./build.bash
# will skip the following steps
if [ -z "${LITE:-}" ]; then
  bibtex   onward22-master
  lualatex onward22-master
  lualatex onward22-master
fi

open -a firefox onward22-master.pdf
