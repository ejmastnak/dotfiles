# Additions to PATH
# --------------------------------------------- #
# For pip packages
export PATH="$HOME/.local/bin:${PATH}"

# For personal scripts
export PATH="$HOME/scripts:${PATH}"
# --------------------------------------------- #

# To add Ruby Gems to PATH
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# Environment variables
# --------------------------------------------- #
# For LilyPond inverse search
export LYEDITOR="nvr --servername=/tmp/lilypondsocket +%(line)s %(file)s"
# --------------------------------------------- #


# Aliases
# --------------------------------------------- #
alias sus="systemctl suspend"
# --------------------------------------------- #
