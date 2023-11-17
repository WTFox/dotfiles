# == Linux-Specific Aliases ==

# == Kitty ==
# if platform is not wsl, set these aliases
if [[ ${WSL_DISTRO_NAME:-"False"} == "False" ]]; then
  alias kitty="kitty --single-instance"
  alias k="kitty"
  alias kdiff="kitty +kitten diff"
  alias kicat="kitty +kitten icat"
  alias kssh="kitty +kitten ssh"
else
  alias exp="/mnt/c/Windows/explorer.exe"
fi

# == System ==
alias localip="ipconfig getifaddr en0"
alias nvim="~/bin/nvim-linux64/bin/nvim"
