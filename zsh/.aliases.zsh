# == Common Aliases ==

# == AWS ==
alias s3ls='aws s3 ls --summarize --human-readable'

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
alias "gh?"="gh copilot"

# == Networking ==
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"  # Show active network interfaces
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"  # public IP addresses
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# == System ==
alias ls="eza --icons --group-directories-first --git --color=always"

# == Kitty ==
alias k="kitty"
alias kdiff="kitty +kitten diff"
alias kicat="kitty +kitten icat"
alias kssh="kitty +kitten ssh"

# == Text Editors ==
alias n.="nvim ."
alias lazy_sync='nvim --headless "+Lazy! sync" +qa'
alias lazy_restore='nvim --headless "+Lazy! restore" +qa'
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"

# == Utilities ==
alias bc="bc -l"
alias cls=clear
alias df='df -H'
alias du='du -ch'
alias ducks='du -cksh * | sort -rh | head -11'
alias gdu="gdu-go"
alias j="z"
alias path='echo -e ${PATH//:/\\n}'  # Print each PATH entry on a separate line
alias reload="exec $SHELL -l"
