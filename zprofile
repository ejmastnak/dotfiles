# Source Zsh login shell config
. "${HOME}/.config/zsh/login.sh"

# Source Zsh interactive shell config if this is an interactive shell
if [ "$PS1" ]; then
  . "${HOME}/.config/zsh/interactive.sh"
fi
