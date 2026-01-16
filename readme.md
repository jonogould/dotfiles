# .dotfiles

## install

### homebrew

[homebrew](https://brew.sh)

```sh
brew update
brew install fish grc z python3

### tools

```sh
# ~/.tools
mkdir -p ~/.tools
cd ~/.tools

# install fonts
pip install --user powerline-status
git clone https://github.com/powerline/fonts.git
sudo ./fonts/install.sh
```

### oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### fish

```sh
sudo echo '/usr/local/bin/fish' >> /etc/shells
chsh -s /usr/local/bin/fish
```

### oh-my-fish

```sh
curl -L http://get.oh-my.fish | fish
omf install bobthefish sublime osx grc brew ssh ssh-term-helper z nvm
```

## configs

### links

```sh
cd ~
git clone git@github.com:jonogould/dotfiles.git .dotfiles
cd ~/.dotfiles

ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish

ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/editorconfig/editorconfig ~/.editorconfig
```
