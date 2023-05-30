#!/bin/bash

# This is a shell script that will be ran on the host machine to setup the
# development environment for the project. This script should be written
# as idempotent as possible.

function install_brew {
	if ! command -v brew >/dev/null 2>&1; then
		echo "Installing brew..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	# brew bundle --file=_bootstrap/Brewfile
	# brew cleanup
	# $(brew --prefix)/opt/fzf/install
}

function install_global_python_packages {
	pipx install pylint
	pipx install flake8
	pipx install black
	pipx install glances
	pipx install neovim
}

function install_global_npm_packages {
	npm install -g particle-cli
	npm install -g create-react-app
	npm install -g create-react-library
	npm install -g yarn
	npm install -g eslint
	npm install -g babel-eslint
	npm install -g eslint-config-standard
	npm install -g eslint-config-standard-react
	npm install -g eslint-config-standard-jsx
	npm install -g eslint-plugin-react
	npm install -g eslint-config-prettier
	npm install -g eslint-plugin-prettier
	npm install -g prettier
	npm install -g standard
	npm install -g typescript
}

function install_pyenv {
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
}

function install_zsh {
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		echo "Installing oh-my-zsh..."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	fi
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function update_xcode {
	xcode-select --install
}

function install_tmux_plugins {
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function update_and_restart {
	echo -n "Check for and install available OSX updates, install, and automatically restart? (y/n)? "
	read response
	if [ "$response" != "${response#[Yy]}" ]; then
		softwareupdate -i -a --restart
	fi
}

function obtain_sudo {
	# Here we go.. ask for the administrator password upfront and run a
	# keep-alive to update existing `sudo` time stamp until script has finished
	sudo -v
	while true; do
		sudo -n true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
}

function setup_ssh {
	#############################################
	### Generate ssh keys & add to ssh-agent
	### See: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
	#############################################

	echo "Generating ssh keys, adding to ssh-agent..."
	read -p 'Input email for ssh key: ' useremail

	echo "Use default ssh file location, enter a passphrase: "
	ssh-keygen -t rsa -b 4096 -C "$useremail" # will prompt for password
	eval "$(ssh-agent -s)"

	# Now that sshconfig is synced add key to ssh-agent and
	# store passphrase in keychain
	ssh-add -K ~/.ssh/id_rsa

	# If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config file to automatically load keys into the ssh-agent and store passphrases in your keychain.
	if [ -e ~/.ssh/config ]; then
		echo "ssh config already exists. Skipping adding osx specific settings... "
	else
		echo "Writing macos specific settings to ssh config... "
		cat <<EOT >>~/.ssh/config
	Host *
		AddKeysToAgent yes
		UseKeychain yes
		IdentityFile ~/.ssh/id_rsa
EOT
	fi

	#############################################
	### Add ssh-key to GitHub via api
	#############################################

	echo "Adding ssh-key to GitHub (via api)..."
	echo "Important! For this step, use a github personal token with the admin:public_key permission."
	echo "If you don't have one, create it here: https://github.com/settings/tokens/new"

	retries=3
	SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

	for ((i = 0; i < retries; i++)); do
		read -p 'GitHub username: ' ghusername
		read -p 'Machine name: ' ghtitle
		read -sp 'GitHub personal token: ' ghtoken

		gh_status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -u "$ghusername:$ghtoken" -d '{"title":"'$ghtitle'","key":"'"$SSH_KEY"'"}' 'https://api.github.com/user/keys')

		if (($gh_status_code - eq == 201)); then
			echo "GitHub ssh key added successfully!"
			break
		else
			echo "Something went wrong. Enter your credentials and try again..."
			echo -n "Status code returned: "
			echo $gh_status_code
		fi
	done

	[[ $retries -eq i ]] && echo "Adding ssh-key to GitHub failed! Try again later."
}

function main {
	obtain_sudo
	install_brew
	install_zsh
	setup_ssh
	update_xcode
	install_pyenv
	install_global_python_packages
}

main
