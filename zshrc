# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.  # HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Activate plugins
plugins=(git git-extras tmux macos extract vscode brew ripgrep golang pipenv zsh-autosuggestions fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='lvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias git=hub
alias cls=clear
alias gissues="ghi list --mine -P --reverse --filter assigned"
alias howdoi="howdoi -n 5 -c"
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
alias gpr="git pull-request -F ~/.git-commit-template.txt -e"
alias bc="bc -l"
alias rm="trash"
alias tmux="TERM=xterm-256color tmux -2"
alias df='df -H'
alias du='du -ch'
alias ducks='du -cksh * | sort -rh | head -11'
alias ls='exa -F --header --git --icons'
alias dc='docker-compose'
alias ql='qlmanage -p "$@" 2> /dev/null' # 'Quick look' on Mac OS
alias s3ls='aws s3 ls --summarize --human-readable'
alias gti='(scream &); git'
alias vim="lvim"
alias n.="lvim ."

# create directories and cd to the first one
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# virtualenvs
export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(direnv hook zsh)"

# postgres
export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH

#NVM
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# PIPX
export PATH=$HOME/.local/bin/:$PATH

# simpler find
f() { find . -iname "*$1*"; }

# search up for a file
function upsearch () {
    found=$(test / == "$PWD" && return || test -e "$1" && echo "$PWD" && return || cd .. && upsearch "$1")
    echo $found
}

function find_non_ascii() {
    cat $1 | rg -Upoe "[^\x00-\x7F]"
}

function run() {
    number=$1
    shift
    for n in $(seq $number); do
      $@
    done
}

function b64decode() {
    base64 -d -i <(echo "$1")
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

function scream() {
    afplay -v 1.5 ~/dotfiles/audio/goat-scream.mp3
}

function ubuntu(){
  docker run -it -w '/entrypoint/' -v "$(pwd)":/entrypoint ubuntu:latest
}

function restartCameraProcess() {
    sudo killall VDCAssistant
    sudo killall AppleCameraAssistant
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

# --screen-left=574 \ # for middle-third

function stop_screen_share() {
    killall VLC
}

function howto() {
  cht.sh $@ | bat --paging 'always'
}

function install_lvim() {
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

if [ -e ~/.workrc ]
then
    source ~/.workrc
fi

if [ -e ~/.myrc.sh ]
then
    source ~/.myrc.sh
fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(/usr/local/share/zsh-completions $fpath)

# added by Snowflake SnowSQL installer v1.0
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# Go
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin:$HOME/.dotnet/tools

export PYTHONBREAKPOINT=ipdb.set_trace
export PATH=$HOME/bin:$PATH

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/p10k.zsh.
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh
# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
