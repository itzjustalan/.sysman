-- configurations
--
-- tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_terminal_colors = true
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_sidebars = { 'nvimtree' }
-- vim.g.tokyonight_transparent_sidebar = true

local colorscheme = 'tokyonight-night'
--local colorscheme = 'codemonkey'
--local colorscheme = 'darkplus'
-- local colorscheme = 'onedarker'
-- vim.cmd 'colorscheme darkblue'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
-- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE' -- transparant background
-- vim.cmd 'hi Normal guibg=011627 ctermbg=011627'
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  vim.cmd 'colorscheme darkblue'
  return
end
