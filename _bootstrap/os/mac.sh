#!/bin/bash

update_package_manager() {
  if ! command -v brew &>/dev/null; then
    echo "brew could not be found"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  sudo mkdir -p "/usr/local/bin/"

  brew update
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

install_apps() {
  xcode-select --install || true

  brew bundle
}

install_git_and_gh() {
  brew install git gh
}

install_fonts() {
  pushd ~/dotfiles/fonts/ || exit
  cp ~/dotfiles/fonts/*/*.ttf ~/Library/Fonts/
  cp ~/dotfiles/fonts/*/*.otf ~/Library/Fonts/
  popd || exit
}
