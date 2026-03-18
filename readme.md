# .dotfiles

## install

[homebrew](https://brew.sh)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew install git go jq fastlane grc z python3 uv witr yarn nvm powerline-go

### tools

# ~/.tools
mkdir -p ~/.tools
cd ~/.tools

# install fonts
pip install --user powerline-status
git clone https://github.com/powerline/fonts.git
sudo ./fonts/install.sh

### oh-my-zsh

cd ~
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## configs

### links

cd ~
git clone git@github.com:jonogould/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/editorconfig/editorconfig ~/.editorconfig
```

## zsh

### recompile a zsh file

After editing a `.zsh` file, recompile it to regenerate the `.zwc` binary:

```sh
zcompile ~/.dotfiles/zsh/ai.zsh
```
