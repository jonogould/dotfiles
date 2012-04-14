#!/bin/bash
git clone https://github.com/wayneashleyberry/dotfiles ~/dotfiles
rm -f ~/.gitconfig
ln -s ~/dotfiles/gitconfig ~/.gitconfig
