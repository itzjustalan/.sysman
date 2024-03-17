--require('rose-pine').setup({
--    disable_background = true
--})

function ColorMyPencilsCuzThePrimeToldMeSo(colorscheme)
	colorscheme = colorscheme or "rose-pine"
	vim.cmd.colorscheme(colorscheme)

	-- transparant bg
	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencilsCuzThePrimeToldMeSo()
