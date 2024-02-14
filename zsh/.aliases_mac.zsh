# == macOS-Specific Aliases ==

# == System ==

alias afk="open -a ScreenSaverEngine"
alias flushdns="dscacheutil -flushcache && killall -HUP mDNSResponder"  # Flush Directory Service cache
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"  # Hide hidden files
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"  # Hide desktop files
alias ls="eza --icons --group-directories-first --git --color=always"
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"  # Show hidden files
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"  # Show desktop files
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# == Fun ==

alias scream="afplay -v 0.2 ~/audio/goat-scream.mp3"
alias attenzione="afplay -v 0.2 ~/audio/attenzione.mp3"
alias gti='(scream &); git'

