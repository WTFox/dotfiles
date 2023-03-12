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
plugins=(git git-extras tmux macos extract vscode brew golang pipenv zsh-autosuggestions zsh-syntax-highlighting fzf)
source $ZSH/oh-my-zsh.sh

# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# Aliases
alias cls=clear
# Stopwatch
alias timer="/usr/bin/time -p $@"
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
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"
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
alias nvim="~/bin/nvim.appimage"
alias vim="nvim"
alias n.="nvim ."
alias zshconfig="vim ~/.zshrc"
alias loadnvm=". /usr/local/opt/nvm/nvm.sh"
alias exp="/mnt/c/Windows/explorer.exe"

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

#NVM
export NVM_DIR="$HOME/.nvm"

# PIPX
export PATH=$HOME/.local/bin/:$PATH

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
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage 
  echo "nvim installed!"
  popd
}

function install_rust() {
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup +nightly component add rust-analyzer-preview
}

function mount_Goodz() {
  sudo mount -t drvfs Z: /mnt/Goodz/
}

export GOPATH=$HOME/dev/go
export PYTHONBREAKPOINT=ipdb.set_trace

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
function load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# setxkbmap -option "ctrl:nocaps"

export PATH="$PATH:$HOME/bin:$HOME/.cargo/bin:$HOME/.cargo/env" 
export PATH=`echo $PATH | tr ':' '\n' | grep -v /mnt/ | tr '\n' ':'`

eval "$(starship init zsh)"
