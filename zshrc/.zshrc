# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -U compinit && compinit

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zinit light g-plane/pnpm-shell-completion
zinit light zsh-users/zsh-syntax-highlighting
zinit light jessarcher/zsh-artisan

zstyle ':completion:*' mathcer-list 'm:{a-z}={A-Za-a}'
zstyle ':completion:*' menu no

zinit cdreplay -q

eval "$(zoxide init zsh)"

eval "$(fzf --zsh)"

zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export EDITOR=nvim
export VISUAL=${EDITOR}
export PATH="$HOME/.local/bin:$PATH"

# Add nvm
source /usr/share/nvm/init-nvm.sh


# Keybinds
bindkey -e
# bindkey ";3D" backward-word     # alt←
# bindkey ";3C" forward-word      # alt→
# bindkey ";9D" beginning-of-line # alt+←
# bindkey ";9C" end-of-line       # alt+→
bindkey "^[w" backward-delete-word # alt+w
# bindkey "^[u" undo # alt+u
# bindkey "^[r" redo # alt+r
bindkey "^[q" beginning-of-line # alt+q
bindkey "^[e" end-of-line # alt+e
bindkey "^[[A" history-beginning-search-backward # 
bindkey "^[[B" history-beginning-search-forward # 

# Options
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

WORDCHARS='_'

# aliases
alias cdd="cd ~/dd-dev/"
alias cdv="cd ~/Documents/ObsidianVault/md-vault/"
alias p=pnpm
alias g=git
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gst="git status"
alias gs="git switch"
alias gc="git commit"
alias gcm="git commit -m"
alias gm="git merge"
alias ga="git add"
alias gph="git push origin HEAD"

# Git diff
alias gd="git diff"
alias gds="git diff --staged"
alias gdst="git diff --stat --staged"

alias _git_current_branch="git rev-parse --abbrev-ref HEAD"
alias gpl='git pull origin $(_git_current_branch)'

alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l -g --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l -g --git -h'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l -g --git -h'
alias lls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --total-size -l -g --git -h'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l -a -g --git -h'

# Clean Arch Trash
alias clt='echo -n Taking out teh trash | pv -qL 10 && rm -rf  ~/.local/share/Trash/files' 

# Function to create a new branch with a specified format
function gcb() {
  local task_id="$1"
  local task_area="$2"
  shift 2
  local task_title="$*"
  local formatted_task_area="$(echo $task_area | tr ' ' '-' | sed 's/\b\(.\)/\u\1/g')"
  local formatted_branch_name="CU-${task_id}_${formatted_task_area}---$(echo $task_title | tr ' ' '-' | tr '[:upper:]' '[:lower:]')"
  git switch -c "$formatted_branch_name"
}

# Alias to call the function
alias gcb="gcb"


alias rcp="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1"
alias rmv="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files"

# Rsync Copy (cpr) - Works with Remote Paths
function rcp-remote() {
  local remote="$1"
  local host="$2"

  rsync --archive -hh --partial --stats --progress --modify-window=1 --exclude=node_modeles "${remote}" "${host}"
}

# Lazygit
alias gl='lazygit'

# Laravel
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# Docker
alias dsa='docker stop $(docker ps -q)'
alias ctop='docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest' 

# Zen profiles
# alias zdudnikgg='/usr/bin/zen-browser -P dudnikgg &>/dev/null &'
# alias zinnocode='/usr/bin/zen-browser -P innocode &>/dev/null &'
# alias zcodix='/usr/bin/zen-browser -P codix &>/dev/null &'

# Firefox profiles
alias fdudnikgg='/usr/bin/firefox -p dudnikgg &>/dev/null &'
alias finnocode='/usr/bin/firefox -p innocode &>/dev/null &'
alias fcodix='/usr/bin/firefox -p codix &>/dev/null &'

# Neovim
alias vi='nvim'

# Yazi CWD
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
path+=('/usr/bin/lazygit')
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
