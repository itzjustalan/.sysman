vim.cmd [[
  " some quality of life imrovements
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  autocmd InsertEnter * norm zz
  autocmd FileType tex,txt,latex,markdown setlocal spell spelllang=en_us
  autocmd BufWritePre *.go lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.go lua OrganizeGOImports(400)

  " auto folds with indentation
  augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
  augroup END

  " persistent code folding
  "augroup persistent_folds
  "  autocmd!
  "  autocmd BufWinLeave * mkview
  "  autocmd BufWinEnter * silent! loadview
  "augroup END
]]


-- save / load code folding
--augroup remember_folds
--  autocmd!
--  autocmd BufWinLeave * mkview
--  autocmd BufWinEnter * silent! loadview
--augroup END
