zinit light zsh-users/zsh-completions
zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zinit light g-plane/pnpm-shell-completion

# Load completions
autoload -U compinit && compinit

zstyle ':completion:*' mathcer-list 'm:{a-z}={A-Za-a}'
zstyle ':completion:*' menu no

zinit cdreplay -q
