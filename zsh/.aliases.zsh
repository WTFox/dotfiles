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
alias branch="git branch | grep -v \"^\*\" | fzf --height=20% --reverse --info=inline | xargs git switch"

# == Networking ==
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"  # Show active network interfaces
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"  # public IP addresses
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# == Python ==
alias notebook="uvx --from jupyter-core --with jupyter --with pandas jupyter-lab"

# == Wezterm ==
alias icat="wezterm imgcat"

# == Text Editors ==
alias n.="nvim ."
alias v="vim"
alias v.="vim ."
alias lazy_sync='nvim --headless "+Lazy! sync" +qa'
alias lazy_restore='nvim --headless "+Lazy! restore" +qa'
alias vim="nvim"
alias vimdiff="nvim -d"
alias zshconfig="nvim ~/.zshrc"

# == Utilities ==
alias bc="bc -l"
alias cls=clear
alias df='df -H'
alias du='du -ch'
alias ducks='du -cksh * | sort -rh | head -11'
alias j="z"
# alias ll="eza -gl --group-directories-first"
alias path='echo -e ${PATH//:/\\n}'  # Print each PATH entry on a separate line
alias v="vim"
alias reload="exec $SHELL -l"
