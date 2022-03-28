local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- write as sudo
vim.cmd 'cmap w!! w !sudo tee %'

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Save file with Control s sorry
keymap("n", "<C-s>", "<Esc>:write<CR>", opts)

-- Better window navigation
--keymap("n", "<leader>h", "<C-w>h", opts)
--keymap("n", "<leader>j", "<C-w>j", opts)
--keymap("n", "<leader>k", "<C-w>k", opts)
--keymap("n", "<leader>l", "<C-w>l", opts)
keymap("n", "<leader>h", ":wincmd h<cr>", opts)
keymap("n", "<leader>j", ":wincmd j<cr>", opts)
keymap("n", "<leader>k", ":wincmd k<cr>", opts)
keymap("n", "<leader>l", ":wincmd l<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-j>", ":bnext<CR>", opts)
keymap("n", "<S-k>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- escape
keymap("i", "jj", "<esc><esc>", opts)
keymap("i", "ji", "<esc><esc>:join<cr>i", opts)

-- Save file with Control s sorry
keymap("i", "<C-s>", "<Esc>:write<CR>", opts)

-- Visual --
-- escape
keymap("v", "lkj", "<esc><esc>", opts)
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- local term_opts = { silent = true }
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope --
-- find files
--keymap('n', '<leader>f', '<cmd>lua require "telescope.builtin".find_files(require("telescope.themes").get_dropdown({ previewer=10 }))<cr>', opts)
-- keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
-- keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
-- keymap("n", "<leader>ps", ":lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>", opts)
-- keymap("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>", opts)
-- keymap("n", "<Leader>pf", ":lua require('telescope.builtin').find_files()<CR>", opts)
-- --keymap("n", "<leader>pw", ":lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>", opts)
-- keymap("n", "<leader>pb", ":lua require('telescope.builtin').buffers()<CR>", opts)
-- keymap("n", "<leader>vh", ":lua require('telescope.builtin').help_tags()<CR>", opts)

-- Nvim Tree
keymap("n", "<leader>b", ":NvimTreeToggle<cr>", opts)
