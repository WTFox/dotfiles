# == AWS ==
alias s3ls='aws s3 ls --summarize --human-readable'

# == Date and Time ==
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'

# == Docker ==
alias dc='docker-compose'

# == Git ==
alias gap="git add -p"
alias gds="git diff --stat"
alias gg="lazygit"
alias gst="git status --short --branch"
alias gti='(scream &); git'

# == Kitty ==
alias diff="kitty +kitten diff"
alias icat="kitty +kitten icat"
alias ssh="kitty +kitten ssh"

# == Networking ==
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"  # Show active network interfaces
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"  # public IP addresses
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias localip="ipconfig getifaddr en0"
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"  # View HTTP traffic

# == System ==
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"  # Lock the screen (when going AFK)
alias flushdns="dscacheutil -flushcache && killall -HUP mDNSResponder"  # Flush Directory Service cache
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"  # Hide hidden files
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"  # Hide desktop files
alias ls="exa --icons --group-directories-first --git --color=always"
alias rm="trash -v"
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"  # Show hidden files
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"  # Show desktop files
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# == Text Editors ==
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
alias ql='qlmanage -p "$@" 2> /dev/null' # 'Quick look' on Mac OS
alias reload="exec $SHELL -l"
