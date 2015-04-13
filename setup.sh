#!/bin/bash

# Setup symlinks in $HOME, overwriting existing stuff

for DOTFILE in \
    .bash_logout \
    .bash_profile \
    .bashrc \
    .inputrc \
    .ssh \
    .vim \
    .vimoutlinerrc \
    .vimrc
do
    ln -f -s -t $HOME dotfiles/$DOTFILE
done
