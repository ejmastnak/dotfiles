#!/bin/bash
# $HOME/dotfiles/install
# Shell script used to link my dotfiles into place. 
# Should be run from within my dotfiles directory.

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -s ${BASEDIR}/config ~/.config
ln -s ${BASEDIR}/bash_profile ~/.bash_profile
ln -s ${BASEDIR}/bashrc ~/.bashrc
