#!/bin/bash

# install pathogen
# mkdir -p ~/.vim/autoload ~/.vim/bundle && \
# curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle
cd ~/.vim && git init
git submodule add https://github.com/tpope/vim-pathogen bundle/vim-pathogen
ln -s ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim

# install vim plugins
git submodule add https://github.com/klen/python-mode bundle/python-mode
git submodule add https://github.com/tpope/vim-fugitive.git bundle/fugitive
git submodule add https://github.com/tpope/vim-surround.git bundle/surround
git submodule add https://github.com/tpope/vim-git.git bundle/git
git submodule add https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim
git submodule add https://github.com/mitechie/pyflakes-pathogen.git
git submodule add https://github.com/sjl/gundo.vim.git bundle/gundo
git submodule add https://github.com/fs111/pydoc.vim.git bundle/pydoc
git submodule add https://github.com/vim-scripts/pep8.git bundle/pep8
git submodule add https://github.com/alfredodeza/pytest.vim.git bundle/py.test
git submodule add https://github.com/reinh/vim-makegreen bundle/makegreen
git submodule add https://github.com/vim-scripts/TaskList.vim.git bundle/tasklist
git submodule add https://github.com/vim-scripts/The-NERD-tree.git bundle/nerdtree
git submodule add https://github.com/vim-airline/vim-airline bundle/vim-airline.git bundle/vim-airline
git submodule add https://github.com/vim-airline/vim-airline-themes.git bundle/vim-airline-themes
git submodule add https://github.com/powerline/fonts.git bundle/vim-airline-fonts
git submodule add https://github.com/altercation/vim-colors-solarized.git bundle/vim-colors-solarized
git submodule add https://github.com/davidhalter/jedi-vim.git bundle/jedi-vim
git submodule add https://github.com/FelikZ/ctrlp-py-matcher bundle/ctrlp-py-matcher
git submodule add https://github.com/janko-m/vim-test.git bundle/vim-test
git submodule add https://github.com/tpope/vim-dispatch.git bundle/vim-dispatch
git submodule add https://github.com/farseer90718/vim-taskwarrior bundle/vim-taskwarrior
git submodule add https://github.com/tomtom/tcomment_vim bundle/tcomment_vim
git submodule add https://github.com/tpope/vim-sensible bundle/vim-sensible
git submodule add https://github.com/tpope/vim-repeat bundle/vim-repeat
git submodule add https://github.com/tpope/vim-abolish bundle/vim-abolish
git submodule add https://github.com/christoomey/vim-tmux-navigator bundle/vim-tmux-navigator
git submodule add https://github.com/sirver/ultisnips bundle/ultisnips
git submodule add https://github.com/easymotion/vim-easymotion bundle/easymotion
git submodule add https://github.com/ajh17/VimCompletesMe bundle/VimCompletesMe

# vim-snippets dependencies
git submodule add https://github.com/tomtom/tlib_vim.git bundle/tlib_vim
git submodule add https://github.com/MarcWeber/vim-addon-mw-utils.git bundle/vim-addon-mw-utils
git submodule add https://github.com/honza/vim-snippets.git bundle/vim-snippets

# finish submodule config
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

# install YouCompleteMe
python ~/.vim/bundle/YouCompleteMe/install.py
