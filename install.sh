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
install_apps
install_python_and_pyenv
install_uv
install_node_and_nvm
install_rust
install_go
install_nvim

echo "All done! Please run configure_git manually." $green

if [ "$SHELL" != "$(which zsh)" ]; then
  # Replace the current chsh line with:
  if ! sudo chsh -s "$(which zsh)" "$USER"; then
    echo "Failed to change shell to zsh. Check if zsh is in /etc/shells"
    # Add zsh to /etc/shells if it's not there
    if ! grep -q "$(which zsh)" /etc/shells; then
      echo "Adding zsh to /etc/shells..."
      echo "$(which zsh)" | sudo tee -a /etc/shells
      # Try changing shell again
      sudo chsh -s "$(which zsh)" "$USER"
    fi
  fi
  echo "Shell changed to zsh. Please log out and log back in for changes to take effect."
else
  echo "zsh is already your default shell"
fi
