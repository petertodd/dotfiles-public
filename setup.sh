#!/bin/bash

# Setup symlinks in $HOME, overwriting existing stuff

for DOTFILE in \
    .bash_logout \
    .bash_profile \
    .bashrc \
    .gitconfig \
    .gnupg \
    .inputrc \
    .ssh \
    .vim \
    .vimoutlinerrc \
    .vimrc
do
    ln -f -s -t $HOME dotfiles/$DOTFILE
done

# fix permissions; not recorded in git
chmod 700 .gnupg .ssh

# setup gpg
gpg --import < 7FAB114267E4FA04.asc
gpg --import-ownertrust default-ownertrust.txt
