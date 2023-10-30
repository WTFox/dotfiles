#!/bin/bash

update_package_manager() {
	sudo pacman -Syu
	sudo pacman --noconfirm -S git curl wget coreutils
}

install_zsh_and_oh_my_zsh() {
	sudo pacman --noconfirm -S zsh
	install_oh_my_zsh
}

install_stow() {
	sudo pacman --noconfirm -S stow
}

install_kitty() {
	sudo pacman --noconfirm -S kitty
}

install_nvim() {
	pushd ~/bin || exit
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
	tar xzf nvim-linux64.tar.gz
	echo "nvim installed!"
	popd || exit
}

install_go() {
	sudo pacman --noconfirm -S go
}

install_apps() {
	# read packages from debian-apps.txt
	sudo pacman --noconfirm -S $(cat linux-apps.txt)

	sudo pacman --noconfirm -S github-cli lazygit eza fd
	go install github.com/jesseduffield/lazydocker@latest

	# tpm for tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_pyenv_requirements() {
	sudo pacman --noconfirm -S base-devel openssl libffi zlib bzip2 xz sqlite tk ncurses
}
