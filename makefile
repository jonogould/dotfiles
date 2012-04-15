all:
	### Vim Config
	rm -rf ~/.vim && rm -f ~/.vimrc && rm -f ~/.gvimrc
	ln -s ~/dotfiles/vim ~/.vim && ln -s ~/dotfiles/vim/vimrc ~/.vimrc && ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc

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
