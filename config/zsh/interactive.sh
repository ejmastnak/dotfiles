# Source generic interactive shell config
. "${HOME}/.config/shell/interactive.sh"

# Lines added by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines added by zsh-newuser-install

# Enable completion
zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit
# Refresh zcompdump only once per day
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
  touch ~/.zcompdump
else
  compinit -C
fi


# Set vi mode and configure cursor
# Source https://github.com/lervag/dotfiles/blob/2e9a760897d5246c0f02e30c997b23f3894c688d/zsh/.zshrc#L241
# --------------------------------------------- #
bindkey -v

export KEYTIMEOUT=15
insertmode () {
  print -n '\e]12;#cccccc\a'
  print -n '\e[6 q'
}
normalmode () {
  print -n '\e]12;#e5e9f0\a'
  print -n '\e[2 q'
}

# Update cursor when changing vi mode
if [[ ! "$TERM" =~ 'linux' ]]; then
  function zle-line-init zle-keymap-select {
    case $KEYMAP in
      (vicmd)      normalmode;;
      (viins|main) insertmode;;
    esac
  }
  zle -N zle-line-init
  zle -N zle-keymap-select
fi
# --------------------------------------------- #

# Configure Zsh autosuggestion features
# --------------------------------------------- #
if [ -d "${HOME}/.config/zsh/zsh-autosuggestions" ]
then
  source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

  # Accept current suggestion with <Ctrl>-<Space>
  bindkey '^ ' autosuggest-accept

  # Use history and completion for suggestions
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)

fi
# --------------------------------------------- #
