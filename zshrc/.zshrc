# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load the "init.sh".
source ~/zsh-configs/init.sh

# Find all .sh files, exclude "init.sh"
FILES_DIR=$(fd --glob '*.sh' --exclude 'init.sh' ~/zsh-configs)

# "tr" is a find-and-replace utility.
# Outer () will convert the output of $() to array.
FILES=($(echo $FILES_DIR | tr '\n' ' '))
for FILE in $FILES; do
  source $FILE
done

path+=('/home/dudnikgg/.local/bin')
export PATH="/home/dudnikgg/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/dudnikgg/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
