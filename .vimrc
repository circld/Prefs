" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

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

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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
  autocmd FileType text setlocal textwidth=78

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
set foldmethod=indent
set foldlevel=99
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set nu
set laststatus=2
set splitbelow
map <Enter> o<Esc>
map <S-Enter> O<Esc>
map Y y$
inoremap <C-c> <Esc>
nnoremap <C-c> :noh<Enter><Esc>

" swap split windows & maximize
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0  " set stacked height to 0 by default

" split windows set to equal
map <leader>=  <C-W>= 
map <leader>j <C-W>j
map <leader>k <C-W>k

" close split window below
map <leader>x :close <Enter>

set autochdir

" edited sh.exe in git folders to use gvim by default (for colorscheme to work)
syntax enable
" set t_Co=16
" let g:solarized_termcolors=16
set background=dark
colorscheme solarized

" window size/position
" set columns=80
" set lines=44
" winpos 0 0

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

" Python-mode
" rope completion disabled for Jedi vim
let g:pymode_rope_completion=0
 
" Documentation
let g:pymode_doc=1
let g:pymode_doc_key='K'
 
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

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Yellow
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

" TaskList settings
map <leader>l <Plug>TaskList

" Gundo
map <leader>z :GundoToggle<Enter>
let g:gundo_close_on_revert=1

" SuperTab
let g:SuperTabDefaultCompletionType="context"
set completeopt=menuone,longest,preview

" Command-T
let g:CommandTAcceptSelectionMap='<C-CR>'
let g:CommandTAcceptSelectionSplitMap='<CR>'
