# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# local bins
export PATH=$HOME/bin:$PATH
export PATH=$HOME/bin/nvim-linux64/bin/:$PATH
export PATH="$HOME/.local/bin:$PATH"

# set catppuccin theme for fzf
export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

# golang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# rust
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.cargo/env"
