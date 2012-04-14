### My Dotfiles

#### Getting Started

```
cd ~
git clone git@github.com:wayneashleyberry/dotfiles.git
cd dotfiles
git submodule init
git submodule update
```

#### Creating Symlinks

```
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
etc
```

#### Installing new vim plugins:
	
```
cd ~/dotfiles
git submodule add <URL> vim/bundle/plugin-name
```

#### Updating vim plugins:
	
```
cd ~/dotfiles
git submodule init
git submodule update
```
