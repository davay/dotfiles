--[[
-- NOTE:
-- Not all keymaps are listed here.
-- Plugins that set their own keymaps for global buffers are:
-- - Nvim-cmp
-- - mini.surround
-- - whichkey
-- - mini.diff
--]]

-- set space as leader
vim.g.mapleader = ' '

-- general vim hotkeys

vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = "Vim: Inverse Tab Indent", silent = true })

---- use tab to switch to next/prev pane
vim.keymap.set('n', '<Tab>', '<C-w>w', { desc = "Vim: Next Pane", silent = true })
vim.keymap.set('n', '<S-Tab>', '<C-w>W', { desc = "Vim: Prev Pane", silent = true })

---- toggle between current and previous buffer (backspace)
vim.keymap.set('n', '<bs>', '<c-^>zz', { desc = "Vim: Toggle Buffer", silent = true })

---- unload current buffer
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Vim: Delete Buffer", silent = true })

---- switch to next/prev buffer
vim.keymap.set('n', '<leader>bf', ':bnext<CR>', { desc = "Vim: Next Buffer", silent = true })
vim.keymap.set('n', '<leader>bb', ':bprev<CR>', { desc = "Vim: Prev Buffer", silent = true })

---- make new panes
vim.keymap.set('n', '<leader>d', '<C-w>v', { desc = "Vim: Split Vertical", silent = true })
vim.keymap.set('n', '<leader>D', '<C-w>s', { desc = "Vim: Split Horizontal", silent = true })

---- faster scroll
vim.keymap.set('n', 'J', '3j', { desc = "Vim: Fast Scroll Down - 3*j", silent = true })
vim.keymap.set('n', 'K', '3k', { desc = "Vim: Fast Scroll Up - 3*k", silent = true })
---- search google
-- local searching_google_in_normal =
-- [[:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.expand("<cword>")})<CR>]]
-- local searching_google_in_visual =
-- [[<ESC>gv"gy<ESC>:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.getreg('g')})<CR>]]
-- vim.keymap.set("n", "<leader>g", searching_google_in_normal, { silent = true })
-- vim.keymap.set("v", "<leader>g", searching_google_in_visual, { silent = true })

-- todo-comments
local todo = require('todo-comments')
vim.keymap.set("n", "<leader>t", function() todo.jump_next() end, { desc = "TODO: Next Comment" })
vim.keymap.set("n", "<leader>T", function() todo.jump_prev() end, { desc = "TODO: Previous Comment" })

-- telescope
local telescope = require('telescope.builtin') -- Create a function with your preferred options

vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Telescope: Find Files", silent = true })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = "Telescope: Live Grep", silent = true })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = "Telescope: Buffers", silent = true })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = "Telescope: Help Tags", silent = true })
vim.keymap.set('n', '<leader>fm', telescope.man_pages, { desc = "Telescope: Man Pages", silent = true })
vim.keymap.set('n', '<leader>fc', function() telescope.colorscheme({ enable_preview = true }) end,
  { desc = "Telescope: Colorscheme", silent = true })
vim.keymap.set('n', '<leader>fr', telescope.lsp_references,
  { desc = "Telescope: LSP References", silent = true })
vim.keymap.set('n', '<leader>fo', telescope.lsp_outgoing_calls,
  { desc = "Telescope: LSP Outgoing Calls", silent = true })
vim.keymap.set('n', '<leader>fi', telescope.lsp_incoming_calls,
  { desc = "Telescope: LSP Incoming Calls", silent = true })

-- leetcode
vim.keymap.set('n', '<leader>lr', ':Leet run<CR>', { desc = "Leetcode: Run", silent = true })
vim.keymap.set('n', '<leader>ls', ':Leet submit<CR>', { desc = "Leetcode: Submit", silent = true })
vim.keymap.set('n', '<leader>lm', ':Leet<CR>', { desc = "Leetcode: Menu", silent = true })
vim.keymap.set('n', '<leader>lc', ':Leet console<CR>', { desc = "Leetcode: Console", silent = true })

-- outline
vim.keymap.set("n", "<leader>o", ":Outline<CR>", { desc = "Outline: Toggle", silent = true })

-- neotree
vim.keymap.set('n', '<leader>n', ':Neotree action=focus reveal=true toggle<CR>',
  { desc = "Neotree: Toggle", silent = true }) -- action=focus/show

-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map('n', '<C-k>', vim.lsp.buf.hover, 'LSP: Hover Documentation')
    map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to Definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to Declaration')
    map('n', 'gi', vim.lsp.buf.implementation, 'LSP: Go to Implementation')
    map('n', 'go', vim.lsp.buf.type_definition, 'LSP: Go to Type Definition')
    map('n', 'gr', vim.lsp.buf.references, 'LSP: Find References')
    map('n', 'gs', vim.lsp.buf.signature_help, 'LSP: Show Signature Help')
    map('n', '<F2>', vim.lsp.buf.rename, 'LSP: Rename')
    map({ 'n', 'x' }, '<F3>', function()
      vim.notify("Formatting..")
      vim.lsp.buf.format({ async = true })
    end, 'LSP: Format')
    map('n', '<F4>', vim.lsp.buf.code_action, 'LSP: Code Action')
  end
})

---- Toggle diagnostics
vim.keymap.set('n', '<leader>dd', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, desc = "LSP: Toggle Diagnostics" })

---- floating keybinding help for lsp
local show_lsp_zero_keybindings = function()
  local keybindings = {
    { key = "<C-k>", desc = "Hover Documentation" },
    { key = "gd",    desc = "Go to Definition" },
    { key = "gD",    desc = "Go to Declaration" },
    { key = "gi",    desc = "Go to Implementation" },
    { key = "go",    desc = "Go to Type Definition" },
    { key = "gr",    desc = "List References" },
    { key = "gs",    desc = "Show Signature" },
    { key = "F2",    desc = "Rename" },
    { key = "F3",    desc = "Format" },
    { key = "F4",    desc = "Code Action" },
    { key = "[d",    desc = "Previous Diagnostic" },
    { key = "]d",    desc = "Next Diagnostic" },
  }

  local lines = { "LSP-Zero Keybindings:" }
  for _, binding in ipairs(keybindings) do
    table.insert(lines, string.format("%s: %s", binding.key, binding.desc))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 40
  local height = #lines
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = "minimal",
    border = "rounded",
  })

  -- Close the window when pressing 'q' or '<Esc>'
  vim.keymap.set('n', 'q', ':close<CR>', { buffer = buf, desc = "Keybind Help: Close", silent = true })
  vim.keymap.set('n', '<Esc>', ':close<CR>', { buffer = buf, desc = "Keybind Help: Close", silent = true })
end

vim.keymap.set('n', '<leader>.', show_lsp_zero_keybindings,
  { desc = "Keybind Help: Open", silent = true })

-- grug-far
vim.keymap.set('n', '<leader>g', ':GrugFar<CR>', { desc = "GrugFar", silent = true })

-- raycast
vim.keymap.set('v', '<leader>a',
  '"+y<ESC>:lua vim.fn.system("open \'raycast://ai-commands/explain-code-step-by-step-clipboard\'")<CR>',
  { desc = "Raycast: Explain Code", silent = true })

-- codewindow
local codewindow = require('codewindow')
vim.keymap.set('n', '<leader>mf', codewindow.toggle_focus, { desc = "Codewindow: Focus", silent = true })
vim.keymap.set('n', '<leader>mm', codewindow.toggle_minimap,
  { desc = "Codewindow: Toggle", silent = true })

-- jupyter stuff; treesitter textobjects, molten, quarto
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    ---- treesitter
    vim.keymap.set("n", "]]", ":TSTextobjectGotoNextStart @code_cell.inner | norm! zz<CR>",
      { desc = "TS: Next Code Block", silent = true, buffer = true })
    vim.keymap.set("n", "[[", ":TSTextobjectGotoPreviousStart @code_cell.inner | norm! zz<CR>",
      { desc = "TS: Prev Code Block", silent = true, buffer = true })
    vim.keymap.set({ "x", "o" }, "ib", ":<C-u>TSTextobjectSelect @code_cell.inner<CR>",
      { desc = "TS: Select Inner Block", silent = true, buffer = true })
    vim.keymap.set({ "x", "o" }, "ab", ":<C-u>TSTextobjectSelect @code_cell.outer<CR>",
      { desc = "TS: Select Around Block", silent = true, buffer = true })

    -- quarto
    local runner = require("quarto.runner")
    vim.keymap.set("n", "<leader>jc", runner.run_cell, { desc = "Quarto: Run Cell", silent = true })
    vim.keymap.set("n", "<leader>ja", runner.run_above,
      { desc = "Quarto: Run Cell and Above", silent = true })
    vim.keymap.set("n", "<leader>jA", runner.run_all, { desc = "Quarto: Run All Cells", silent = true })
    vim.keymap.set("n", "<leader>jl", runner.run_line, { desc = "Quarto: Run Line", silent = true })
    vim.keymap.set("v", "<leader>j", runner.run_range, { desc = "Quarto: Run Visual Range", silent = true })

    -- molten
    vim.keymap.set("n", "<leader>jr", ':MoltenRestart<CR>',
      { desc = "Molten: Restart Kernel", silent = true })
    vim.keymap.set("n", "<leader>jR", ':MoltenRestart!<CR>',
      { desc = "Molten: Restart Kernel and Clear All", silent = true })
    ---- if you work with html outputs:
    vim.keymap.set("n", "<leader>jh", ":MoltenOpenInBrowser<CR>",
      { desc = "Molten: Open in Browser", silent = true })

    -- markdown-preview
    vim.keymap.set("n", "<leader>jo", ":MarkdownPreviewToggle<CR>", { desc = "Markdown Preview", silent = true })
  end
})

-- flash
local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end,
  { desc = "Flash: Treesitter", silent = true })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Flash: Remote", silent = true })
vim.keymap.set({ "o", "x" }, "R", function() flash.treesitter_search() end,
  { desc = "Flash: Treesitter Search", silent = true })
vim.keymap.set("c", "<c-s>", function() flash.toggle() end, { desc = "Flash: Toggle Search", silent = true })
