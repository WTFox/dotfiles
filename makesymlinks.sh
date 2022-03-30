#! /bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=~/dotfiles

# old dotfiles backup directory
olddir=~/dotfiles_old

# list of files/folders to symlink in homedir
files="bashrc zshrc p10k.zsh psqlrc gitaliases gitignore gitconfig tmux.conf tmux.conf.local omnisharp git-commit-template.txt"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir || exit
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# copy over omnisharp
echo "Creating link to Omnisharp for C# linting"
ln -s ~/dotfiles/omnisharp.json ~/.omnisharp/omnisharp.json

# nvim
ln -s $dir/nvim/ ~/.config/

# hammerspoon
mkdir ~/.hammerspoon/
ln -s $dir/hammerspoon/init.lua ~/.hammerspoon/

# pgcli
mkdir -p ~/.config/pgcli/
ln -s $dir/pgcli/config ~/.config/pgcli/config

# karabiner elements
ln -s $dir/karabiner/ ~/.config/
