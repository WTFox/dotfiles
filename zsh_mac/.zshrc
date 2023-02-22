export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Activate plugins
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(zsh-nvm git git-extras tmux macos extract vscode brew golang pipenv zsh-autosuggestions zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh

# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# Aliases
alias zshconfig="vim ~/.zshrc"
alias cls=clear
# Stopwatch
alias timer="/usr/bin/time -p $@"
# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'
# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"
# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias gap="git add -p"
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
alias gds="git diff --stat"
alias gst="git status --short --branch"
alias bc="bc -l"
alias rm="trash"
alias tmux="TERM=xterm-256color tmux -2"
alias df='df -H'
alias du='du -ch'
alias ducks='du -cksh * | sort -rh | head -11'
alias ls='exa -F --header --icons'
alias dc='docker-compose'
alias ql='qlmanage -p "$@" 2> /dev/null' # 'Quick look' on Mac OS
alias s3ls='aws s3 ls --summarize --human-readable'
alias gti='(scream &); git'
alias nvim="~/bin/nvim-macos/bin/nvim"
alias vim="nvim"
alias n.="nvim ."
alias loadnvm=". /usr/local/opt/nvm/nvm.sh"
alias d="kitty +kitten diff"
alias icat="kitty +kitten icat"
alias tldr="tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr"

bindkey -s ^f "tmux-sessionizer\n"

# create directories and cd to the first one
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# virtualenvs
export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(direnv hook zsh)"

# postgres
export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH

#NVM
export NVM_DIR="$HOME/.nvm"

# PIPX
export PATH=$HOME/.local/bin/:$PATH

function ghpr() {
  GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

function find_non_ascii() {
    cat $1 | rg -Upoe "[^\x00-\x7F]"
}

function toggleOnCall() {
  particle function call p1 toggleOnCall
}

function micLightsOn() {
  particle function call p2 digitalWrite D3=HIGH
}

function micLightsOff() {
  particle function call p2 digitalWrite D3=LOW
}

function ubuntu(){
  docker run -it -w '/entrypoint/' -v "$(pwd)":/entrypoint ubuntu:latest
}

function start_screen_share() {
    nohup vlc \
    --no-video-deco \
    --no-embedded-video \
    --screen-fps=20 \
    --screen-top=25 \
    --screen-left=1140 \
    --screen-width=2300 \
    --screen-height=1415 \
    screen:// \
    &
}

function stop_screen_share() {
    killall VLC
}

function install_nvim() {
  pushd ~/bin
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
  tar xzf nvim-macos.tar.gz
  echo "nvim installed!"
  popd
}

function install_rust() {
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup +nightly component add rust-analyzer-preview
}

fpath=(/usr/local/share/zsh-completions $fpath)

export GOPATH=$HOME/dev/go
export PYTHONBREAKPOINT=ipdb.set_trace

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# fzf
# set theme for fzf
export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$GOPATH/bin:$HOME/.dotnet/tools
export PATH=$HOME/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [ -e ~/.workrc ]
then
    source ~/.workrc
fi

if [ -e ~/.myrc.sh ]
then
    source ~/.myrc.sh
fi

export NVM_DIR="$HOME/.nvm"

export PATH="$PATH:$HOME/bin:$HOME/.cargo/bin:$HOME/.cargo/env" 

eval "$(starship init zsh)"

# Created by `pipx` on 2022-10-13 15:49:51
export PATH="$PATH:/Users/anthonyfox/Library/Python/3.10/bin"

  . /usr/local/opt/asdf/libexec/asdf.sh
