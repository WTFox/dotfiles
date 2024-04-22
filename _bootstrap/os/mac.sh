#!/bin/bash

update_package_manager() {
	if ! command -v brew &>/dev/null; then
		echo "brew could not be found"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		brew update
	fi

	brew install coreutils git curl wget
}

install_zsh_and_oh_my_zsh() {
	brew install zsh
	install_oh_my_zsh
}

install_stow() {
	brew install stow
}

install_kitty() {
	brew install kitty
}

install_nvim() {
	pushd ~/bin || exit
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
	xattr -c ./nvim-macos-arm64.tar.gz
	tar xzf nvim-macos-arm64.tar.gz
	mv nvim-macos-arm64 nvim-macos
	echo "nvim installed!"
	popd || exit
}

install_apps() {
	xcode-select --install

	brew bundle

	# tpm for tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_git_and_gh() {
	brew "github/gh/gh"
	brew install git gh
}

install_fonts() {
	pushd ~/dotfiles/fonts/ || exit
	cp ~/dotfiles/fonts/*/*.ttf ~/Library/Fonts/
	cp ~/dotfiles/fonts/*/*.otf ~/Library/Fonts/
	popd || exit
}
