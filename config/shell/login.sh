# Define and export environment variables
# --------------------------------------------- #
export EDITOR="nvim"
export PAGER="less"

# Tell GPG which tty to read input from during credential verification
export GPG_TTY=$(tty)

# For LilyPond inverse search
export LYEDITOR="nvr --servername=/tmp/lilypondsocket +%(line)s %(file)s"
# --------------------------------------------- #

# Additions to PATH
# --------------------------------------------- #
# Python modules installed by Pip
export PATH="${PATH}:$HOME/.local/bin"

# Personal scripts
export PATH="${PATH}:$HOME/scripts"
# --------------------------------------------- #

# User-local node module directory
NODE_MODULES="${HOME}/.node_modules"
export NODE_PATH="${NODE_MODULES}/lib/node_modules:${NODE_PATH}"
export PATH="${PATH}:${NODE_MODULES}/bin"
export MANPATH="${NODE_MODULES}/share/man:$(manpath)"

# Configuration for pyenv
# --------------------------------------------- #
export PYENV_ROOT="${HOME}/.pyenv"
command -v pyenv >/dev/null || export PATH="${PATH}:${PYENV_ROOT}/bin"

# Install pyenv into shell
eval "$(pyenv init -)"
# --------------------------------------------- #

# Set Ruby version with chruby
# --------------------------------------------- #
if [[ -e "/usr/local/share/chruby/chruby.sh" && -e "/usr/local/share/chruby/auto.sh" ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-3.1.0
fi
# --------------------------------------------- #
