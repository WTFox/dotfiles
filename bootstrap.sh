#!/bin/bash

install_git() {
  if ! command -v git &>/dev/null; then
    echo "Git not found. Installing git..."
    if [[ "$(uname)" == "Darwin" ]]; then
      if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      brew install git
    else
      # Linux
      sudo apt-get update
      sudo apt-get install -y git
    fi
  fi
}

setup_dotfiles() {
  local dotfiles_dir="$HOME/dotfiles"

  if [ ! -d "$dotfiles_dir" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/WTFox/dotfiles.git "$dotfiles_dir"
  else
    echo "Dotfiles directory exists, updating..."
    cd "$dotfiles_dir"
    git pull
  fi

  cd "$dotfiles_dir"

  # Run the main bootstrap script
  echo "Running main bootstrap script..."
  ./install.sh
  ./stow.sh
}

main() {
  install_git
  setup_dotfiles
}

main
