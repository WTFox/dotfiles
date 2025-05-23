# == Linux-Specific Exports ==

export PATH=$PATH:/snap/bin
export PATH="$HOME/bin/nvim-linux64/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin


if type nvm > /dev/null 2>&1; then
    return
fi
export NVM_DIR="$HOME/.nvm"

[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
