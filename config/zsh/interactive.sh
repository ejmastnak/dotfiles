# Source generic interactive shell config
. "${HOME}/.config/shell/interactive.sh"

# Lines added by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
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
