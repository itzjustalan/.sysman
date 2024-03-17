--vim.opt.guicursor = ""	-- block cursor

vim.opt.nu = true		-- line numbers
vim.opt.relativenumber = true	-- relative line numbers

-- tab space configs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- indentation - usually handled by lsp
vim.opt.smartindent = true

-- line wrap
vim.opt.wrap = false

-- undo stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search stuff
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enables 24-bit RGB color in the |TUI
vim.opt.termguicolors = true

vim.opt.scrolloff = 8			-- keep 8 lines at the top and bottom at all times on scroll
vim.opt.signcolumn = "yes"		-- sign colum stuff
vim.opt.isfname:append("@-@")		-- dangerously set file name chars

vim.opt.updatetime = 100		-- write swapfile on idle time

vim.opt.colorcolumn = "80"		-- color column offset



