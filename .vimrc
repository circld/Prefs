" This must be first (and before pathogen calls), because it changes other
" options as a side effect.
set nocompatible

" Pathogen (package/module management)
filetype off
execute pathogen#infect()
execute pathogen#helptags()
filetype on

" remap <Leader> key (note: may not work in consoles! Default: \)
let mapleader=" "

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions=substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,

  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
     \ | wincmd p | diffthis
endif

" Set various additional settings
set previewheight=50
set foldmethod=indent
set foldlevel=99
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set nu
set linebreak
" set breakindent
set textwidth=0
set laststatus=2
set cursorline
set splitbelow
set splitright
set nobackup
set ignorecase
set shortmess+=I
map <Enter> o<Esc>
map <S-Enter> O<Esc>
map Y y$
nnoremap vv vV
nnoremap V v$
inoremap <C-c> <Esc>
nnoremap <C-c> :noh<Enter><Esc>
nnoremap <leader>n :exec &rnu? "se nornu!" : "se rnu!"<cr>
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview
set autochdir

" edited sh.exe in git folders to use gvim by default (for colorscheme to work)
syntax enable
" set t_Co=16
" let g:solarized_termcolors=16
set background=dark
colorscheme solarized

" font sizing adjustment
if has("gui_running")
    set guifont=Consolas:h10:cANSI
endif

" Git default vimrc options
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")

"""" FILETYPES """"
" highlight hql files as sql & run queries from vim
au BufNewFile,BufRead *.hql set filetype=sql
augroup HiveQuery
    autocmd! filetype sql nnoremap <leader>q :w <bar> :Dispatch! hive -f %<cr>
augroup END

" sql/hql completion
let g:ftplugin_sql_omni_key = '<C-B>'
let g:omni_sql_default_compl_type = 'syntax'


"""" WINDOW MANAGEMENT """"

set wmh=0  " set stacked height to 0 by default
" fast resizing of windows
map <leader>=  <C-W>=
map <leader>-  <C-W>_

" sane and intuitive vim windows management
" http://www.agillo.net/simple-vim-window-management/

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())  " we havent moved
    if (match(a:key,'[jk]'))  " were we going up/down
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" moving around/creating splits
map <leader>h              :call WinMove('h')<cr>
map <leader>k              :call WinMove('k')<cr>
map <leader>l              :call WinMove('l')<cr>
map <leader>j              :call WinMove('j')<cr>

" closing & rotating splits
map <leader>wc :wincmd q<cr>
map <leader>wr <C-W>r

" moving windows
map <leader>H              :wincmd H<cr>
map <leader>K              :wincmd K<cr>
map <leader>L              :wincmd L<cr>
map <leader>J              :wincmd J<cr>

" resizing using arrow keys
nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>

" moving between buffers
map gn :bn<cr>
map gN :bp<cr>
map gd :bd<cr>
map gl :b#<cr>
map gb :buffers<cr>

"""" PLUGINS """"

" Python-mode
" rope completion disabled for Jedi vim
let g:pymode_rope_completion=0

" Documentation
let g:pymode_doc=0

" " Lint
let g:pymode_lint=1
let g:pymode_lint_checker="pyflakes,pep8"

" Auto check on save
let g:pymode_lint_write=1
let g:pymode_lint_cwindow=0

let g:pymode_virtualenv=0

" Enable breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlighting
let g:pymode_syntax=1
let g:pymode_syntax_all=1
let g:pymode_indent_errors=g:pymode_syntax_all
let g:pymode_space_errors=g:pymode_syntax_all

" turn off autofolding
let g:pymode_folding=0

" turn on pymode_run
let g:pymode_run=1
let g:pymode_run_bind='<S-R>'

" map pymode rename
let g:pymode_rope_rename_bind = '<leader>r'

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80 (can mess with pop-up prompts)
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Yellow
    " autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

" jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = 1
let g:jedi#show_call_signatures_delay = 0
let g:jedi#documentation_command = '<S-K>'
let g:jedi#use_splits_not_buffers = 'top'
let g:jedi#goto_command = '<leader>g'
let g:jedi#usages_command = '<leader><s-n>'

" TaskList settings
map <leader>d <Plug>TaskList

" Gundo
map <leader>z :GundoToggle<Enter>
let g:gundo_close_on_revert=1

" CtrlP
" let g:ctrlp_map = '<leader>t'
nnoremap <leader>t :CtrlP ~/<cr>
let g:ctrlp_show_hidden = 1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-v>'],
    \ 'AcceptSelection("v")': ['<cr>'],
    \ }
" speed up indexing
" requires silver_searcher: https://github.com/ggreer/the_silver_searcher
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_clear_cache_on_exit = 0

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1
" apply different themes based on OS
if has("win32")
    let g:airline_theme='zenburn'
else
    let g:airline_theme='behelit'
endif

" ShellAsync
nnoremap <leader>S :Dispatch!

" vim-test
let g:test#python#runner = 'nose'
function! Dispatchbg(cmd) abort
    execute 'Dispatch!'.a:cmd
endfunction
let g:test#custom_strategies = {'dispatch_bg': function('Dispatchbg')}
let g:test#strategy = 'dispatch_bg'
nmap <silent> <leader>U :TestFile<CR>
nmap <silent> <leader>u :TestLast<CR>
nmap <leader>c :Copen<cr><leader>LGzb

" vim-taskwarrior
let g:task_info_vsplit = 1
let g:task_rc_override = 'rc.defaultwidth=0'

" NERDTree
let NERDTreeShowLineNumbers=1
let NERDTreeHighlightCursorLine=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=40
let NERDTreeQuitOnOpen=1
nmap <leader>' :NERDTree<cr>

" YouCompleteMe
let g:ycm_filetype_blacklist = {}
let g:ycm_key_list_select_completion = ['<c-tab>', '<down>']
let g:ycm_key_list_previous_completion = ['<c-s-tab>', '<up>']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1

" SuperTab
let g:SuperTabDefaultCompletionType = '<c-tab>'

" UltiSnips
let &runtimepath .= ','.expand('~/Prefs')
let g:UltiSnipsSnippetsDirectories = ['UltiSnips', 'custom_snippets']

set omnifunc=syntaxcomplete#Complete
