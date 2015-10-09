# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim && git init

# install vim plugins
git submodule add https://github.com/klen/python-mode bundle/python-mode
git submodule add https://github.com/tpope/vim-fugitive.git bundle/fugitive
git submodule add https://github.com/tpope/vim-surround.git bundle/surround
git submodule add https://github.com/tpope/vim-git.git bundle/git
git submodule add https://github.com/ervandew/supertab.git bundle/supertab
# git submodule add https://github.com/wincent/Command-T.git bundle/command-t
git submodule add https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim
git submodule add https://github.com/mitechie/pyflakes-pathogen.git
git submodule add https://github.com/sjl/gundo.vim.git bundle/gundo
git submodule add https://github.com/fs111/pydoc.vim.git bundle/pydoc
git submodule add https://github.com/vim-scripts/pep8.git bundle/pep8
git submodule add https://github.com/alfredodeza/pytest.vim.git bundle/py.test
git submodule add https://github.com/reinh/vim-makegreen bundle/makegreen
git submodule add https://github.com/vim-scripts/TaskList.vim.git bundle/tasklist
git submodule add https://github.com/vim-scripts/The-NERD-tree.git bundle/nerdtree
git submodule add https://github.com/bling/vim-airline bundle/vim-airline.git bundle/vim-airline
git submodule add https://github.com/altercation/vim-colors-solarized.git bundle/vim-colors-solarized
git submodule add https://github.com/davidhalter/jedi-vim.git bundle/jedi-vim
git submodule add https://github.com/garbas/vim-snipmate.git bundle/vim-snipmate

# vim-snippets dependencies
git submodule add https://github.com/tomtom/tlib_vim.git bundle/tlib_vim
git submodule add https://github.com/MarcWeber/vim-addon-mw-utils.git bundle/vim-addon-mw-utils
git submodule add https://github.com/honza/vim-snippets.git bundle/vim-snippets

# finish submodule config
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
