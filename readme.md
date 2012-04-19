## My Dotfiles

### One Line Install

Warning... This will remove all of your current dotfiles!

```
curl https://raw.github.com/wayneashleyberry/dotfiles/master/install.sh | sh
```

### More than one line install

```
cd ~
git clone git@github.com:wayneashleyberry/dotfiles.git
cd .dotfiles
git submodule init
git submodule update
```

You'll then need to link the files to your home directory

```
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
etc
```

# Git Workflow

*Branch - Hack - Ship - Done*

Inspired by [Dead Simple Git Workflow](http://jonrohan.me/guide/git/dead-simple-git-workflow-for-agile-teams/)

**Branch** ``` branch branchname ``` 

To checkout and create a new branch. Then work normally, using ``` git commit ```.

This is just a simple alias for ``` git checkout -b branchname ```

**Hack** ``` hack ```

Hack pulls the lastest code from the origin and merges it with your branch.
It's a good idea to do this often, just to keep everything up to date. 

**Ship** ``` ship ```

It's a good idea to run ``` hack ``` before ``` ship ``` to make sure you're up to date.
Ship will checkout the master merge my branch with it, and then push it to the origin.

**Done** ``` dwf ```

aka "Done With Feature", This will move you back to the master, and delete the old branch.

# Vim

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

#### Solarized

By default vim is set to use the Solarized theme, check it out [here](http://ethanschoonover.com/solarized)

For Terminal compatability, use the .terminal color schemes
