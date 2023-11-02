export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git macos extract golang zsh-autosuggestions zsh-syntax-highlighting fzf)
fpath=(/usr/local/share/zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh

[ -f ~/.exports.zsh ] && source ~/.exports.zsh
[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh
[ -f ~/.functions.zsh ] && source ~/.functions.zsh
[ -f ~/.personal.zsh ] && source ~/.personal.zsh
[ -f ~/.work.zsh ] && source ~/.work.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/dotfiles/_bootstrap/os/common.sh
osType=$(get_os_type)
source $HOME/dotfiles/_bootstrap/os/${osType}.sh

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
