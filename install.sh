#!/bin/bash
rm -rf ~/dotfiles
git clone git@github.com:wayneashleyberry/dotfiles.git ~/dotfiles
cd ~/dotfiles
git submodule init && git submodule update

### Vim Config
rm -rf ~/.vim && rm -f ~/.vimrc && rm -f ~/.gvimrc
ln -s ~/dotfiles/vim ~/.vim && ln -s ~/dotfiles/vimrc ~/.vimrc && ln -s ~/dotfiles/gvimrc ~/.gvimrc

### ZSH Config
rm -f ~/.zshrc
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc

### Git Config
rm -f ~/.gitconfig
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig

### Ack Config
rm -f ~/.ackconfig
ln -s ~/dotfiles/ack/ackconfig ~/.ackconfig

### NERDTree Bookmarks
rm -f ~/.NERDTreeBookmarks
ln -s ~/dotfiles/nerdtree/NERDTreeBookmarks ~/.NERDTreeBookmarks
