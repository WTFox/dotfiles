#!/bin/bash

update_package_manager() {
	sudo apt-get update
	sudo apt-get -y install git curl wget coreutils
}

install_zsh_and_oh_my_zsh() {
	sudo apt-get install -y zsh
	install_oh_my_zsh
}

install_stow() {
	sudo apt-get install -y stow
}

install_kitty() {
	sudo apt-get install -y kitty
}

install_go() {
	sudo apt-get install -y golang-go
}

install_nvim() {
	pushd ~/bin || exit
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
	tar xzf nvim-linux64.tar.gz
	echo "nvim installed!"
	popd || exit
}

install_pyenv_requirements() {
	# prevent tzdata config popup
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
	sudo apt-get install -y make \
		build-essential \
		libssl-dev \
		zlib1g-dev \
		libbz2-dev \
		libreadline-dev \
		libsqlite3-dev \
		wget \
		curl \
		llvm \
		libncursesw5-dev \
		xz-utils \
		tk-dev \
		libxml2-dev \
		libxmlsec1-dev \
		libffi-dev \
		liblzma-dev
}

install_apps() {
	# read packages from debian-apps.txt
	sudo apt-get install -y $(cat linux-apps.txt)

	# install gh
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
		sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
		sudo apt update &&
		sudo apt install gh -y

	# lazygit
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	rm lazygit.tar.gz lazygit

	# lazydocker
	curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

	# eza and fd-find
	sudo apt install -y gpg
	sudo mkdir -p /etc/apt/keyrings
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt update
	sudo apt install -y eza fd-find

	# tpm for tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}
