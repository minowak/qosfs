# QoSFS

Builds:
* master: ![Master Build](https://travis-ci.org/minowak/qosfs.svg?branch=master)
* develop: ![Develop Build](https://travis-ci.org/minowak/qosfs.svg?branch=develop)

Filesystem with Quality of Service support.

Written in C using FUSE.

### Project structure

![Project Structure](http://nvie.com/img/git-model@2x.png)

### Preparing project

## Necessary libraries

* FUSE Development library (libfuse-dev)

## Setting up VIM

As project is written in C, Vim was choosen as default development environment.
There is a vim configuration file in root directory - .vimrc.

To use this prepared vim configuration one should 
Add line below to main .vimrc file

```sh
set exrc*
```

Install Vundle

```sh
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Run vim from root directory and install plugins

```sh
$ vim
:PluginInstall
```

If there is a newer version of YouCompleteMe, update it

```sh
$ sudo apt-get install build-essential cmake
$ sudo apt-get install python-dev
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh --clang-completer
```

### External links

* FUSE (http://fuse.sourceforge.net/)
* Vim (http://www.vim.org/)
* Vundle (https://github.com/VundleVim/Vundle.vim)
* YouCompleteMe (https://github.com/Valloric/YouCompleteMe)
* NERDTree (https://github.com/scrooloose/nerdtree)
