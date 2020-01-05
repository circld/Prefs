" This must be first (and before pathogen calls), because it changes other
" options as a side effect.
set nocompatible

" remap <Leader> key (note: may not work in consoles! Default: \)
let mapleader=" "

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

syntax on
set hlsearch

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
     \ | wincmd p | diffthis
endif

" Set various additional settings
set previewheight=50
set foldmethod=manual
set foldlevel=99
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set nu
set linebreak
set breakindent
set textwidth=0
set laststatus=2
set cursorline
set splitbelow
set splitright
set nobackup
set ignorecase
set shortmess+=I
set textwidth=80
set colorcolumn=+1
syntax enable
set background=dark

" Custom mappings
map <Enter> o<Esc>
map <S-Enter> O<Esc>
map Y v$hy
nnoremap vv vV
nnoremap V v$h
imap <C-c> <Esc>
inoremap <F2> <Esc>A;<Esc>
nnoremap <F2> <Esc>A;<Esc>
inoremap <F3>{ <Esc>A {<CR>}<Esc>%o
nnoremap <F3>{ A{<CR>}<Esc>%o
inoremap <F3>( <Esc>A (<CR>)<Esc>%o
nnoremap <F3>( A(<CR>)<Esc>%o
inoremap <F3>[ <Esc>A [<CR>]<Esc>%o
nnoremap <F3>[ A[<CR>]<Esc>%o
nnoremap <C-c> :noh<Enter><Esc>
nnoremap <leader>p :exec &paste? "se paste!" : "se nopaste!"<cr>
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview
set autochdir


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
autocmd FileType sql setlocal shiftwidth=2 tabstop=2
autocmd FileType sql let b:autoformat_remove_trailing_spaces=1
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType text setlocal shiftwidth=2 tabstop=2 textwidth=0

au BufRead,BufNewFile *.txt,*.tex,*.md set wrap linebreak nolist textwidth=0 wrapmargin=0

au BufNewFile,BufRead *.coco set filetype=python
au BufNewFile,BufRead *.sc set filetype=scala
au BufNewFile,BufRead *.ipynb set filetype=json
au BufNewFile,BufRead *.ddl set filetype=sql
au BufNewFile,BufRead *.hql set filetype=sql

"""" FOLDING """"
set viewoptions=cursor,folds,slash,unix

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

" Neovim - configure Python provider
let g:python3_host_prog = '/Users/paul.garaud/miniconda3/bin/python'

" Load & configure plugins
so ~/Prefs/plugins.vim
