#!/bin/bash

directories_to_stow=(
	"audio/"
	"bashrc/"
	"bin/"
	"direnv/"
	"fonts/"
	"fzf/"
	"git/"
	"kitty/"
	"nvim/"
	"neofetch/"
	"pgcli/"
	"prettier/"
	"psql/"
	"pylint/"
	"starship/"
	"tmux/"
	"vscode-vim/"
	"yazi/"
	"zsh/"
)

mac_specific=(
	"hammerspoon/"
	"karabiner/"
)

if [[ "$OSTYPE" == "darwin"* ]]; then
	directories_to_stow+=("${mac_specific[@]}")
fi

stow -v -t "$HOME" "${directories_to_stow[@]}"
