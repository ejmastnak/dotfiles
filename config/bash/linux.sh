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

# Manage Ruby version with chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.7.4

# Environment variables
# --------------------------------------------- #
# For LilyPond inverse search
export LYEDITOR="nvr --servername=/tmp/lilypondsocket +%(line)s %(file)s"
# --------------------------------------------- #


# Aliases
# --------------------------------------------- #
alias sus="systemctl suspend"
# --------------------------------------------- #
