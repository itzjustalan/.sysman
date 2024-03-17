-- vim.cmd [[ command! ToggleEOLS execute set list listchars=tab:>\ ,trail:.,eol:$ ]]
-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
vim.cmd [[ command! ReloadNvim execute "source ~/.config/nvim/init.lua" ]]

local M = {}

M.ToggleEOLS = function()
  print('ToggleEOLS')
  print(vim.inspect(vim.opt.listchars))
end


return M
