#!/bin/bash

directories_to_stow=(
  "audio/"
  "bashrc/"
  "bin/"
  "claude"
  "direnv/"
  "fonts/"
  "fzf/"
  "git/"
  "ghostty/"
  "helix/"
  "nvim/"
  "nvim-old/"
  "starship/"
  "tmux/"
  "wezterm/"
  "yazi"
  "zsh/"
)

mac_specific=(
  "hammerspoon/"
)

if [[ "$OSTYPE" == "darwin"* ]]; then
  directories_to_stow+=("${mac_specific[@]}")
fi

stow -v -t "$HOME" "${directories_to_stow[@]}"
