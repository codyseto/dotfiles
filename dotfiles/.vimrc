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
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

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
" nnoremap [ :cprevious<CR>
" nnoremap ] :cnext<CR>
" nnoremap [g :<C-u>cfirst<CR>
" nnoremap ]g :<C-u>clast<CR>

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

" Line Number
:nmap <C-N><C-N> :set invnumber<CR>

" vimgrep
:nmap <space> :vimgrep<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " Always show tab line

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
" t1 goes to left most tab, t2 goes to second most tab
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" gr moves to the left
nnoremap gb :tabprevious<CR>

" tc Create a new tab
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx Close tab
map <silent> [Tag]x :tabclose<CR>
" tn Next tab
" map <silent> [Tag]n :tabnext<CR>
" tp Previous tab
" map <silent> [Tag]p :tabprevious<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" deoplete
" let g:deoplete#enable_at_startup = 1
" Automatically remove trailing whitespaces on write
au BufWritePre * :%s/\s\+$//e
" No paste when leaving insert mode
au InsertLeave * set nopaste
" Automatically open quickfix-window
au QuickfixCmdPost make,vimgrep copen
" Run python scripts from vim command mode
au BufNewFile,BufRead *.py nnoremap <C-e> :!python %
" Color Setting
:hi ErrorMsg ctermfg=124 ctermbg=NONE
:hi Search cterm=NONE ctermfg=grey ctermbg=blue

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
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

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

" Make :Ag not match file names, only the file content
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

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
if has("autocmd")
  filetype plugin indent on
  autocmd FileType php              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c                setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js               setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala            setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescriptreact  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript       setlocal sw=2 sts=2 ts=2 et
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType json syntax match Comment +\/\/.\+$+

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader><leader>f <Plug>(coc-format-selected)
nmap <leader><leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader><leader>a  <Plug>(coc-codeaction-selected)
nmap <leader><leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader><leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader><leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug setting
call plug#begin('~/.config/nvim/plugged')
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'tweekmonster/deoplete-clang2'
"Plug 'zchee/deoplete-jedi'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'nvie/vim-flake8'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
" Plug 'powerline/powerline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
Plug 'leafgarland/typescript-vim'
call plug#end()
