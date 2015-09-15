# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim && git init

# install vim plugins
git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
git submodule add https://github.com/msanders/snipmate.vim.git bundle/snipmate
git submodule add https://github.com/tpope/vim-surround.git bundle/surround
git submodule add https://github.com/tpope/vim-git.git bundle/git
git submodule add https://github.com/ervandew/supertab.git bundle/supertab
git submodule add https://github.com/wincent/Command-T.git bundle/command-t
git submodule add https://github.com/mitechie/pyflakes-pathogen.git
git submodule add https://github.com/sjl/gundo.vim.git bundle/gundo
git submodule add https://github.com/fs111/pydoc.vim.git bundle/pydoc
git submodule add https://github.com/vim-scripts/pep8.git bundle/pep8
git submodule add https://github.com/alfredodeza/pytest.vim.git bundle/py.test
git submodule add https://github.com/reinh/vim-makegreen bundle/makegreen
git submodule add https://github.com/vim-scripts/TaskList.vim.git bundle/tasklist
git submodule add https://github.com/vim-scripts/The-NERD-tree.git bundle/nerdtree
git submodule add https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline.git bundle/vim-airline
git submodule add https://github.com/altercation/vim-colors-solarized.git bundle/vim-colors-solarized

# finish submodule config
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
