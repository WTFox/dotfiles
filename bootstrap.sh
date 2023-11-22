#!/bin/bash

# Prompt for sudo password upfront and keep the sudo session alive for subsequent sudo commands
# While the script is running, refresh the sudo session in the background
echo "Please enter your sudo password for setup:"
sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

source ./_bootstrap/os/common.sh
osType=$(get_os_type)
source ./_bootstrap/os/${osType}.sh

update_package_manager
install_git_and_gh
install_direnv
install_starship
install_fzf
install_stow
install_dotfiles
install_zsh_and_oh_my_zsh
install_zoxide
install_python_and_pyenv
install_node_and_nvm
install_rust
install_go
install_nvim
install_apps

read -rp "Do you want to do configure git? (yes/no): " response
case $response in
[yY] | [yY][eE][sS])
	configure_git
	;;
*)
	echo "Not configuring git."
	;;
esac

chsh -s $(which zsh)
exec zsh -l
