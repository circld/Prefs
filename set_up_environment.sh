#!/bin/bash

# add vim plugins
./add_all_submodules.sh

# replace snippets with customs snippets
cp -f ~/Prefs/snippets/* ~/.vim/bundle/vim-snippets/snippets

# install silver-searcher (unix/linux)
sudo apt-get install silversearcher-ag

# add place-holder .vimrc if doesn't exist
if [ -e ~/.vimrc ] 
then
    echo ".vimrc exists; skipping .vimrc placeholder file creation step."
else
    echo "creating ~/.vimrc..."
    echo "source ~/Prefs/.vimrc" > ~/.vimrc
fi
