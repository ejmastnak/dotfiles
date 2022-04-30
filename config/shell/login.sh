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

# Julia language
export PATH="${PATH}:$HOME/src/julia-1.7.2/bin"
# --------------------------------------------- #


# Manage Ruby version with chruby
# --------------------------------------------- #
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.7.4
# --------------------------------------------- #
