function! custom_config#before() abort

    " Neovim - configure Python provider
    let g:python3_host_prog = '/Users/paul.garaud/miniconda3/bin/python'

    " Options
    set completeopt=menu,preview
    set foldlevel=99
    set ignorecase
    set smartcase
    set splitbelow
    set splitright
    set viewoptions=cursor,folds,slash,unix

    " Mappings
    nnoremap Y v$hy
    nnoremap vv vV
    nnoremap V v$h

    nmap <left>  :3wincmd <<cr>
    nmap <right> :3wincmd ><cr>
    nmap <up>    :3wincmd +<cr>
    nmap <down>  :3wincmd -<cr>

    " Filetypes
    augroup FileTypeConfiguration
      autocmd FileType html setlocal shiftwidth=2 tabstop=2 foldmethod=syntax
      autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
      autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
      autocmd FileType json setlocal shiftwidth=2 tabstop=2 foldmethod=syntax
      autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 foldmethod=indent
      autocmd FileType rust setlocal foldmethod=syntax
      autocmd FileType sql setlocal shiftwidth=2 tabstop=2 foldmethod=indent
      autocmd FileType text setlocal wrap linebreak nolist shiftwidth=2 tabstop=2 textwidth=0 wrapmargin=0
      autocmd FileType python setlocal foldmethod=syntax
      au BufRead,BufNewFile *.txt,*.tex,*.md set wrap linebreak nolist textwidth=0 wrapmargin=0
      au BufNewFile,BufRead *.coco set filetype=python
      au BufNewFile,BufRead *.sc set filetype=scala
      au BufNewFile,BufRead *.ipynb set filetype=json
      au BufNewFile,BufRead *.ddl,*.hql set filetype=sql
    augroup END

    " workaround to access jump forward since tab remapped by SpaceVim
    nnoremap <f5> <c-i>

    function! Jump_transient_state() abort
      let state = SpaceVim#api#import('transient_state')
      call state.set_title('Jump Transient State')
      call state.defind_keys(
            \ {
            \ 'layout' : 'vertical split',
            \ 'left' : [
            \ {
            \ 'key' : 'j',
            \ 'desc' : 'next jump',
            \ 'func' : '',
            \ 'cmd' : 'try | exe "norm \<f5>"| catch | endtry ',
            \ 'exit' : 0,
            \ },
            \ {
            \ 'key' : 'J',
            \ 'desc' : 'previous jump',
            \ 'func' : '',
            \ 'cmd' : 'try | exe "norm \<c-o>" | catch | endtry',
            \ 'exit' : 0,
            \ },
            \ ],
            \ 'right' : [
            \ {
            \ 'key' : 'c',
            \ 'desc' : 'next change',
            \ 'func' : '',
            \ 'cmd' : "try | exe 'norm g,' | catch | endtry",
            \ 'exit' : 0,
            \ },
            \ {
            \ 'key' : 'C',
            \ 'desc' : 'previous change',
            \ 'func' : '',
            \ 'cmd' : "try | exe 'norm g;' | catch | endtry",
            \ 'exit' : 0,
            \ },
            \ {
            \ 'key' : 'q',
            \ 'desc' : 'quit',
            \ 'func' : '',
            \ 'cmd' : '',
            \ 'exit' : 1,
            \ },
            \ ],
            \ }
            \ )
      call state.open()
    endfunction

    " SPC commands
    call SpaceVim#custom#SPC('nore', ['b', 'l'], 'b#', 'switch-to-last-buffer', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'l'], 'Glog', 'traverse-diff-history', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'L'], '0Glog', 'traverse-file-history', 1)
    call SpaceVim#custom#SPC('nore', ['d', 'a'], 'windo difft', 'diff-all-windows', 1)
    call SpaceVim#custom#SPC('nore', ['d', 'x'], 'windo diffoff', 'turn-off-diff', 1)
    call SpaceVim#custom#SPC('nmap', ['j', 'Q'], '<Plug>(easymotion-eol-bd-jk)', 'jump-to-an-eol', 0)
    call SpaceVim#custom#SPC('nore', ['j', '.'], 'call Jump_transient_state()', 'jump-transient-state', 1)
    call SpaceVim#custom#SPCGroupName(['u'], '+Undo')
    call SpaceVim#custom#SPC('nmap', ['u', 't'], 'UndotreeToggle', 'toggle-undotree', 1)

    " Plugins

    " ALE
    command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"
    command! ALEToggleAll execute "ALEToggle \| ALEToggleFixer"
    let g:ale_linters_explicit = 1
    let g:ale_fix_on_save = 1
    let g:ale_completion_enabled = 0
    let g:ale_completion_max_suggestions = 1000
    let g:ale_markdown_remark_lint_executable = expand('~/.node_modules_global/bin/remark')
    let g:ale_markdown_remark_lint_options = '--use remark-preset-lint-recommended'
    let g:ale_markdown_remark_lint_use_global = 1
    let g:ale_python_autoflake_options = '--remove-all-unused-imports --remove-duplicate-keys --remove-unused-variables'
    let g:ale_python_auto_pipenv = 1
    let g:ale_python_flake8_auto_pipenv = 1
    let g:ale_python_autoflake_executable = 'autoflake'
    let g:ale_sql_sqlformat_executable = expand('~/.node_modules_global/bin/sql-formatter-cli')
    let g:ale_sql_sqlformat_options = '-i "-" -o "-"'

    let g:ale_linters = {
    \    'css': ['eslint', 'prettier'],
    \    'javascript': ['eslint', 'prettier'],
    \    'json': ['jsonlint'],
    \    'markdown': ['remark-lint'],
    \    'python': ['flake8'],
    \    'rust': ['rls', 'rustfmt'],
    \    'scala': [],
    \    'sql': ['sqlint'],
    \    'vim': ['vint']
    \}
    let g:ale_fixers = {
    \    'css': ['prettier', 'eslint'],
    \    'javascript': ['prettier', 'eslint', 'jq'],
    \    'json': ['prettier', 'eslint', 'jq'],
    \    'python': ['autoflake', 'isort', 'yapf'],
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

    " markdown-preview
    let g:mkdp_auto_start = 0
    let g:mkdp_auto_close = 0
    let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'relative',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

    " rainbow
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
      \			'guifgs': ['#0087ff', '#875fdf', '#df5fdf', '#df5f87'],
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

  endfunction

function! custom_config#after() abort

    " Conflicting mappings
    nmap f <Plug>(easymotion-overwin-f)
    xmap f <Plug>(easymotion-bd-f)
    omap f <Plug>(easymotion-bd-f)
    nunmap <p
    nunmap >p
    nunmap <P
    nunmap >P
    iunmap jk
    iunmap \<Tab>

    " Appearance
    hi LineNr ctermbg=NONE ctermfg=243 guibg=NONE guifg=#767676
    hi SpecialComment ctermfg=38 guifg=#0087d7
    hi DiffAdd    gui=NONE guifg=#84d96e guibg=#3a3a3a
    hi DiffChange gui=NONE guifg=#fabd2f guibg=#3a3a3a
    hi DiffDelete gui=NONE guifg=#e0211d guibg=#3a3a3a
    hi DiffText   gui=NONE guifg=#fabd2f guibg=#827400
    hi link diffAdded DiffAdd
    hi link diffChanged DiffChange
    hi link diffRemoved DiffDelete
    hi link GitGutterAdd DiffAdd
    hi link GitGutterChange DiffChange
    hi link GitGutterDelete DiffDelete
    hi EasyMotionTarget guifg=#5fd700

    " Mode-specific cursors
    " - https://vim.fandom.com/wiki/Configuring_the_cursor
    " - SpaceVim/autoload/SpaceVim/layers/core/statusline.vim
    let t = SpaceVim#mapping#guide#theme#SpaceVim#palette()
    hi Cursor guifg=white guibg=None
    exe 'hi! iCursor gui=bold cterm=bold ctermbg=' . t[4][3] . ' ctermfg=' . t[4][2] . ' guibg=' . t[4][1] . ' guifg=' . t[4][0]
    exe 'hi! vCursor gui=bold cterm=bold ctermbg=' . t[5][3] . ' ctermfg=' . t[5][2] . ' guibg=' . t[5][1] . ' guifg=' . t[5][0]

    set guicursor=n-c:block-Cursor
    set guicursor+=i:ver25-iCursor
    set guicursor+=v:block-vCursor

    " UltiSnips
    inoremap <silent> <C-G> <C-R>=UltiSnips#ExpandSnippetOrJump()<cr>
    snoremap <silent> <Tab> <Tab>
    snoremap <silent> <S-Tab> <S-Tab>
    snoremap <silent> <PageUp> <NOP>
    snoremap <silent> <PageDown> <NOP>
    let &runtimepath .= ','.expand('~/Prefs')
    let g:UltiSnipsSnippetDirectories=['UltiSnips', 'custom_snippets']
    let g:ultisnips_python_style = 'google'
    let g:UltiSnipsJumpForwardTrigger = '<PageDown>'
    let g:UltiSnipsJumpBackwardTrigger = '<PageUp>'

    " For saner snippets
    augroup SanerSnippets
      autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
      " use TAB for cycling completions
      inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"
      inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-i>"
    augroup END

    " deoplete
    call deoplete#custom#option({
          \ 'sources': {
            \ 'rust': ['ale'],
          \ },
          \ 'smart_case': v:true,
        \ })

    " WIN commands
    nnoremap <silent> [Window]H :<C-u>wincmd H<CR>
    let g:_spacevim_mappings_windows.H = ['wincmd H',
          \ 'move-window-leftmost',
          \ [
          \ '[WIN H] is to move the current window to the leftmost position',
          \ '',
          \ 'Custom command; no definition.',
          \ ]
          \ ]
    nnoremap <silent> [Window]L :<C-u>wincmd L<CR>
    let g:_spacevim_mappings_windows.L = ['wincmd L',
          \ 'move-window-rightmost',
          \ [
          \ '[WIN L] is to move the current window to the rightmost position',
          \ '',
          \ 'Custom command; no definition.',
          \ ]
          \ ]
    nnoremap <silent> [Window]J :<C-u>wincmd J<CR>
    let g:_spacevim_mappings_windows.J = ['wincmd J',
          \ 'move-window-bottommost',
          \ [
          \ '[WIN J] is to move the current window to the bottommost position',
          \ '',
          \ 'Custom command; no definition.',
          \ ]
          \ ]
    nnoremap <silent> [Window]K :<C-u>wincmd K<CR>
    let g:_spacevim_mappings_windows.K = ['wincmd K',
          \ 'move-window-topmost',
          \ [
          \ '[WIN K] is to move the current window to the topmost position',
          \ '',
          \ 'Custom command; no definition.',
          \ ]
          \ ]

    nnoremap <silent> [Window]x :bd<CR>
    let g:_spacevim_mappings_windows.x = ['bd',
          \ 'delete-and-close-current-window',
          \ [
          \ '[WIN x] deletes the current buffer and closes the window',
          \ '',
          \ 'Custom command; no definition.',
          \ ]
          \ ]

  endfunction
