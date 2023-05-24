export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git macos extract golang zsh-autosuggestions zsh-syntax-highlighting fzf)
source $ZSH/oh-my-zsh.sh

fpath=(/usr/local/share/zsh-completions $fpath)

# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# personal bins
export PATH=$HOME/bin:$PATH

# fzf
# set catppuccin theme for fzf
export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

# golang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# postgres
export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH

# pipx
export PATH=$HOME/.local/bin/:$PATH

# python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# ruby
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# rust
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.cargo/env" 

# virtualenvs
export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# yarn
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_functions ] && source ~/.zsh_functions
[ -f ~/.personal.zsh ] && source ~/.personal.zsh
[ -f ~/.work.zsh ] && source ~/.work.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
