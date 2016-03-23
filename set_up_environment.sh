#!/bin/bash

#### vim

# add vim plugins
./add_all_submodules.sh

# install fonts
sh ~/.vim/bundle/vim-airline-fonts/install.sh

# replace snippets with customs snippets
cp -f ~/Prefs/snippets/* ~/.vim/bundle/vim-snippets/snippets

# install silver-searcher (unix/linux)
sudo apt-get install silversearcher-ag

# add placeholder .vimrc if doesn't exist
if [ -e ~/.vimrc ] 
then
    echo ".vimrc exists; skipping .vimrc placeholder file creation step."
else
    echo "creating ~/.vimrc ..."
    echo "source ~/Prefs/.vimrc" > ~/.vimrc
fi

#### bash

# create .dotfiles directory if doesn't exist and add command_prompt.sh
if [ ! -d ~/.dotfiles ]
then
    mkdir ~/.dotfiles
fi
if [ ! -e ~/.dotfiles/command_prompt.sh ]
then
    curl -LSso ~/.dotfiles/command_prompt.sh https://raw.githubusercontent.com/cowboy/dotfiles/master/source/50_prompt.sh
fi

# add placeholder .bash_profile if doesn't exist
if [ -e ~/.bash_profile ] 
then
    echo ".bash_profile exists; skipping .bash_profile placeholder file creation step."
else
    echo "creating ~/.bash_profile ..."
    echo "source ~/Prefs/.bash_profile" > ~/.bash_profile
fi

# add placeholder .bashrc if doesn't exist
if [ -e ~/.bashrc ] 
then
    echo ".bashrc exists; skipping .bashrc placeholder file creation step."
else
    echo "creating ~/.bashrc ..."
    echo "source ~/Prefs/.bashrc" > ~/.bashrc
fi

# add placeholder .inputrc if doesn't exist
if [ -e ~/.inputrc ] 
then
    echo ".inputrc exists; skipping .inputrc placeholder file creation step."
else
    echo "creating ~/.inputrc ..."
    echo "\$include ~/Prefs/.inputrc" > ~/.inputrc
fi

# add placeholder .tmux.conf if doesn't exist
if [ -e ~/.tmux.conf ] 
then
    echo ".tmux.conf exists; skipping .tmux.conf placeholder file creation step."
else
    echo "creating ~/.tmux.conf ..."
    echo "source-file ~/Prefs/.tmux.conf" > ~/.tmux.conf
fi
