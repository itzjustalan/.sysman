"            __
"    __  __ /\_\    ___ ___   _ __   ___
"   /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
" __\ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
"/\_\\ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"\/_/ \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
" ___________________________By itzjustalan
"
"
"
" system clipboard
set clipboard+=unnamedplus
"set clipboard+=xclip

set viminfo+=n~/.vim/viminfo

" fix file types
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile /notes/something/*,/other/path/files/*,/add/more/paths/* set filetype=markdown

" spellcheck
autocmd FileType tex,txt,latex,markdown setlocal spell spelllang=en_us

" vertically center document when entering insert mode
autocmd InsertEnter * norm zz

" remove trailing white spaces on save
autocmd BufWritePre * %s/\s\+$//e

" write without sudo
cmap w!! w !sudo tee %
" also quick tip: you can start vim in readonly mode by vim -M filename


" save / load code folding
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END





syntax on

set noerrorbells
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu rnu
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set splitbelow
set splitright
set pastetoggle=<F3>

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


"call plug#begin('~/.vim/plugged')
" :PlugInstall

"Plug 'jremmen/vim-ripgrep'
"Plug 'tpope/vim-fugitive'
"Plug 'leafgarland/typescript-vim'
"Plug 'vim-utils/vim-man'
"Plug 'lyuts/vim-rtags'
"Plug 'git@github.com:kien/ctrlp.vim.git'
"Plug 'git@github.com:valloric/YouCompleteMe.git'
"Plug 'mbbill/undotree'
"Plug 'vimwiki/vimwiki'
"Plug 'dart-lang/dart-vim-plugin'
"Plug 'natebosch/vim-lsc'
"Plug 'natebosch/vim-lsc-dart'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}


"call plug#end()
" :PlugInstall





" Dart specifics
" :DartFmt - format dart code
" :DartAnalyzer - analyze dart code
"
"
" Enable HTML syntax highlighting inside Dart strings with
let dart_html_in_string=v:true


" Highlighting for specific syntax groups can be disabled by defining custom
" highlight group links. See :help dart-syntax
"
" Enable Dart style guide syntax (like 2-space indentation) with
let g:dart_style_guide = 2


" Enable DartFmt execution on buffer save with
let g:dart_format_on_save = 1

" Enable DartFmt auto syntax fixes
"let g:lsc_auto_map = v:true

" Configure DartFmt options with let g:dartfmt_options (discover formatter
" options with dartfmt -h)
"
"
" apply all defaults keymaps of vim-lsc
"let g:lsc_auto_map = v:true
"
"
" CoC dart
" :CocCommand flutter.emulators
" This list the installed emulators on your devices, just select the one and
" press Enter
"
" Inorder to run the current application
" :CocCommand flutter.run
"
" This is similar to flutter run
"
" Now you can bind these two commands into a keybinding and use that
" keybinding instead
"
nnoremap leader e :CocCommand flutter.emulators CR
nnoremap leader r :CocCommand flutter.run CR
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)



" remaps
"let mapleader = " "
let mapleader = "z"
imap jj <esc><esc>

" -------- STANDARD BINDINGS --------
" file system
"nnoremap <C-t> :!touch<Space>
"nnoremap <C-e> :!crf<Space>
"nnoremap <C-d> :!mkdir<Space>
"nnoremap <C-t> :!mv<Space>%<Space>
" navigation
"nnoremap gl $
"nnoremap gh 0
"nnoremap gk H
"nnoremap gj L
"nnoremap gt gg
"nnoremap gb G


" auto commenting
"map <leader>c :setlocal formatoptions-=cro<CR>
"map <leader>c :setlocal formatoptions=cro<CR>

" spell check
"map <leader>s :setlocal sell! spelllang=en_us<CR>

" enable and disable auto indent %$$%&^*^%@#$%$#
"map <leader>i :setlocal autoindent<CR>
"map <leader>I :setlocal noautoindent<CR>

" shell check (check for bashisms)
"map <leader>p :!clear && shellcheck %<CR>
" goyo?
"map <leader>g :Goyo<CR>

" Autocompletion
set wildmode=longest,list,full
" fix splitting
set splitbelow splitright
" better split navigation?
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" open splits
nnoremap <leader>h :split<Space>
nnoremap <leader>v :vsplit<Space>




if executable('rg')
    let g:rg_drive_root='true'
endif

let g:ctrlp_usr_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_browse_split = 2
"let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>


" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>




" for WSL
"to start vim in insert mode
"by bypassing the ambiguous
"utf-8 characters and by not
"requesting cursor position
set t_u7=

" powerline
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
"
"set laststatus=2


" vimwiki
set nocompatible
filetype plugin on
syntax on



" File Find {{{
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set hidden                     "dont warn when when opening new file without
"saving the previous one

" }}}


" END
