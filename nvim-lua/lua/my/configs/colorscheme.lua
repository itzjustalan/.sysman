-- vim.cmd 'colorscheme darkblue'

local colorscheme = 'tokyonight'
--local colorscheme = 'codemonkey'
--local colorscheme = 'darkplus'
-- local colorscheme = 'onedarker'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
--vim.cmd 'hi Normal guibg=NONE ctermbg=NONE' -- transparant background
--vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
--vim.cmd 'hi Normal guibg=011627 ctermbg=011627'
-- vim.cmd("hi Normal guibg=#011627 ctermbg=#011627")
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  vim.cmd 'colorscheme darkblue'
  return
end
