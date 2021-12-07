# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="nvim"
export PAGER="less"

# BEGIN OS DETECTION
# --------------------------------------------- #
os_linux=0
os_mac=1
os_other=2
if [ "$(uname)" == "Linux" ]  # Linux
then
  os_current=${os_linux}
elif [ "$(uname)" == "Darwin" ]  # macOS
then
  os_current=${os_mac}
else
  os_current=${os_other}
fi
# --------------------------------------------- #
# END OS DETECTION


# BEGIN ALIASES
# --------------------------------------------- #
# improved ls
alias l="exa"
alias L="exa -la"

# check if current shell is a login shell (for Alacritty)
alias sl="shopt | grep login"

# restart Bash
alias R="exec bash -l"

# alias path='tr ':' '\n' <<< "$PATH"'
# --------------------------------------------- #
# END ALIASES


# OS-SPECIFIC CONFIGURATION
# --------------------------------------------- #
if [ ${os_current} -eq ${os_mac} ]  # macOS
then
  [ -r "$HOME/.config/bash/mac.sh" ] && source "$HOME/.config/bash/mac.sh"
elif [ ${os_current} -eq ${os_linux} ]  # Linux
then
  [ -r "$HOME/.config/bash/linux.sh" ] && source "$HOME/.config/bash/linux.sh"
fi
# --------------------------------------------- #
# END OS-SPECIFIC CONFIGURATION
