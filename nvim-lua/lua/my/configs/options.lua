local options = {
  backup = false,                           -- creates a backup file
  -- undodir = '~/.vim/undodir',            -- undo directory
  undofile = false,                          -- enable persistent undo
  termguicolors = true,                     -- set term gui colors (most terminals support this)
  clipboard = 'unnamedplus',                -- allows vim to access the system clipboard
  -- syntax = 'on',                            -- vim native syntax highlighting
  exrc = true,                              -- load local config file
  number = true,                            -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  incsearch = true,                         -- highlight the search pattern as you type
  hlsearch = false,                         -- remove highlights after search
  hidden = true,                            -- unload buffer when abandoned
  belloff = 'all',                          -- vibrator lol
  errorbells = false,                       -- cpu can shfu
  scrolloff = 8,                            -- start scrolling before the last n lines
  showtabline = 1,                          -- 0, 1 or 2; when to use a tab pages line
  encoding = 'utf-8',                       -- String-encoding used internally and for |RPC| communication.
  expandtab = true,                         -- insert spaces for tabs
  tabstop = 2,                              -- insert 2 spaces for a tab
  softtabstop = 2,                          -- number of virtual space characters in editing mode
  shiftwidth = 2,                           -- number of space characters while shifting intendation
  smartindent = true,                       -- new line starts with intendation
  wrap = true,                              -- wrap lines
  ignorecase = true,                        -- ignore cases when searching
  smartcase = true,                         -- override ignorecase when search string has upper case
  swapfile = false,                         -- create swap files
  splitbelow = true,                        -- force all horizontal splits to go below current window
  splitright = true,                        -- force all vertical splits to go to the right of current window
  autowrite = true,                         -- automatically write to file alse see: autowriteall
  pastetoggle = '<F3>',                     -- toggle pretty pasting
  colorcolumn = { 80 },                         -- show line on 80 chars
  signcolumn = 'yes',                       -- always show the sign column, otherwise it would shift the text each time
  cursorline = true,                        -- highlight the current line
  --cmdheight = 2,                          -- more space in the vim command line for displaying messages
  completeopt = { 'menuone', 'noselect' },  -- mostly just for cmp
  conceallevel = 0,                         -- so that `` is visible in markdown files
  fileencoding = 'utf-8',                   -- the encoding written to a file
  --hlsearch = true,                          -- highlight all matches on previous search pattern
  mouse = 'a',                              -- allow the mouse to be used in vim
  pumheight = 10,                           -- pop up menu height
  showmode = false,                         -- we don't need to see things like -- INSERT -- anymore
  timeoutlen = 800,                         -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300,                         -- faster completion (4000ms default)
  writebackup = false,                      -- if a file is being edited by another program (or was written to file while editing with ano
  numberwidth = 4,                          -- set number column width to 2 {default 4}
  sidescrolloff = 8,
  guifont = 'monospace:h17',                -- the font used in graphical vim applications
}

vim.opt.shortmess:append 'c'                -- TODO: look more into it, its awesome

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd 'set whichwrap+=<,>,[,],h,l'
--vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- FIX: this doesn't seem to work
vim.cmd 'highlight ColorColumn ctermbg=0 guibg=lightgrey'
vim.cmd 'hi Normal guibg=NONE ctermbg=NONE' -- transparant background

vim.cmd "let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]"

-- The End
