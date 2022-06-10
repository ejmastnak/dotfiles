#!/bin/sh
# A very simple shell script used to link my dotfiles into place. 
# Important: should be run from within my dotfiles directory.

BASEDIR="$(pwd)"

[ ! -d "${HOME}/.config" ]       && ln -s ${BASEDIR}/config ~/.config
[ ! -d "${HOME}/scripts" ]       && ln -s ${BASEDIR}/scripts ~/scripts
[ ! -d "${HOME}/.vim" ]          && ln -s ${BASEDIR}/vim ~/.vim
[ ! -e "${HOME}/.bash_profile" ] && ln -s ${BASEDIR}/bash_profile ~/.bash_profile
[ ! -e "${HOME}/.bashrc" ]       && ln -s ${BASEDIR}/bashrc ~/.bashrc
[ ! -e "${HOME}/.zprofile" ]     && ln -s ${BASEDIR}/zprofile ~/.zprofile
[ ! -e "${HOME}/.zshrc" ]        && ln -s ${BASEDIR}/zshrc ~/.zshrc
[ ! -e "${HOME}/.inputrc" ]      && ln -s ${BASEDIR}/inputrc ~/.inputrc
[ ! -e "${HOME}/.xinitrc" ]      && ln -s ${BASEDIR}/xinitrc ~/.xinitrc
[ ! -e "${HOME}/.xbindkeysrc" ]  && ln -s ${BASEDIR}/xbindkeysrc ~/.xbindkeysrc
[ ! -e "${HOME}/.gemrc" ]        && ln -s ${BASEDIR}/gemrc ~/.gemrc


# Clone Zsh autosuggestions if not already installed
if [ ! -d "${BASEDIR}/config/zsh/zsh-autosuggestions" ]
then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "${BASEDIR}/config/zsh/zsh-autosuggestions"

  # (Hacky) solution to avoid problems with Git submodules
  rm -r "${BASEDIR}/config/zsh/zsh-autosuggestions/.git"
fi
