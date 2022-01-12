vim.cmd [[
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  autocmd InsertEnter * norm zz
  autocmd FileType tex,txt,latex,markdown setlocal spell spelllang=en_us
]]

-- save / load code folding
--augroup remember_folds
--  autocmd!
--  autocmd BufWinLeave * mkview
--  autocmd BufWinEnter * silent! loadview
--augroup END
