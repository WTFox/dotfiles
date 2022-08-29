#! /bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=~/dotfiles

# list of files/folders to symlink in homedir
files="bashrc zshrc p10k.zsh psqlrc gitaliases gitignore gitconfig tmux.conf tmux.conf.local prettierrc vimrc alacritty.yml"

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir || exit

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    ln -sf $dir/$file ~/.$file
done

ln -sf $dir/starship.toml ~/.config/

# hammerspoon
mkdir ~/.hammerspoon/
ln -s $dir/hammerspoon/init.lua ~/.hammerspoon/

# pgcli
mkdir -p ~/.config/pgcli/
ln -s $dir/pgcli/config ~/.config/pgcli/config

# karabiner elements
ln -s $dir/karabiner/ ~/.config/

# nvim
ln -s $dir/nvim/ ~/.config/
