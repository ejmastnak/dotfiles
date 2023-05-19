# Source generic login shell config
. "${HOME}/.config/shell/login.sh"

# Set history size
export HISTSIZE=10000

# Save history after logout
export SAVEHIST=10000

# History file
export HISTFILE=~/.zhistory

# Append into history file
setopt INC_APPEND_HISTORY

# Save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
