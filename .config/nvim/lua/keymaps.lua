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
vim.keymap.set({ 'n', 'v', 'o' }, 'J', '3j', { desc = "Vim: Fast Scroll Down - 3*j", remap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'K', '3k', { desc = "Vim: Fast Scroll Up - 3*k", remap = true, silent = true })

---- keep scrolling down if reach eof, mostly to see jupyter virtual text if codeblock is at eof
vim.keymap.set('n', 'j', "line('.') == line('$') ? '<C-e>' : 'j'", { remap = true, expr = true })

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
vim.keymap.set('n', '<leader>fu', "<cmd>Telescope undo<cr>",
  { desc = "Telescope: Undo", silent = true })

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
    vim.keymap.set("n", "<leader>jR", ':MoltenRestart<CR>',
      { desc = "Molten: Restart Kernel", silent = true })
    vim.keymap.set("n", "<leader>jr", ':MoltenRestart!<CR>',
      { desc = "Molten: Restart Kernel and Clear All", silent = true })
    vim.keymap.set("n", "<leader>je", ':noautocmd MoltenEnterOutput<CR>',
      { desc = "Molten: Enter Output", silent = true })

    -- markdown-preview
    vim.keymap.set("n", "<leader>jo", ":MarkdownPreviewToggle<CR>", { desc = "Markdown Preview", silent = true })

    -- jupyter (cli)
    local function convert_and_open_notebook(use_pretty_style)
      local current_file = vim.fn.expand('%:p')
      if not current_file:match('%.ipynb$') then
        vim.notify('Current file is not a Jupyter notebook', vim.log.levels.ERROR)
        return
      end

      local open_cmd = vim.fn.has('mac') == 1 and 'open' or 'xdg-open'
      local html_file = vim.fn.expand('%:p:r') .. '.html'

      local convert_cmd
      if use_pretty_style then
        convert_cmd = string.format('jt -t gruvboxl && jupyter nbconvert %s --to html --template lab', current_file)
      else
        convert_cmd = string.format('jt -r || jupyter nbconvert %s --to html --template lab',
          current_file)
      end
      local convert_result = vim.fn.system(convert_cmd)
      if vim.v.shell_error ~= 0 then
        vim.notify('Failed to convert notebook: ' .. convert_result, vim.log.levels.ERROR)
        return
      end

      if use_pretty_style then
        local css_inject_cmd = string.format([[
          sed -i.bak '/<\/head>/i\
          <style>\
            .jp-RenderedHTMLCommon code { background-color: rgba(128,128,128,0.1); padding: 2px 4px; border-radius: 3px; }\
            .jp-RenderedHTMLCommon pre { background-color: rgba(128,128,128,0.1); padding: 1em; border-radius: 5px; margin: 0; width: 100%%; box-sizing: border-box; }\
          </style>' %s && rm %s.bak
        ]], html_file, html_file)

        vim.fn.system(css_inject_cmd)
      end

      local open_result = vim.fn.system(string.format('%s %s', open_cmd, html_file))
      if vim.v.shell_error ~= 0 then
        vim.notify('Failed to open browser: ' .. open_result, vim.log.levels.ERROR)
        return
      end

      vim.notify('Notebook converted and opened in browser', vim.log.levels.INFO)
    end

    local function open_html_in_browser()
      convert_and_open_notebook(false)
    end

    local function open_pretty_html_in_browser()
      convert_and_open_notebook(true)
    end

    vim.keymap.set('n', '<leader>jh', open_html_in_browser, { desc = "Jupyter: Open in Browser", silent = true })
    vim.keymap.set('n', '<leader>jp', open_pretty_html_in_browser,
      { desc = "Jupyter: Open in Browser (Pretty)", silent = true })
  end
})

-- flash
local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end,
  { desc = "Flash: Treesitter", silent = true })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end,
  { desc = "Flash: Treesitter", silent = true })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Flash: Remote", silent = true })
vim.keymap.set({ "o", "x" }, "R", function() flash.treesitter_search() end,
  { desc = "Flash: Treesitter Search", silent = true })
vim.keymap.set("c", "<c-s>", function() flash.toggle() end, { desc = "Flash: Toggle Search", silent = true })

-- raycast
vim.keymap.set('v', '<leader>r',
  '"+y<ESC>:lua vim.fn.system("open \'raycast://ai-commands/explain-code-step-by-step-clipboard\'")<CR>',
  { desc = "Raycast: Explain Code", silent = true })

-- codecompanion
local codecompanion = require("codecompanion")
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>",
  { desc = "CodeCompanion: Toggle", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>",
  { desc = "CodeCompanion: Actions", silent = true })
vim.keymap.set("v", "<leader>cc", "<cmd>CodeCompanionChat Add<cr>",
  { desc = "CodeCompanion: Add to Chat", silent = true })
vim.keymap.set("v", "<leader>ce", function()
  codecompanion.prompt("explain")
end, { desc = "CodeCompanion: Explain Code", silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
