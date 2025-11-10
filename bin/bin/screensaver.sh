#!/bin/bash

commands=()

if command -v cbonsai &>/dev/null; then
  commands+=("cbonsai -l -L 48 -M 4 --screensaver")
fi

if command -v cmatrix &>/dev/null; then
  commands+=("cmatrix -bsC blue")
fi

eval "${commands[$RANDOM % ${#commands[@]}]}"
