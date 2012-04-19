#!/bin/bash
rm -rf ~/.dotfiles
git clone git@github.com:wayneashleyberry/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule init && git submodule update
make
