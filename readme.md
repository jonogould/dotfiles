# .dotfiles

## install

### fish

```sh
brew update
brew install fish grc z python3
sudo echo '/usr/local/bin/fish' >> /etc/shells
chsh -s /usr/local/bin/fish
```

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

### oh-my-fish

```sh
curl -L http://get.oh-my.fish | fish
omf install bobthefish sublime rbenv osx grc brew ssh ssh-term-helper z
```

## configs

### links

```sh
cd ~
git clone git@github.com:jonogould/dotfiles.git .dotfiles
cd ~/.dotfiles

ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish

ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/editorconfig/editorconfig ~/.editorconfig
```
