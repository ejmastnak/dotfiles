#!/bin/sh
# A very simple shell script used to link my dotfiles into place. 
# Important: should be run from within my dotfiles directory.

BASEDIR="$(pwd)"

[ ! -d "${HOME}/.config" ] && ln -s ${BASEDIR}/config ~/.config
[ ! -d "${HOME}/.vim" ]          && ln -s ${BASEDIR}/vim ~/.vim
[ ! -e "${HOME}/.bash_profile" ] && ln -s ${BASEDIR}/bash_profile ~/.bash_profile
[ ! -e "${HOME}/.bashrc" ]       && ln -s ${BASEDIR}/bashrc ~/.bashrc
[ ! -e "${HOME}/.zprofile" ]     && ln -s ${BASEDIR}/zprofile ~/.zprofile
[ ! -e "${HOME}/.zshrc" ]        && ln -s ${BASEDIR}/zshrc ~/.zshrc
[ ! -e "${HOME}/.inputrc" ]      && ln -s ${BASEDIR}/inputrc ~/.inputrc
[ ! -e "${HOME}/.xinitrc" ]      && ln -s ${BASEDIR}/xinitrc ~/.xinitrc
[ ! -e "${HOME}/.xbindkeysrc" ]  && ln -s ${BASEDIR}/xbindkeysrc ~/.xbindkeysrc
[ ! -e "${HOME}/.gemrc" ]        && ln -s ${BASEDIR}/gemrc ~/.gemrc
