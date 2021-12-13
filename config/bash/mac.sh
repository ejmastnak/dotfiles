# About: this file holds shell configuration meant only for macOS
# because of differences between macOS and Linux as to where certain
# software is installed on the file system.

export BASH_SILENCE_DEPRECATION_WARNING=1

# BEGIN ADDITIONS TO PATH
# --------------------------------------------- #
# Homebrew packages
export PATH="/usr/local/bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"

# yarn
export PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"

# User bin folder
export PATH="${HOME}/bin:${PATH}"

# MEGAcmd
export PATH="/Applications/MEGAcmd.app/Contents/MacOS:${PATH}"

# Use GNU versions of grep and sed instead of BSD versions
PATH="/usr/local/opt/grep/libexec/gnubin:${PATH}"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}"
# --------------------------------------------- #
# END ADDITIONS TO PATH


# BEGIN ALIASES
# --------------------------------------------- #
alias python="/usr/local/bin/python3"
alias pip="/usr/local/bin/pip3"
# --------------------------------------------- #
# END ALIASES



# BEGIN BASH COMPLETIONS
# --------------------------------------------- #
# bash completion for pass
[ -r "/usr/local/etc/bash_completion.d/pass" ] && source "/usr/local/etc/bash_completion.d/pass"

# bash completion for git
[ -r "/usr/local/etc/bash_completion.d/git-completion.bash" ] && source "/usr/local/etc/bash_completion.d/git-completion.bash"

# bash completion for MEGAcmd
[ -r "/Applications/MEGAcmd.app/Contents/MacOS/megacmd_completion.sh" ] && source "/Applications/MEGAcmd.app/Contents/MacOS/megacmd_completion.sh"
# --------------------------------------------- #
# END BASH COMPLETIONS


# For ruby using chruby and ruby-install
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.7.4
