#!/bin/bash

set -euo pipefail # Exit on error, undefined vars, and pipeline failures

# Colors for output
readonly GREEN='\033[0;32m'
readonly NC='\033[0m' # No Color

# Configuration
readonly DOTFILES_DIR="$HOME/dotfiles"
readonly DOTFILES_REPO="https://github.com/WTFox/dotfiles.git"

# Helper functions
log() {
  echo -e "${GREEN}$1${NC}"
}

maintain_sudo() {
  sudo -v
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
}

install_git() {
  if command -v git &>/dev/null; then
    return 0
  fi

  log "Git not found. Installing git..."
  if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
      log "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install git
  else
    sudo apt-get update
    sudo apt-get install -y git
  fi
}

setup_dotfiles() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    log "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  else
    log "Updating existing dotfiles..."
    (cd "$DOTFILES_DIR" && git pull)
  fi
}

configure_shell() {
  local zsh_path
  zsh_path="$(which zsh)"

  if [ "$SHELL" = "$zsh_path" ]; then
    log "zsh is already your default shell"
    return 0
  fi

  log "Changing default shell to zsh..."
  if ! grep -q "$zsh_path" /etc/shells; then
    log "Adding zsh to /etc/shells..."
    echo "$zsh_path" | sudo tee -a /etc/shells
  fi

  if ! sudo chsh -s "$zsh_path" "$USER"; then
    log "Failed to change shell to zsh"
    return 1
  fi

  log "Shell changed to zsh. Please log out and log back in for changes to take effect."
}

install_components() {
  local osType

  source ./_bootstrap/os/common.sh
  osType=$(get_os_type)
  source "./_bootstrap/os/${osType}.sh"

  # Install core components
  local components=(
    "update_package_manager"
    "install_git_and_gh"
    "install_direnv"
    "install_starship"
    "install_fzf"
    "install_stow"
    "install_dotfiles"
    "install_zsh_and_oh_my_zsh"
    "install_zoxide"
    "install_apps"
  )

  # Install programming languages and tools
  local dev_tools=(
    "install_python_and_pyenv"
    "install_uv"
    "install_node_and_nvm"
    "install_rust"
    "install_go"
    "install_nvim"
  )

  for component in "${components[@]}" "${dev_tools[@]}"; do
    log "Running $component..."
    $component
  done
}

main() {
  log "Please enter your sudo password for setup:"
  maintain_sudo

  install_git
  setup_dotfiles

  cd "$DOTFILES_DIR"
  install_components

  log "All done! Please run configure_git manually."
  configure_shell

  ./stow.sh
}

main
