export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git gh extract zsh-autosuggestions zsh-syntax-highlighting fzf direnv poetry universalarchive urltools eza)
fpath=(/usr/local/share/zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh

source $HOME/dotfiles/_bootstrap/os/common.sh
osType=$(get_os_type)
source $HOME/dotfiles/_bootstrap/os/${osType}.sh

[ -f ~/.exports.zsh ] && source ~/.exports.zsh
[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh
[ -f ~/.functions.zsh ] && source ~/.functions.zsh

if [[ "$osType" == "mac" ]]; then
  [ -f ~/.aliases_mac.zsh ] && source ~/.aliases_mac.zsh
  [ -f ~/.exports_mac.zsh ] && source ~/.exports_mac.zsh
  [ -f ~/.functions_mac.zsh ] && source ~/.functions_mac.zsh
	else
  [ -f ~/.aliases_linux.zsh ] && source ~/.aliases_linux.zsh
  [ -f ~/.exports_linux.zsh ] && source ~/.exports_linux.zsh
  [ -f ~/.functions_linux.zsh ] && source ~/.functions_linux.zsh
fi

# pc-specific files that are git-ignored:
[ -f ~/.local.zsh ] && source ~/.local.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

_run-cdi() {
    local dir="$(eval "zoxide query -i")"
    if [[ -z "$dir" ]]; then
        zle redisplay
        return 0
    fi
    zle push-line
    BUFFER="builtin cd -- ${(q)dir}"
    zle accept-line
    local ret=$?
    unset dir
    zle reset-prompt
    return $ret
}
zle -N _run-cdi
bindkey "^G" _run-cdi

run_ya() {
    zle reset-prompt
    ya
}
zle -N run_ya
bindkey "^O" run_ya

# Emit the OSC 133 prompt sequences
precmd() {
  echo -ne "\e]133;A\e\\"
}

preexec() {
  echo -ne "\e]133;B\e\\"
}

zle-line-init() {
  echo -ne "\e]133;C\e\\"
}

zle-line-finish() {
  echo -ne "\e]133;D\e\\"
}

zle -N zle-line-init
zle -N zle-line-finish

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
