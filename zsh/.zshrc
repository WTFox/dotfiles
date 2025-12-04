export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git gh extract zsh-autosuggestions zsh-syntax-highlighting fzf direnv poetry universalarchive urltools eza autoupdate zsh-completions
)
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
    zle -I
    exec < /dev/tty
    temp_file="/tmp/yazi-cwd-$USER"
    yazi --cwd-file="$temp_file"
    if [ -f "$temp_file" ]; then
        cd "$(cat "$temp_file")"
        rm "$temp_file"
    fi
    zle reset-prompt
}
zle -N run_ya
bindkey "^O" run_ya

_run-tmux-sessionizer() {
    zle -I
    exec < /dev/tty
    ~/bin/tmux-sessionizer
}
zle -N _run-tmux-sessionizer
bindkey "^T" _run-tmux-sessionizer

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
