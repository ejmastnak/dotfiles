# Additions to PATH
# --------------------------------------------- #
# For pip packages
export PATH="$HOME/.local/bin:${PATH}"

# For personal scripts
export PATH="$HOME/scripts:${PATH}"

# Environment variables
# --------------------------------------------- #
# For LilyPond inverse search
export LYEDITOR="nvr --servername=/tmp/lilypondsocket +%(line)s %(file)s"

# export LYEDITOR="nvim %(file)s"
