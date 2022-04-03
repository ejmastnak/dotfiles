# Additions to PATH
# --------------------------------------------- #
# For pip packages
export PATH="$HOME/.local/bin:${PATH}"

# For personal scripts
export PATH="$HOME/scripts:${PATH}"
# --------------------------------------------- #

# Manage Ruby version with chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.7.4

# To add Ruby Gems to PATH
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# export PATH="$PATH:$GEM_HOME/bin"

# Environment variables
# --------------------------------------------- #
# For LilyPond inverse search
export LYEDITOR="nvr --servername=/tmp/lilypondsocket +%(line)s %(file)s"
# --------------------------------------------- #

# Completion
source ${HOME}/.config/himalaya/himalaya-completions.bash

# Aliases
# --------------------------------------------- #
alias sus="systemctl suspend"
alias s="systemctl"
alias backup_documents="rclone sync -v --filter-from ~/.config/rclone/filter.txt /home/ej/Documents/ google-drive:Documents/"
# --------------------------------------------- #
