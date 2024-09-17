-- set space as leader
vim.g.mapleader = ' '

-- todo-comments
local todo = require('todo-comments')
vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "Previous todo comment" })

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
