" load vim-plug
call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/vim-easy-align'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'zhimsel/vim-stay'
Plug 'luochen1990/rainbow' | Plug 'jiangmiao/auto-pairs'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/fonts'

" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

" snippets
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" theme/aesthetics
Plug 'liuchengxu/space-vim-dark'

" initialize plugin system
call plug#end()

" plugin configuration

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_powerline_fonts = 1
" apply different themes based on OS
if has("win32")
    let g:airline_theme='zenburn'
else
    let g:airline_theme='behelit'
endif

" NERDTree
let NERDTreeShowLineNumbers=1
let NERDTreeHighlightCursorLine=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=40
let NERDTreeQuitOnOpen=1
nmap <leader>f :NERDTree<cr>

" UltiSnips
let &runtimepath .= ','.expand('~/Prefs')
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom_snippets"]
let g:UltiSnipsExpandTrigger = '<c-g>'
let g:ultisnips_python_style = 'google'

" Easy-Align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" EasyMotion (remap all movement keys!)
let g:easy_motion_on=0
function! ToggleEasyMotionMovementKeys()
    if g:easy_motion_on
        unmap w
        unmap W
        unmap b
        unmap B
        unmap t
        unmap T
        unmap f
        unmap F
        " unmap j
        " unmap k
        unmap e
        unmap E
        unmap ge
        unmap gE
        let g:easy_motion_on=0
    else
        map w <Plug>(easymotion-w)
        map W <Plug>(easymotion-W)
        map b <Plug>(easymotion-b)
        map B <Plug>(easymotion-B)
        map t <Plug>(easymotion-t)
        map T <Plug>(easymotion-T)
        map f <Plug>(easymotion-f)
        map F <Plug>(easymotion-F)
        " map j <Plug>(easymotion-eol-j)
        " map k <Plug>(easymotion-eol-k)
        map e <Plug>(easymotion-e)
        map E <Plug>(easymotion-E)
        map ge <Plug>(easymotion-ge)
        map gE <Plug>(easymotion-gE)
        let g:easy_motion_on=1
    endif
endfunction

let g:EasyMotion_keys = "huwjmkl'r,c.gpfydisanote"
nnoremap <leader>n :call ToggleEasyMotionMovementKeys()<CR>
call ToggleEasyMotionMovementKeys()

" Rainbow Parentheses
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['#0087ff', '#875fdf', '#df5fdf', '#df5f87'],
	\	'ctermfgs': ['darkblue', 'darkcyan', 'darkmagenta', 'yellow'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

" ALE settings
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_completion_max_suggestions = 1000
let g:ale_open_list = 'on_save'
let g:ale_markdown_remark_lint_executable = expand('~/.node_modules_global/bin/remark')
let g:ale_markdown_remark_lint_options = '--use remark-preset-lint-recommended'
let g:ale_markdown_remark_lint_use_global = 1
let g:ale_python_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_sql_sqlformat_executable = expand('~/.node_modules_global/bin/sql-formatter-cli')
let g:ale_sql_sqlformat_options = '-i "-" -o "-"'

" TODO figure out how to get linting on *.sc files
let g:ale_linters = {
\    'json': ['jsonlint'],
\    'javascript': ['eslint', 'prettier'],
\    'css': ['eslint', 'prettier'],
\    'markdown': ['remark-lint'],
\    'python': ['pylint', 'flake8'],
\    'rust': ['rls', 'rustfmt'],
\    'scala': [],
\    'sql': ['sqlint']
\}
let g:ale_fixers = {
\    'json': ['prettier', 'eslint', 'jq'],
\    'javascript': ['prettier', 'eslint', 'jq'],
\    'css': ['prettier', 'eslint'],
\    'markdown': ['prettier'],
\    'rust': ['rustfmt'],
\    'scala': ['scalafmt'],
\    'sql': ['sqlformat'],
\    '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_rust_rls_config = {
\   'rust': {
\     'clippy_preference': 'on'
\   }
\}

nmap <silent> <leader>an <Plug>(ale_next_wrap)
nmap <silent> <leader>ap <Plug>(ale_previous_wrap)

highlight ALEWarning ctermfg=240 ctermbg=Yellow
highlight ALEError ctermfg=240 ctermbg=Red

" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
    \ 'rust': ['ale'],
    \ })
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
" use TAB for cycling completions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-i>"

" Undotree
let g:undotree_SetFocusWhenToggle = 1
nmap <leader>u :UndotreeToggle<CR>

" colorscheme
let g:space_vim_dark_background = 235
colorscheme space-vim-dark
set termguicolors
hi LineNr ctermbg=NONE ctermfg=243 guibg=NONE guifg=#767676
hi SpecialComment ctermfg=38
hi DiffAdd    gui=NONE guifg=#84d96e guibg=#3a3a3a
hi DiffChange gui=NONE guifg=#b2b2b2 guibg=#3a3a3a
hi DiffDelete gui=NONE guifg=#e0211d guibg=#3a3a3a
hi DiffText   gui=NONE guifg=#fabd2f guibg=#827400
