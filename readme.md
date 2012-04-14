## My Dotfiles

### Getting Started

```
cd ~
git clone git@github.com:wayneashleyberry/dotfiles.git
cd dotfiles
git submodule init
git submodule update
```

You'll then need to link the files to your home directory

```
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
etc
```

### Git Workflow

*Branch - Hack - Ship - Done*

Inspired by [Dead Simple Git Workflow](http://jonrohan.me/guide/git/dead-simple-git-workflow-for-agile-teams/)

**Branch** ``` branch branchname ``` 

To checkout and create a new branch. Then work normally, using ``` git commit ```.

This is just a simple alias for ``` git checkout -b branchname ```

**Hack** ``` hack ```

Hack is what it's called when you pull the lastest code from the origin and merge it with your branch.
It's a good idea to do this often, just to keep everything up to date. 

**Ship** ``` ship ```

It's a good idea to run ``` hack ``` before ``` ship ``` to make sure you're up to date.
Ship will checkout the master merge my branch with it, and then push it to the origin.

**Done** ``` dwf ```

aka "Done With Feature", This will move you back to the master, and delete the old branch.

### Vim

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
