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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
map <Space> <Plug>(easymotion-prefix)

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
nnoremap :tree :NERDTreeToggle
" Disable dangerous keys
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" vimgrep setting
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>

" Start interactive EasyAlign in visual mode
" vnoremap ga <Plug>(EasyAlign)
" Sequential Indent
vnoremap > >gv
vnoremap < <gv

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim default setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" syntax enable
"
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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'nvie/vim-flake8'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
call plug#end()

colorscheme slate
