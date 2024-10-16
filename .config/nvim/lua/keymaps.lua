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
-- if you work with html outputs:
vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })

-- outline
vim.keymap.set("n", "<leader>o", ":Outline!<CR>", { desc = "Toggle Outline" })

-- use tab to switch to next pane
vim.api.nvim_set_keymap('n', '<Tab>', '<C-w>w', { noremap = true, silent = true })

-- toggle between current and previous buffer (backspace)
vim.api.nvim_set_keymap('n', '<bs>', '<c-^>zz', { noremap = true, silent = true })

-- make new panes
vim.api.nvim_set_keymap('n', '<leader>d', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>D', '<C-w>s', { noremap = true, silent = true })

-- search google
local searching_google_in_normal =
[[:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.expand("<cword>")})<CR>]]
local searching_google_in_visual =
[[<ESC>gv"gy<ESC>:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.getreg('g')})<CR>]]
vim.keymap.set("n", "<leader>g", searching_google_in_normal, { silent = true, noremap = true })
vim.keymap.set("v", "<leader>g", searching_google_in_visual, { silent = true, noremap = true })

-- neotree
vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree action=show toggle<CR>', { noremap = true, silent = true })

----
-- treesitter keymaps in plugins/treesitter.lua
----

-- luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "x" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, desc = "expand snippet or jump to the next snippet node" })

vim.keymap.set({ "i", "x" }, "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, desc = "previous spot in the snippet" })

vim.keymap.set({ "i", "x" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true, desc = "next snippet choice" })

vim.keymap.set({ "i", "x" }, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end, { silent = true, desc = "previous snippet choice" })


-- lsp
vim.keymap.set('n', '<leader>dd', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = "toggle lsp diagnostics" })

-- floating keybinding help for lsp
_G.show_lsp_zero_keybindings = function()
  local keybindings = {
    { key = "K",  desc = "Hover Documentation" },
    { key = "gd", desc = "Go to Definition" },
    { key = "gD", desc = "Go to Declaration" },
    { key = "gi", desc = "Go to Implementation" },
    { key = "go", desc = "Go to Type Definition" },
    { key = "gr", desc = "List References" },
    { key = "gs", desc = "Display Signature" },
    { key = "F2", desc = "Rename" },
    { key = "F3", desc = "Format" },
    { key = "F4", desc = "Code Action" },
    { key = "[d", desc = "Previous Diagnostic" },
    { key = "]d", desc = "Next Diagnostic" },
  }

  local lines = { "LSP-Zero Keybindings:" }
  for _, binding in ipairs(keybindings) do
    table.insert(lines, string.format("%s: %s", binding.key, binding.desc))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 40
  local height = #lines
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = "minimal",
    border = "rounded",
  })

  -- Close the window when pressing 'q' or '<Esc>'
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
end

vim.api.nvim_set_keymap('n', '<leader>/', ':lua _G.show_lsp_zero_keybindings()<CR>', { noremap = true, silent = true })

-- oil
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { silent = true, noremap = true })

-- raycast
vim.api.nvim_set_keymap('v', '<leader>a',
  '"+y<ESC>:lua vim.fn.system("open \'raycast://ai-commands/explain-code-step-by-step-clipboard\'")<CR>',
  { noremap = true, silent = true })

-- codewindow
local codewindow = require('codewindow')
vim.keymap.set('n', '<leader>mo', codewindow.open_minimap, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mc', codewindow.close_minimap, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mf', codewindow.toggle_focus, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mm', codewindow.toggle_minimap, { noremap = true, silent = true })
