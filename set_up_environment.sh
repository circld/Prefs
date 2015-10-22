#!/bin/bash

# add vim plugins
./add_all_submodules.sh

# replace snippets with customs snippets
./replace_snippets.sh

# install silver-searcher (unix/linux)
apt-get install silversearcher-ag

# add place-holder .vimrc if doesn't exist
if [ -e ~/.vimrc ]
then
    echo ".vimrc exists; skipping .vimrc placeholder file creation step."
else
    echo "source ~/Prefs/.vimrc" > ~/.vimrc
fi
