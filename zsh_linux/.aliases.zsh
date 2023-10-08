# == AWS ==
alias s3ls='aws s3 ls --summarize --human-readable'

alias loadnvm=". /usr/local/opt/nvm/nvm.sh"

# == Date and Time ==
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'

# == Docker ==
alias dc='docker-compose'
alias dd='lazydocker'

# == Git ==
alias gap="git add -p"
alias gds="git diff --stat"
alias gg="lazygit"
alias gst="git status --short --branch"
alias gti='(scream &); git'

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

# == Networking ==
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"  # Show active network interfaces
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"  # public IP addresses
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias localip="ipconfig getifaddr en0"
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"  # View HTTP traffic

# == System ==
alias flushdns="dscacheutil -flushcache && killall -HUP mDNSResponder"  # Flush Directory Service cache
alias ls="exa --icons --group-directories-first --git --color=always"

# == Text Editors ==
alias nvim="~/bin/nvim-linux64/bin/nvim"
alias n.="nvim ."
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"

# == Utilities ==
alias bc="bc -l"
alias cls=clear
alias df='df -H'
alias du='du -ch'
alias ducks='du -cksh * | sort -rh | head -11'
alias path='echo -e ${PATH//:/\\n}'  # Print each PATH entry on a separate line
alias reload="exec $SHELL -l"

