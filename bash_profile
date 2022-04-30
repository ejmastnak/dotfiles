# Source Bash login shell config
. "${HOME}/.config/bash/login.sh"

# Source Bash interactive shell config if this is an interactive shell
if [ "$PS1" ]; then
  . "${HOME}/.config/bash/interactive.sh"
fi
