"----------------------------------------------------
"         .8.          8 8888     ,88'        8 8888 
"        .888.         8 8888    ,88'         8 8888 
"       :88888.        8 8888   ,88'          8 8888 
"      . `88888.       8 8888  ,88'           8 8888 
"     .8. `88888.      8 8888 ,88'            8 8888 
"    .8`8. `88888.     8 8888 88'             8 8888 
"   .8' `8. `88888.    8 888888<   88.        8 8888 
"  .8'   `8. `88888.   8 8888 `Y8. `88.       8 888' 
" .888888888. `88888.  8 8888   `Y8. `88o.    8 88'  
".8'       `8. `88888. 8 8888     `Y8. `Y888888 '    
"----------------------------------------------------
"___________________________________________init.vim 
"----------------------------------------------------
"
"
"
"
"
"
"
" system clipboard
set clipboard+=unnamedplus
"set clipboard+=xclip

" fix file types
autocmd BufRead,BufNewFile *.tex set filetype=tex

" spellcheck
autocmd FileType tex,txt,latex,markdown setlocal spell spelllang=en_us

" vertically center document when entering insert mode
autocmd InsertEnter * norm zz
" save file on leaving insert mode
"autocmd InsertLeave * silent! :wall
"autocmd CursorHold * :write

" remove trailing white spaces on save
"autocmd BufWritePre * %s/\s\+$//e

" write without sudo
cmap w!! w !sudo tee %
" also quick tip: you can start vim in readonly mode by vim -M filename


" save / load code folding
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END





syntax on

set exrc  " load vimrc from the folder when running with vim ."
set nu rnu  " nu rnu maan nu rnu"
set incsearch
set nohlsearch  " remove hioghlights after search"
set hidden  "dont warn when when opening new file without
set belloff=all  " vibrator lol"
set noerrorbells
set scrolloff=4
set showtabline=1  " 0, 1 or 2; when to use a tab pages line
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set splitbelow
set splitright
set autowriteall
set pastetoggle=<F3>
set colorcolumn=80
set signcolumn=yes
set termguicolors
set cursorline
highlight ColorColumn ctermbg=0 guibg=lightgrey

"set statusline+=%F%m%r%h%w\ 
"set statusline+=%{fugitive#statusline()}\    
"set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
"set statusline+=\ [line\ %l\/%L]

" my conf ..
set statusline=%#DraculaOrangeBoldItalic#>\ 
set statusline+=%m%F%=
set statusline+=%#DraculaOrangeBoldItalic#\ \\%Y\ 
set statusline+=%#DraculaGreenBold#
set statusline+=\|\ %l/%L\ \|\ 
set statusline+=%#DraculaTodo#
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]\ 
set statusline+=%{fugitive#statusline()}\ =)
" get colors from -> :so $VIMRUNTIME/syntax/hitest.vim








" the prime
"set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
" end the prime




" this will install vim-plug if not installed
"if empty(glob('~/.config/nvim/autoload/plug.vim'))
"    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall
"endif
"let g:coc_global_extensions = [ 'coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier' ]  " list of CoC extensions needed
let g:coc_global_extensions = [
      \'coc-tslint-plugin', 
      \'coc-tsserver', 
      \'coc-css', 
      \'coc-html', 
      \'coc-json', 
      \'coc-prettier' 
      \]  " list of CoC extensions needed
let g:coc_node_path = '/home/alanj/.nvm/versions/node/v14.17.4/bin/node'

call plug#begin('~/.vim/plugged')
" :PlugInstall
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim', { 'as': 'dracula' }

" nvim lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'

" auto completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'


Plug 'williamboman/nvim-lsp-installer'
"Plug 'glepnir/lspsaga.nvim'

"Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'kyazdani42/nvim-tree.lua'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
Plug 'lewis6991/gitsigns.nvim'

" prettier
Plug 'sbdchd/neoformat'
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {

" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'


" dart flutter
"Plug 'jremmen/vim-ripgrep'
"Plug 'tpope/vim-fugitive'
"Plug 'leafgarland/typescript-vim'
"Plug 'vim-utils/vim-man'
"Plug 'lyuts/vim-rtags'
"Plug 'git@github.com:kien/ctrlp.vim.git'
"Plug 'git@github.com:valloric/YouCompleteMe.git'
"Plug 'mbbill/undotree'
"Plug 'dart-lang/dart-vim-plugin'
"Plug 'natebosch/vim-lsc'
"Plug 'natebosch/vim-lsc-dart'

" Debugger Plugins
"Plug 'puremourning/vimspector'
"Plug 'szw/vim-maximizer'

"Plug 'hrsh7th/nvim-compe'
"Plug 'glepnir/lspsaga.nvim'
"Plug 'simrat39/symbols-outline.nvim'
"Plug 'tjdevries/nlua.nvim'
"Plug 'tjdevries/lsp_extensions.nvim'
"Plug 'rust-lang/rust.vim'
"Plug 'darrikonn/vim-gofmt'
"Plug 'tpope/vim-fugitive'
"Plug 'junegunn/gv.vim'
"Plug 'vim-utils/vim-man'
"Plug 'mbbill/undotree'
"Plug 'tpope/vim-dispatch'
"Plug 'theprimeagen/vim-be-good'
"Plug 'gruvbox-community/gruvbox'
"Plug 'tpope/vim-projectionist'
" should I try another status bar???
"Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
"Plug 'hoob3rt/lualine.nvim'

"Plug 'ray-x/lsp_signature.nvim'
"Plug 'lewis6991/gitsigns.nvim'

"Plug 'flazz/vim-colorschemes'
"Plug 'chriskempson/base16-vim'

" HARPOON!!
"Plug '/home/mpaulson/personal/rfc-reader'
"Plug 'mhinz/vim-rfc'


call plug#end()
" :PlugInstall

" set colorscheme before lsp
let g:dracula_colorterm = 0
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
"highlight CursorLine ctermfg=White ctermbg=Red cterm=bold guifg=white guibg=red gui=bold
"highlight CursorLine ctermfg=White ctermbg=Red cterm=bold guifg=white guibg=red gui=bold
"highlight CursorLine guifg=white guibg=red gui=bold




let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_chain_complete_list = {
      \  'default': {
      \    'default': [
      \      {'complete_items': ['lsp','snippet']},
      \      {'complete_items': ['path'],'trigger_only':['/']},
      \      {'mode': '<c-p>'},
      \      {'mode': '<c-n>'}
      \      ]
      \    }
      \  }



" lsp configs
" attach completion
lua require'lspconfig'.denols.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.eslint.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.yamlls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.graphql.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.vuels.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.pylsp.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.jsonls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.bashls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.dockerls.setup{on_attach=require'completion'.on_attach}
"lua require'lspconfig'.sqlls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
"lua require'lspconfig'.sqls.setup{on_attach=require'completion'.on_attach}




" auto complete setup
set completeopt=menu,menuone,noselect
lua require('nvim-cmp-completion-configs')


" git signs
lua require('gitsigns').setup()


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
" coc commands - ini benda
"nnoremap leader e :CocCommand flutter.emulators CR
"nnoremap leader r :CocCommand flutter.run CR
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)





" remaps
let mapleader = " "
"let mapleader = "z"
"inoremap <CapsLock> <esc>
inoremap jj <esc><esc>
"inoremap jk <esc>
"inoremap kj <esc>
" to save on ESC
inoremap <C-s> <Esc>:write<CR>
nnoremap <C-s> <Esc>:write<CR>
"inoremap jj <Esc>:write<CR>
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>m :tablast<CR>




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
nnoremap <leader>sh :split<cr>
nnoremap <leader>sv :vsplit<cr>

" tabs
nnoremap <leader>c :tabclose<cr>
nnoremap <leader>tfs :tab split<cr>

" buffers
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bm :bm<cr>









if has('gui')
  set guioptions-=e
endif
if exists("+showtabline")
  function MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let s .= i . ':'
      let s .= '[' . winnr . '/' . tabpagewinnr(i,'$') . ']'
      let s .= ' %*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= file
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
   return s
  endfunction
  set tabline=%!MyTabLine()
endif

"set showtabline=1  " 0, 1 or 2; when to use a tab pages line
"set tabline=%!MyTabLine()  " custom tab pages line
"function MyTabLine()
"  let s = '' " complete tabline goes here
"  " loop through each tab page
"  for t in range(tabpagenr('$'))
"    " set highlight for tab number and &modified
"    let s .= '%#TabLineSel#'
"    " set the tab page number (for mouse clicks)
"    let s .= '%' . (t + 1) . 'T'
"    " set page number string
"    let s .= t + 1 . ':'
"    " get buffer names and statuses
"    let n = ''  "temp string for buffer names while we loop and check buftype
"    let m = 0  " &modified counter
"    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
"    " loop through each buffer in a tab
"    for b in tabpagebuflist(t + 1)
"      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
"      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
"      if getbufvar( b, "&buftype" ) == 'help'
"        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
"      elseif getbufvar( b, "&buftype" ) == 'quickfix'
"        let n .= '[Q]'
"      else
"        let n .= pathshorten(bufname(b))
"      endif
"      " check and ++ tab's &modified count
"      if getbufvar( b, "&modified" )
"        let m += 1
"      endif
"      " no final ' ' added...formatting looks better done later
"      if bc > 1
"        let n .= ' '
"      endif
"      let bc -= 1
"    endfor
"    " add modified label [n+] where n pages in tab are modified
"    if m > 0
"      let s .= '[' . m . '+]'
"    endif
"    " select the highlighting for the buffer names
"    " my default highlighting only underlines the active tab
"    " buffer names.
"    if t + 1 == tabpagenr()
"      let s .= '%#TabLine#'
"    else
"      let s .= '%#TabLineSel#'
"    endif
"    " add buffer names
"    let s .= n
"    " switch to no underlining and add final space to buffer list
"    let s .= '%#TabLineSel#' . ' '
"  endfor
"  " after the last tab fill with TabLineFill and reset tab page nr
"  let s .= '%#TabLineFill#%T'
"  " right-align the label to close the current tab page
"  if tabpagenr('$') > 1
"    let s .= '%=%#TabLineFill#%999Xclose'
"  endif
"  return s
"endfunction




















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
"nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>

" >> Telescope bindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

" nvim-tree
nnoremap <leader>ft :NvimTreeToggle<CR>
nnoremap <leader>ntr :NvimTreeRefresh<CR>
nnoremap <leader>fntf :NvimTreeFindFile<CR>


"nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.builtin{}<CR>
"" most recently used files
"nnoremap <Leader>m <cmd>lua require'telescope.builtin'.oldfiles{}<CR>
"" find buffer
"nnoremap ; <cmd>lua require'telescope.builtin'.buffers{}<CR>
"" find in current buffer
"nnoremap <Leader>/ <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
"" bookmarks
"nnoremap <Leader>' <cmd>lua require'telescope.builtin'.marks{}<CR>
"" git files
"nnoremap <Leader>f <cmd>lua require'telescope.builtin'.git_files{}<CR>
"" all files
"nnoremap <Leader>bfs <cmd>lua require'telescope.builtin'.find_files{}<CR>
"" ripgrep like grep through dir
"nnoremap <Leader>rg <cmd>lua require'telescope.builtin'.live_grep{}<CR>
"" pick color scheme
"nnoremap <Leader>cs <cmd>lua require'telescope.builtin'.colorscheme{}<CR>



" lsp nindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

"autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)


"-- lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
"-- or use command LspSagaFinder
nnoremap <silent> gh :Lspsaga lsp_finder<CR>

"-- code action
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
"-- or use command
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

"-- show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
"-- or use command
nnoremap <silent>K :Lspsaga hover_doc<CR>

"-- scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
"-- scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>


"-- show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
"-- or command
nnoremap <silent> gs :Lspsaga signature_help<CR>

"and you also can use smart_scroll_with_saga to scroll in signature help win

"-- rename
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
"-- or command
nnoremap <silent>gr :Lspsaga rename<CR>
"-- close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`


"-- preview definition
nnoremap <silent> pd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
"-- or use command
nnoremap <silent> pd :Lspsaga preview_definition<CR>

"can use smart_scroll_with_saga to scroll


"-- show
nnoremap <silent><leader>cd <cmd>lua
"require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
"-- only show diagnostic if cursor is over the area
nnoremap <silent><leader>cc <cmd>lua
"require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

"-- jump diagnostic
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
"-- or use command
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>





















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
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]




" File Find {{{
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
"saving the previous one

" }}}


" telescope setup
lua require('telescope-configs')


" other lua imports

lua require('nvim-tree-configs')
lua require('minethconfigs')
highlight CursorLine gui=BOLD guifg=none guibg=black



" neovide stuff
let g:neovide_cursor_vfx_mode = "railgun"










