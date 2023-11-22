#!/bin/bash

get_os_type() {
	osType=""
	if [[ "$OSTYPE" == "darwin"* ]]; then
		echo "mac"
	elif [[ -e "/etc/arch-release" ]]; then
		echo "arch"
	else
		# Import variables from /etc/os-release
		source /etc/os-release
		if [[ "$ID" == "pop" ]] || [[ "$ID_LIKE" == "debian" ]]; then
			echo "debian"
		else
			echo "Unsupported OS type."
			exit 1
		fi
	fi
}

install_pyenv_requirements() {
	# overriden in os files
	pass
}

install_go() {
	# overriden in os files
	pass
}

install_apps() {
	# overriden in os files
	pass
}

install_fonts() {
	# overriden in os files
	pass
}

install_git_and_gh() {
	# overriden in os files
	pass
}

install_dotfiles() {
	potential_conflicts=(
		"$HOME/.bashrc"
		"$HOME/.zshrc"
	)
	for file in "${potential_conflicts[@]}"; do
		if [[ -f "$file" ]]; then
			mv "$file" "$file.old"
		fi
	done

	./stow.sh
}

install_oh_my_zsh() {
	KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
}

install_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --key-bindings --completion --no-update-rc --no-zsh --no-bash
}

install_zoxide() {
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	eval "$(zoxide init zsh)"
}

install_python_and_pyenv() {
	install_pyenv_requirements
	curl https://pyenv.run | zsh
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	pyenv install 3.12.0
	pyenv global 3.12.0

	python3 -m pip install --upgrade pip
	python3 -m pip install --user pipx
	python3 -m pipx ensurepath

	# get pipx in PATH
	export PATH="$HOME/.local/bin:$PATH"

	pipx install poetry
	pipx install black
	pipx install flake8
	pipx install isort
	pipx install mypy
}

install_node_and_nvm() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	nvm install node
	nvm use node

	npm install -g yarn
	npm install -g typescript
	npm install -g typescript-language-server
	npm install -g eslint
	npm install -g prettier
	npm install -g bash-language-server
	npm install -g particle-cli
}

install_direnv() {
	curl -sfL https://direnv.net/install.sh | bash
}

install_starship() {
	curl -sS https://starship.rs/install.sh | sh -s -- -y
}

install_rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	source "$HOME/.cargo/env"

	# rust utilities
	if [[ "$osType" == "mac" ]]; then
		curl -LsSf https://get.nexte.st/latest/mac | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin
	else
		curl -LsSf https://get.nexte.st/latest/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin
	fi

	# utilities written in rust
	cargo install --locked --git https://github.com/sxyazi/yazi.git
}

configure_git() {
	gh auth login
	gh auth setup-git
	gh extension install github/gh-copilot
}
