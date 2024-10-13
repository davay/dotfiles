-- set space as leader
vim.g.mapleader = ' '

-- todo-comments
local todo = require('todo-comments')
vim.keymap.set("n", "<leader>t", function() todo.jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "<leader>T", function() todo.jump_prev() end, { desc = "Previous todo comment" })

-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

-- leetcode
vim.keymap.set('n', '<leader>lr', ':Leet run<CR>', {})
vim.keymap.set('n', '<leader>ls', ':Leet submit<CR>', {})
vim.keymap.set('n', '<leader>lm', ':Leet<CR>', {})
vim.keymap.set('n', '<leader>lc', ':Leet console<CR>', {})

-- if you work with html outputs:
vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })

-- quarto & molten for jupyter
local runner = require("quarto.runner")
vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<leader>[", ':MoltenPrev<CR>', { desc = "jump to prev cell", silent = true })
vim.keymap.set("n", "<leader>]", ':MoltenNext<CR>', { desc = "jump to next cell", silent = true })
vim.keymap.set("n", "<leader>mr", ':MoltenRestart<CR>', { desc = "restart kernel", silent = true })
vim.keymap.set("n", "<leader>rr", ':MoltenRestart!<CR>', { desc = "restart kernel and clear all", silent = true })

-- outline
vim.keymap.set("n", "<leader>o", ":Outline!<CR>", { desc = "Toggle Outline" })

-- use tab to switch to next pane
vim.api.nvim_set_keymap('n', '<Tab>', '<C-w>w', { noremap = true, silent = true })

-- toggle between current and previous buffer
vim.api.nvim_set_keymap('n', '<bs>', '<c-^>zz', { noremap = true, silent = true })

-- make new panes
vim.api.nvim_set_keymap('n', '<leader>d', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>D', '<C-w>s', { noremap = true, silent = true })

-- search google
local searching_google_in_normal =
[[:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.expand("<cword>")})<CR>]]
local searching_google_in_visual =
[[<ESC>gv"gy<ESC>:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.getreg('g')})<CR>]]
vim.api.nvim_set_keymap("n", "<leader>g", searching_google_in_normal, { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "<leader>g", searching_google_in_visual, { silent = true, noremap = true })

-- neotree
vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree action=show toggle<CR>', { noremap = true, silent = true })
