zinit light zsh-users/zsh-completions

# Load completions
autoload -U compinit && compinit

zstyle ':completion:*' mathcer-list 'm:{a-z}={A-Za-a}'
zstyle ':completion:*' menu no

zinit cdreplay -q
