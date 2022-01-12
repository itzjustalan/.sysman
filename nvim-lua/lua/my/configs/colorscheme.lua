-- vim.cmd 'colorscheme darkblue'

--local colorscheme = 'tokyonight'
--local colorscheme = 'codemonkey'
local colorscheme = 'darkplus'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
--vim.cmd 'hi Normal guibg=NONE ctermbg=NONE' -- transparant background
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  vim.cmd 'colorscheme darkblue'
  return
end
