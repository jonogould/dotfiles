all:
	@echo 'Creating symlinks'
	@echo ''

	# Create temp folder
	@mkdir ~/.tmp

	# Vim Config
	rm -rf ~/.vim && rm -f ~/.vimrc && rm -f ~/.gvimrc
	ln -s ~/.dotfiles/vim ~/.vim && ln -s ~/.dotfiles/vim/vimrc ~/.vimrc && ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
	@echo ''

	# ZSH Config
	rm -f ~/.zshrc
	ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
	@echo ''

	# Git Config
	rm -f ~/.gitconfig
	ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
	@echo ''

	# Ack Config
	rm -f ~/.ackconfig
	ln -s ~/.dotfiles/ack/ackconfig ~/.ackconfig
	@echo ''

	# NERDTree Bookmarks
	rm -f ~/.NERDTreeBookmarks
	ln -s ~/.dotfiles/nerdtree/NERDTreeBookmarks ~/.NERDTreeBookmarks
	@echo ''

	# Sublime Config
	rm -f ~/Library/Application\ Support/Sublimt\ Text\ 2/
	ln -s ~/.dotfiles/sublime ~/Library/Application\ Support/Sublime\ Text\ 2/

	@echo 'done'
