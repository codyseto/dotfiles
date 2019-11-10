""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" About my vim configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Alias
" au=autocmd

" To upgrade Neovim, execute `brew upgrade neovim`(Mac).
" To upgrade vim-plug, execute `:PlugUpdate`.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initial Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatic installation(Neovim version)
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   au VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

language C

set background=light
set clipboard+=unnamed,unnamedplus  " Cross-Platform clipboard setting
" set clipboard+=autoselect  " Put selection automatically into clipboard
set cursorline
set encoding=utf-8
set expandtab
" set hidden
set foldmethod=marker
set ignorecase
" set list listchars=trail:-,extends:»,precedes:«,nbsp:%,tab:\ \
" set nobackup  " No backup
set number
" set pumheight=10
set ruler
set scrolloff=7
set showmatch matchtime=1
set smartcase
set smartindent
set splitbelow
set splitright
set timeout timeoutlen=300
set whichwrap=h,l
set wrapscan

" Ctags
set tags=./tags;,tags;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Emacs-like key-bind on command mode
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>
cnoremap <C-e> <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

" Brackets/Quotations Complement
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>

" deoplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Move by line in one sentence
noremap j gj
noremap k gk

" Easier split navigation
noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>

" Split
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" Move window
" nnoremap s <Nop>
" nnoremap sJ <C-w>J
" nnoremap sK <C-w>K
" nnoremap sL <C-w>L
" nnoremap sH <C-w>H
" nnoremap sr <C-w>r

" Resize window
nnoremap <C-w>> <C-w>10>
nnoremap <C-w>< <C-w>10<
nnoremap <C-w>+ <C-w>10+
nnoremap <C-w>- <C-w>10-

" Yank until end
nnoremap Y y$

" Don't copy when yank
nnoremap x "_x

" Unhighlight search result
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nnoremap ga <Plug>(EasyAlign)

" NERDTree
nnoremap <silent><C-n> :NERDTreeToggle<CR>

" Disable dangerous keys
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" vimgrep setting
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>

" Sequential Indent
vnoremap > >gv
vnoremap < <gv

" EasyMotion (Leader"," is overlapping with default behavior)
let g:mapleader = ","
map <Leader>f <Plug>(easymotion-bd-f)
map <Leader>f <Plug>(easymotion-bd-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)
" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" deoplete
let g:deoplete#enable_at_startup = 1
" Automatically remove trailing whitespaces on write
au BufWritePre * :%s/\s\+$//e
" No paste when leaving insert mode
au InsertLeave * set nopaste
" Automatically open quickfix-window
au QuickfixCmdPost make,vimgrep copen
" Color Setting
:hi ErrorMsg ctermfg=124 ctermbg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:fzf_tags_command = 'ctags -R'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" " Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>G :GFiles?<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>B :BLines<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>m :Mark<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>T :BTags<CR>
nnoremap <Leader>a :Ag<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Below is included as Neovim default setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" syntax enable
" set autoindent
" set autoread
" set backspace=indent,eol,start
" set backupdir=/home/setoyama/.local/share/nvim/backup
" set belloff=all
" set directory=/home/setoyama/.local/share/nvim/swap
" set display+=lastline
" set formatoptions=tcqj
" set history=10000
" set hlsearch
" set incsearch
" set langnoremap  " remap is disabled by default on nvim
" set laststatus=2
" set listchars="tab:>,trail:-,nbsp:+"  " need color setting
" set nrformats="bin,hex"
" set ruler
" set showcmd
" set smarttab
" set tabpagemax=50
" set ttyfast
" set undodir=/home/setoyama/.local/share/nvim/undo
" set wildmenu

""" Activate file specific plugin/indent
" filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug setting
call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tweekmonster/deoplete-clang2'
Plug 'zchee/deoplete-jedi'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'nvie/vim-flake8'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
call plug#end()
