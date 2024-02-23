# Define and export environment variables
# --------------------------------------------- #
export EDITOR="nvim"
export PAGER="less"

# Tell GPG which tty to read input from during credential verification
export GPG_TTY=$(tty)

# For LilyPond inverse search
export LYEDITOR="nvr --servername=/tmp/lilypondsocket +%(line)s %(file)s"

# Path to my music library database
export MUSIC_LIBRARY_DB="${HOME}/Music/library/.sqlite/library.sqlite"
export MUSIC_LIBRARY_ROOT="${HOME}/Music/library"
# --------------------------------------------- #

# Additions to PATH
# --------------------------------------------- #
# Python modules installed by Pip
export PATH="${PATH}:${HOME}/.local/bin"

# Personal scripts
export PATH="${PATH}:${HOME}/scripts"

# Beancount conversion scripts
export PATH="${PATH}:${HOME}/Documents/finances/scripts/src"
# --------------------------------------------- #

# User-local node module directory
NODE_MODULES="${HOME}/.node_modules"
export NODE_PATH="${NODE_MODULES}/lib/node_modules:${NODE_PATH}"
export PATH="${PATH}:${NODE_MODULES}/bin"
export MANPATH="${NODE_MODULES}/share/man:$(manpath)"
