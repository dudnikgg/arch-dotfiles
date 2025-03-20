# Created by newuser for 5.9
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Keybinds

bindkey ";3D" backward-word     # alt←
bindkey ";3C" forward-word      # alt→
bindkey ";9D" beginning-of-line # alt+←
bindkey ";9C" end-of-line       # alt+→
bindkey "^[w" backward-delete-word # alt+w
bindkey "^[u" undo # alt+u
bindkey "^[r" redo # alt+r
bindkey "^[a" beginning-of-line # alt+a
bindkey "^[e" end-of-line # alt+e

