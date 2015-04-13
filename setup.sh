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

# setup gpg
gpg --import-ownertrust default-ownertrust.txt
gpg --recv-key 7FAB114267E4FA04
