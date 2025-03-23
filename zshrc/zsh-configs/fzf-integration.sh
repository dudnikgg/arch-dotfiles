eval "$(fzf --zsh)"

zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
