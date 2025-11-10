#!/bin/bash

commands=()

if command -v cbonsai &>/dev/null; then
  commands+=("cbonsai -l -L 48 -M 4 --screensaver")
fi

if command -v cmatrix &>/dev/null; then
  commands+=("cmatrix -bsC blue")
fi

if [ ${#commands[@]} -gt 0 ]; then
  eval "${commands[$RANDOM % ${#commands[@]}]}"
else
  echo "No screensaver commands available"
fi
