# aliases
alias cdd="cd ~/dd-dev/"
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

alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias lls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --total-size -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --total-size -a -l --git -h'

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
function cp-remote() {
  local remote="$1"
  local host="$2"

  rsync --archive -hh --partial --stats --progress --modify-window=1 --exclude=node_modeles "${remote}" "${host}"
}

# Rsync Move (mvr) - Works with Remote
# mvr() {
#  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$1"
# }
