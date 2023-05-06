# Source generic interactive shell config
. "${HOME}/.config/shell/interactive.sh"

# Bash-specific aliases
# --------------------------------------------- #
# Restart Bash
alias R="exec bash -l"
# --------------------------------------------- #

# Bash completions
# --------------------------------------------- #
source ${HOME}/.config/himalaya/himalaya-completions.bash
# --------------------------------------------- #

# Use VI keybindings in the Bash shell
set -o vi
