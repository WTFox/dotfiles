export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git gh extract zsh-autosuggestions zsh-syntax-highlighting fzf)
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
[ -f ~/.personal.zsh ] && source ~/.personal.zsh
[ -f ~/.work.zsh ] && source ~/.work.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"


function update_neofetch_cache() {
    local cache_file="$HOME/.cache/neofetch_output"
    local update_interval=86400  # Update interval in seconds (e.g., 86400 for 1 day)

    # Check if the cache file exists and is not too old
    if [[ ! -f "$cache_file" || $(($(date +%s) - $(date +%s -r "$cache_file"))) -gt $update_interval ]]; then
        neofetch > "$cache_file"
    fi

    cat "$cache_file"
}


update_neofetch_cache
