#!/bin/bash

# install pathogen
# mkdir -p ~/.vim/autoload ~/.vim/bundle && \
# curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle
cd ~/.vim && git init
git submodule add https://github.com/tpope/vim-pathogen bundle/vim-pathogen
ln -s ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim

# install vim plugins
git submodule add https://github.com/tpope/vim-fugitive.git bundle/fugitive
git submodule add https://github.com/tpope/vim-surround.git bundle/surround
git submodule add https://github.com/tpope/vim-unimpaired
git submodule add https://github.com/tpope/vim-sensible bundle/vim-sensible
git submodule add https://github.com/tpope/vim-repeat bundle/vim-repeat
git submodule add https://github.com/tpope/vim-abolish bundle/vim-abolish
git submodule add https://github.com/mitechie/pyflakes-pathogen.git
git submodule add https://github.com/mbbill/undotree bundle/undotree
git submodule add https://github.com/fs111/pydoc.vim.git bundle/pydoc
git submodule add https://github.com/vim-scripts/TaskList.vim.git bundle/tasklist
git submodule add https://github.com/vim-airline/vim-airline bundle/vim-airline.git bundle/vim-airline
git submodule add https://github.com/vim-airline/vim-airline-themes.git bundle/vim-airline-themes
git submodule add https://github.com/powerline/fonts.git bundle/vim-airline-fonts
git submodule add https://github.com/tomtom/tcomment_vim bundle/tcomment_vim
git submodule add https://github.com/christoomey/vim-tmux-navigator bundle/vim-tmux-navigator
git submodule add https://github.com/sirver/ultisnips bundle/ultisnips
git submodule add https://github.com/easymotion/vim-easymotion bundle/easymotion
git submodule add https://github.com/jiangmiao/auto-pairs bundle/auto-pairs
git submodule add https://github.com/luochen1990/rainbow bundle/rainbow
git submodule add https://github.com/airblade/vim-gitgutter bundle/vim-gitgutter
git submodule add https://github.com/w0rp/ale.git bundle/ale
git submodule add https://github.com/Vimjas/vim-python-pep8-indent bundle/vim-python-pep8-indent
git submodule add https://github.com/zhimsel/vim-stay bundle/vim-stay
git submodule add https://github.com/scrooloose/nerdtree bundle/nerdtree

# completion
git submodule add https://github.com/Shougo/deoplete.nvim.git bundle/deoplete
git clone --recursive https://github.com/deoplete-plugins/deoplete-jedi bundle/deoplete-jedi

# vim-snippets dependencies
git submodule add https://github.com/tomtom/tlib_vim.git bundle/tlib_vim
git submodule add https://github.com/MarcWeber/vim-addon-mw-utils.git bundle/vim-addon-mw-utils
git submodule add https://github.com/honza/vim-snippets.git bundle/vim-snippets

# vim aesthetics
git submodule add https://github.com/altercation/vim-colors-solarized.git bundle/vim-colors-solarized
git submodule add https://github.com/liuchengxu/space-vim-dark.git bundle/space-vim-dark

# finish submodule config
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
