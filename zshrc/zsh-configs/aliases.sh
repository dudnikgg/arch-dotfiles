# aliases
alias cdd="cd ~/dev/"
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

alias _git_current_branch="git rev-parse --abbrev-ref HEAD"
alias gpl='git pull origin $(_git_current_branch)'

alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'

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
