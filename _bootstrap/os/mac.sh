#!/bin/bash

update_package_manager() {
  if ! command -v brew &>/dev/null; then
    echo "brew could not be found"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

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

install_nvim() {
  pushd ~/bin || exit
  echo "downloading"
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
  xattr -c ./nvim-macos-arm64.tar.gz
  if [ $? -eq 0 ]; then rm -rf nvim-macos; fi
  tar xzf nvim-macos-arm64.tar.gz
  mv nvim-macos-arm64 nvim-macos
  echo "cleaning up "
  rm -rf nvim-macos-arm64
  rm nvim-macos-arm64.tar.gz
  echo "nvim installed!"
  popd || exit
}

install_apps() {
  xcode-select --install

  brew bundle

  # tpm for tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_git_and_gh() {
  brew "github/gh/gh"
  brew install git gh
}

install_fonts() {
  pushd ~/dotfiles/fonts/ || exit
  cp ~/dotfiles/fonts/*/*.ttf ~/Library/Fonts/
  cp ~/dotfiles/fonts/*/*.otf ~/Library/Fonts/
  popd || exit
}
