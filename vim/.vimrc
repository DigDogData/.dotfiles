" set leader key
let mapleader = "\<Space>"

" basic settings
set nocompatible                " required
filetype off                    " required
syntax on
set belloff=all                 " disable bell + flash
set expandtab
set smarttab
set tabstop=4 softtabstop=4 shiftwidth=4
set smartindent
set autoindent
set nowrap
set wildmode=longest,list,full
setlocal spelllang=en_us
set nu rnu						" set hybrid line numbering
set hlsearch
set incsearch
set smartcase
set ignorecase
set autoread
set backspace=indent,eol,start
set noswapfile
set t_Co=256
set t_ut=
set mouse=a
set termguicolors
set backup      " make backup files
set backupdir=~/.vim/backupdir
set undofile    " persistent undo
set undodir=~/.vim/undodir

" set plugins
call plug#begin('~/.vim/plugged')
" theme
Plug 'lifepillar/vim-gruvbox8'     " improved gruvbox
Plug 'tomasiser/vim-code-dark'
Plug 'joshdick/onedark.vim'
" fzf integration (install fzf BEFORE activating this plugin)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" python intellisense
Plug 'davidhalter/jedi-vim'
" autocompletion autopopup
Plug 'vim-scripts/AutoComplPop'
" startify
Plug 'mhinz/vim-startify'
" vimwiki
Plug 'vimwiki/vimwiki'
" git branch
Plug 'itchyny/vim-gitbranch'
" git gutter
Plug 'airblade/vim-gitgutter'
" statusline
Plug 'itchyny/lightline.vim'
" linting+fixing
Plug 'dense-analysis/ale'
" statusline+ale
Plug 'maximbaz/lightline-ale'
" NERDTree
Plug 'preservim/nerdtree'
" tag
Plug 'preservim/tagbar'
call plug#end()

filetype plugin indent on       " required

" detect python environment (pipenv/conda)
let split_path = split($PATH,'/')
if split_path[4] == 'virtualenvs'           " if pipenv
    let split_name = split(split_path[5],'-')
    let venv = tolower(split_name[0])
elseif exists('$CONDA_DEFAULT_ENV')         " if conda
    let venv = $CONDA_DEFAULT_ENV
else                                        " if none
    let venv = 'base'
endif

" set clipboard
set clipboard=unnamedplus		" to copy from system clipboard
set guioptions+=a               " to copy to system clipboard
vnoremap <C-c> "+y
inoremap <C-v> <ESC>"+pa

" set cursor shape (https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes)
" <:echo &term> shows terminal type
let &t_SI = "\<Esc>[6 q"     " SI -> INSERT mode, 6 -> solid vertical bar
let &t_SR = "\<Esc>[4 q"     " SR -> REPLACE mode, 4 -> solid underscore
let &t_EI = "\<Esc>[2 q"     " EI -> NORMAL mode, 2 -> solid block

" code folding
set foldmethod=indent
set foldlevel=99

" remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" enable python syntax highlighting
let python_highlight_all = 1

"""""""""""""""""""""""""""""
" set color scheme
"""""""""""""""""""""""""""""
let color_scheme = 'onedark'       " gruvbox8/codedark/onedark
if color_scheme == 'gruvbox8'
    set background=dark     " use dark theme
    let g:gruvbox_italics = 1
    let g:gruvbox_italicize_comments = 1
    let g:gruvbox_italicize_strings = 0
    let g:gruvbox_filetype_hi_groups = 1    " enable additional syntax highlighting
    colorscheme gruvbox8            " gruvbox8_soft/gruvbox8(medium)/gruvbox8_hard
    " disable ugly orange bar for python indent guide
    if exists('python_highlight_all')
        unlet python_highlight_all
    endif
elseif color_scheme == 'codedark'
    "let g:codedark_conservative = 1     " conservative colors
    colorscheme codedark
else
    let g:onedark_terminal_italics = 1
    let g:python_highlight_all = 1
    let g:onedark_color_overrides = {
    \ 'white': {'gui': '#c6c6c6', 'cterm': '251', 'cterm16': '15' },
    \ 'comment_grey': {'gui': '#808080', 'cterm': '244', 'cterm16': '8' }
    \}
    colorscheme onedark
endif

" set long line alert (>88 characters)
hi OverLength guibg=#3c3836 ctermbg=gray
match OverLength /\%89v.\+/

"""""""""""""""""""""""""""""""""""
" set fzf (defaults set in .bashrc)
"""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']  " ctrl-/ to toggle
"let g:fzf_preview_window = ['right:50%:wrap', 'ctrl-/']

" search within file
command! -bang -nargs=* Rg
    \                   call fzf#vim#grep(
    \                       '
    \                           rg
    \                           --column
    \                           --line-number
    \                           --hidden
    \                           --no-heading
    \                           --smart-case
    \                           --glob "!{.cache,.git,.local,.mozilla,.pyenv,.steam,.thunderbird,BraveSoftware}"
    \                       '
    \                       .shellescape(<q-args>), 1,
    \                       fzf#vim#with_preview(), <bang>0
    \                   )

" hide statusline for cleaner look
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"keybindings
nnoremap <silent> ff :Files<CR>
nnoremap <silent> fd :Files ~/Documents<CR>
nnoremap <silent> FF :Files ~<CR>
nnoremap <silent> bb :Buffers<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" use colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" turn off search highlighting
noremap <leader>h :noh<CR>

" Disable Ctrl-Z to prevent backgrounding (<nop> -> 'no operation')
nnoremap <c-z> <nop>
inoremap <c-z> <nop>

" open new buffer in (right/left)split window
nmap <leader>r :set splitright<CR>:vnew<CR>
nmap <leader>l :set nosplitright<CR>:vnew<CR>

" move through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" set builtin autocompletion
set complete+=kspell            " add completion dictionary
set shortmess+=c                " disable completion status message
inoremap <expr><Right> pumvisible() ? "<C-y>":"<Right>"
inoremap <expr><Left> pumvisible() ? "<C-e>":"<Left>"

" set jedi
let g:jedi#documentation_command = "K"      " open python help doc
let g:jedi#completions_command = "<C-a>"    " replace default <C-Space> keymap
set noshowmode          " needed for next line
let g:jedi#show_call_signatures = 2
let g:jedi#squelch_py_warning = 1       " disable abort warning
autocmd FileType python setlocal completeopt-=preview   " disable scratch preview

" set vimwiki
let g:vimwiki_list = [{'path': '$HOME/Documents/VimWiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_global_ext = 0
nmap <leader>w <Plug>VimwikiIndex
nmap <leader>wi <Plug>VimwikiDiaryIndex
nmap <Delete> <Plug>VimwikiDeleteFile

" set linting+fixing (read :help <commad> for details)
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'*': [], 'python': ['black']}
let g:ale_fix_on_save = 1

" set gitgutter
set updatetime=100
let g:gitgutter_map_keys = 0        " disable plugin's builtin keymaps
nmap ] <Plug>(GitGutterNextHunk)
nmap [ <Plug>(GitGutterPrevHunk)

"""""""""""""""""""""""""""""""""""""""""""
" set lightline (integrate ale + gitgutter)
"""""""""""""""""""""""""""""""""""""""""""
" function to define gitgutter status
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a+m+r > 0
        return printf('+%d ~%d -%d', a, m, r)
    else
        return ''
    endif
endfunction

" function to auto-update lightline after switching colorscheme
" (source: https://hiphish.github.io/blog/2019/09/21/switching-automatically-themes-in-lightline/)
function! s:onColorSchemeChange(scheme)
    execute 'runtime autoload/lightline/colorscheme/'.a:scheme.'.vim'
    let g:lightline.colorscheme = a:scheme
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
augroup lightline-events
    autocmd!
    autocmd ColorScheme * call s:onColorSchemeChange(expand("<amatch>"))
augroup END

" set lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': color_scheme,
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified', 'virtualenv', 'gitbranch', 'gitgutter'] ],
      \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'lineinfo' ],
      \            [ 'fileformat', 'filetype', 'percent' ] ]
      \ },
      \ 'component': {
      \   'virtualenv': venv
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'gitgutter': 'GitStatus'
      \ },
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ },
      \ 'component_type': {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "

" set terminal
map <leader>t :below vert terminal<CR>
tmap <F2> <C-w>w
tmap <F3> <C-w>N

" change vertical line type on split
set fillchars+=vert:$

" set startify
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_enable_special = 0
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ ]
let g:startify_custom_header = [
         \ ' _______    _     _                                    _',
         \ '|__   __|  | |   | |                                  (_)',
         \ '   | | __ _| |_  | |___   ____ _ _ __ ___     __ _ ___ _',
         \ '   | |/ _` | __| | __\ \ / / _` | `_ ` _ \   / _` / __| |',
         \ '   | | (_| | |_  | |_ \ V / (_| | | | | | | | (_| \__ \ |',
         \ '   |_|\__._|\__|  \__| \_/ \__._|_| |_| |_|  \__._|___/_|',
         \]

" disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" set NERDTree
nmap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = max([30, winwidth(0)/5])     " max(30char,20% width)
let g:NERDTreeShowHidden = 1
" quit vim if only NERDTree is present
function! QuitIfOnly()
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        q
    end
endfunction
autocmd bufenter * call QuitIfOnly()

" set tagbar
let g:tagbar_ctags_bin = '$HOME/Documents/Ctags/bin/ctags'
let g:tagbar_width = max([30, winwidth(0)/5])     " max(30char,20% width)
let g:tagbar_compact = 1
let g:tagbar_singleclick = 1
nnoremap <silent> <F8> :TagbarToggle<CR>

" open + reload vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

