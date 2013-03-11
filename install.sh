#!/bin/bash
rm -rf ~/.dotfiles
git clone git@github.com:jonogould/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule init && git submodule update
make
