#!/bin/bash
# A very simple shell script used to link my dotfiles into place. 
# Important: should be run from within my dotfiles directory.

BASEDIR="$(pwd)"

# Long directories
[[ ! -d "${HOME}/.config" ]]       && ln -s ${BASEDIR}/config ~/.config || echo '~/.config exists; skipping and not overwriting.'
[[ ! -d "${HOME}/scripts" ]]       && ln -s ${BASEDIR}/scripts ~/scripts || echo '~/scripts exists; skipping and not overwriting.'
[[ ! -d "${HOME}/.vim" ]]          && ln -s ${BASEDIR}/vim ~/.vim || echo '~/.vim exists; skipping and not overwriting.'

# Link stand-alone files not in XDG_CONFIG
[[ ! -e "${HOME}/.bash_profile" ]] && ln -s ${BASEDIR}/bash_profile ~/.bash_profile || echo '~/.bash_profile exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.bashrc" ]]       && ln -s ${BASEDIR}/bashrc ~/.bashrc || echo '~/.bashrc exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.zprofile" ]]     && ln -s ${BASEDIR}/zprofile ~/.zprofile || echo '~/.zprofile exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.zshrc" ]]        && ln -s ${BASEDIR}/zshrc ~/.zshrc || echo '~/.zshrc exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.inputrc" ]]      && ln -s ${BASEDIR}/inputrc ~/.inputrc || echo '~/.inputrc exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.xinitrc" ]]      && ln -s ${BASEDIR}/xinitrc ~/.xinitrc || echo '~/.xinitrc exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.xbindkeysrc" ]]  && ln -s ${BASEDIR}/xbindkeysrc ~/.xbindkeysrc || echo '~/.xbindkeysrc exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.xmodmaprc" ]]  && ln -s ${BASEDIR}/xmodmaprc ~/.xmodmaprc || echo '~/.xmodmaprc exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.XCompose" ]]  && ln -s ${BASEDIR}/XCompose ~/.XCompose || echo '~/.XCompose exists; skipping and not overwriting.'
[[ ! -e "${HOME}/.gemrc" ]]        && ln -s ${BASEDIR}/gemrc ~/.gemrc || echo '~/.gemrc exists; skipping and not overwriting.'


# If using ZSH as login shell, clone Zsh autosuggestions if not already installed
if [[ "${SHELL}" == "/usr/bin/zsh" ]]; then
  if [[ ! -d "${BASEDIR}/config/zsh/zsh-autosuggestions" ]]
  then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "${BASEDIR}/config/zsh/zsh-autosuggestions"

    # (Hacky) solution to avoid problems with Git submodules
    rm -r "${BASEDIR}/config/zsh/zsh-autosuggestions/.git"
  fi
fi
