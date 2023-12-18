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
	:
}

install_go() {
	# overriden in os files
	:
}

install_apps() {
	# overriden in os files
	:
}

install_fonts() {
	# overriden in os files
	:
}

install_git_and_gh() {
	# overriden in os files
	:
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
	local python_version=${1:-3.12.1}

	# Install pyenv dependencies
	install_pyenv_requirements

	# Install pyenv
	if ! command -v pyenv >/dev/null; then
		curl -s https://pyenv.run -o pyenv-installer.sh
		# Optionally inspect the script here
		zsh pyenv-installer.sh
		rm pyenv-installer.sh
	fi

	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"

	if ! pyenv versions | grep -q $python_version; then
		pyenv install $python_version
	fi

	pyenv global $python_version

	if ! pipx --version >/dev/null; then
		echo "pipx not found."

	else

		local utilities=(
			"autoflake8"
			"awscli"
			"bandit"
			"black"
			"cookiecutter"
			"flake8"
			"httpie"
			"isort"
			"mypy"
			"pgcli"
			"pipdeptree"
			"poetry"
			"pre-commit"
			"pylint"
			"ruff"
			"tox"
		)

		for utility in "${utilities[@]}"; do
			if ! pipx list | grep -q $utility; then
				pipx install $utility
			fi
		done
	fi

	echo "Python setup completed. Please add '$HOME/.local/bin' to your PATH if not already done."
}

uninstall_python_and_pyenv() {
	# Uninstall pipx utilities
	local utilities=(
		"autoflake8"
		"awscli"
		"bandit"
		"black"
		"cookiecutter"
		"flake8"
		"httpie"
		"isort"
		"mypy"
		"pgcli"
		"pipdeptree"
		"poetry"
		"pre-commit"
		"pylint"
		"ruff"
		"tox"
	)
	for utility in "${utilities[@]}"; do
		if pipx list | grep -q $utility; then
			pipx uninstall $utility
		fi
	done

	# Uninstall Python versions installed via pyenv
	if command -v pyenv >/dev/null; then
		for version in $(pyenv versions --bare --skip-aliases); do
			pyenv uninstall -f $version
		done
	fi

	# Remove pyenv
	rm -rf $HOME/.pyenv

	# Optional: Remove pyenv from shell configuration
	# Warning: This step may require manual intervention to safely edit .bashrc, .zshrc, etc.

	echo "Python and related utilities have been uninstalled."
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
