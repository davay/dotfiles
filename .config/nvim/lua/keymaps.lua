--[[
-- NOTE:
-- Not all keymaps are listed here.
-- Plugins that set their own keymaps for global buffers are:
-- - Nvim-cmp
-- - mini.surround
-- - whichkey
-- - mini.diff
--
-- Other plugins with their own buffers and keymaps:
-- - GrugFar
-- - Outline
-- - ??? Many more
--]]

-- set space as leader
vim.g.mapleader = ' '

-- general vim hotkeys
---- disable these default hotkeys that I don't use but sometimes misclick
---- C-o is treated the same as C-O
---- TIL: <C-I> is the same as tab
vim.keymap.set('n', '<C-O>', '<nop>')

---- safer quit
-- vim.keymap.set('c', 'q<CR>', function()
--   -- Get the number of listed buffers
--   local buffer_count = #vim.fn.getbufinfo({ buflisted = 1 })
--
--   -- If this is the last buffer, quit
--   if buffer_count <= 1 then
--     return 'q<CR>'
--   else
--     -- Otherwise delete the buffer
--     return 'bd!<CR>'
--   end
-- end, { expr = true, desc = "Vim: Safer q" })

---- always close no matter how many buffers (e.g., for neo-tree and outline)
vim.keymap.set('c', 'q<CR>', 'qa<CR>', { desc = "Vim: Alias q to qa", silent = true })
vim.keymap.set('c', 'q!<CR>', 'qa!<CR>', { desc = "Vim: Alias q! to qa!", silent = true })
vim.keymap.set('c', 'x<CR>', 'xa<CR>', { desc = "Vim: Alias x to xa", silent = true })
vim.keymap.set('c', 'x!<CR>', 'xa!<CR>', { desc = "Vim: Alias x! to xa!", silent = true })

---- inverse tab indent
vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = "Vim: Inverse Tab Indent", silent = true })

---- use tab to switch to next/prev pane
vim.keymap.set('n', '<Tab>', '<C-w>w', { desc = "Vim: Next Pane", silent = true })
vim.keymap.set('n', '<S-Tab>', '<C-w>W', { desc = "Vim: Prev Pane", silent = true })

---- shortcut to center
vim.keymap.set('n', 'Z', 'zz', { desc = "Vim: Center Screen", silent = true })

---- toggle between current and previous buffer (\)
vim.keymap.set('n', '\\', function()
  if not vim.tbl_contains({ 'neo-tree', 'Outline', 'qf' }, vim.bo.filetype) then
    vim.cmd.buffer('#')  -- most recent buffer
    vim.cmd.normal('zz') -- center
  end
end, { desc = "Vim: Toggle Buffer", silent = true })

---- close current tab
vim.keymap.set('n', '<leader>bt', '<cmd>tabclose<CR>', { desc = "Vim: Close Tab", silent = true })

---- close current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete!<CR>', { desc = "Vim: Close Buffer", silent = true })

---- switch to next/prev buffer
vim.keymap.set('n', '<leader>bf', '<cmd>bnext<CR>', { desc = "Vim: Next Buffer", silent = true })
vim.keymap.set('n', '<leader>bb', '<cmd>bprev<CR>', { desc = "Vim: Prev Buffer", silent = true })

---- make new panes
vim.keymap.set('n', '<leader>d', '<C-w>v', { desc = "Vim: Split Vertical", silent = true })
vim.keymap.set('n', '<leader>D', '<C-w>s', { desc = "Vim: Split Horizontal", silent = true })

---- rapid scrolling, also move by visual line than actual line -- good for soft wraps
------ remap = true to allow mini.animate to remap up/down in case it's enabled
vim.keymap.set({ "n", "v", "o" }, "j", "gj", { desc = "Vim: Move down 1 visual line", silent = true })
vim.keymap.set({ "n", "v", "o" }, "k", "gk", { desc = "Vim: Move up 1 visual line", silent = true })
vim.keymap.set({ "n", "v", "o" }, "H", "3h", { desc = "Vim: Fast Scroll Left - 3*h", silent = true })
vim.keymap.set({ "n", "v", "o" }, "J", "3gj", { desc = "Vim: Fast Scroll Down - 3*j", silent = true })
vim.keymap.set({ "n", "v", "o" }, "K", "3gk", { desc = "Vim: Fast Scroll Up - 3*k", silent = true })
vim.keymap.set({ "n", "v", "o" }, "L", "3l", { desc = "Vim: Fast Scroll Right - 3*l", silent = true })

---- keep scrolling down if reach eof, mostly to see jupyter virtual text if codeblock is at eof
vim.keymap.set("n", "j", function()
  if not vim.tbl_contains({ "neo-tree", "Outline", "qf" }, vim.bo.filetype) then
    return vim.fn.line(".") == vim.fn.line("$") and "<C-e>" or "j"
  end
  return "j"
end, { expr = true })

---- search google
-- local searching_google_in_normal =
-- [[:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.expand("<cword>")})<CR>]]
-- local searching_google_in_visual =
-- [[<ESCd>gv"gy<ESC>:lua vim.fn.system({'open', 'https://google.com/search?q=' .. vim.fn.getreg('g')})<CR>]]
-- vim.keymap.set("n", "<leader>g", searching_google_in_normal, { silent = true })
-- vim.keymap.set("v", "<leader>g", searching_google_in_visual, { silent = true })

-- todo-comments
local todo = require('todo-comments')
vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "TODO: Next Comment" })
vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "TODO: Previous Comment" })

-- telescope
local telescope = require('telescope.builtin') -- Create a function with your preferred options

vim.keymap.set('n', '<leader>fe', telescope.diagnostics, { desc = "Telescope: Diagnostics", silent = true })
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Telescope: Find Files", silent = true })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = "Telescope: Live Grep", silent = true })
-- vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = "Telescope: Buffers", silent = true })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = "Telescope: Help Tags", silent = true })
vim.keymap.set('n', '<leader>fm', telescope.man_pages, { desc = "Telescope: Man Pages", silent = true })
vim.keymap.set('n', '<leader>fs', "<cmd>Telescope luasnip<CR>", { desc = "Telescope: Snippets", silent = true })
vim.keymap.set('n', '<leader>fl', function() telescope.colorscheme({ enable_preview = true }) end,
  { desc = "Telescope: Colorscheme", silent = true })
vim.keymap.set('n', '<leader>fc', telescope.git_bcommits,
  { desc = "Telescope: Git Commits", silent = true })
vim.keymap.set('n', '<leader>fp', function() require('telescope').extensions.conda.conda() end,
  { desc = "Telescope: Conda", silent = true })
vim.keymap.set('n', '<leader>fr', telescope.lsp_references,
  { desc = "Telescope: LSP References", silent = true })
vim.keymap.set('n', '<leader>fo', telescope.lsp_outgoing_calls,
  { desc = "Telescope: LSP Outgoing Calls", silent = true })
vim.keymap.set('n', '<leader>fi', telescope.lsp_incoming_calls,
  { desc = "Telescope: LSP Incoming Calls", silent = true })
vim.keymap.set('n', '<leader>fu', "<cmd>Telescope undo<cr>",
  { desc = "Telescope: Undo", silent = true })
vim.keymap.set('n', '<leader>fd', telescope.lsp_document_symbols,
  { desc = "Telescope: Document Symbols", silent = true })
vim.keymap.set('n', '<leader>fb', telescope.current_buffer_fuzzy_find,
  { desc = "Telescope: Buffer Fuzzy Find", silent = true })
vim.keymap.set('n', '<leader>fn', '<cmd>SessionSearch<CR>',
  { desc = "Telescope: Sessions", silent = true })

local telescope_emoji = require('telescope').load_extension 'emoji'
vim.keymap.set('n', '<leader>fe', telescope_emoji.emoji, { desc = 'Telescope: Emoji' })

-- leetcode
vim.keymap.set('n', '<leader>lr', '<cmd>Leet run<CR>', { desc = "Leetcode: Run", silent = true })
vim.keymap.set('n', '<leader>ls', '<cmd>Leet submit<CR>', { desc = "Leetcode: Submit", silent = true })
vim.keymap.set('n', '<leader>lm', '<cmd>Leet<CR>', { desc = "Leetcode: Menu", silent = true })
vim.keymap.set('n', '<leader>lc', '<cmd>Leet console<CR>', { desc = "Leetcode: Console", silent = true })

---- mini.files
-- local MiniFiles = require('mini.files')
-- local minifiles_toggle = function(...)
--   if not MiniFiles.close() then MiniFiles.open(...) end
-- end
--
-- vim.keymap.set('n', '<leader>n', minifiles_toggle, { desc = "Mini.Files: Toggle", silent = true })
--
-- local map_split = function(buf_id, lhs, direction)
--   local rhs = function()
--     -- Make new window and set it as target
--     local cur_target = MiniFiles.get_explorer_state().target_window
--     local new_target = vim.api.nvim_win_call(cur_target, function()
--       vim.cmd(direction .. ' split')
--       return vim.api.nvim_get_current_win()
--     end)
--
--     MiniFiles.set_target_window(new_target)
--   end
--
--   -- Adding `desc` will result into `show_help` entries
--   local desc = 'Split ' .. direction
--   vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
-- end
--
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'MiniFilesBufferCreate',
--   callback = function(args)
--     local buf_id = args.data.buf_id
--     -- Tweak keys to your liking
--     map_split(buf_id, '<C-s>', 'belowright horizontal')
--     map_split(buf_id, '<C-v>', 'belowright vertical')
--   end,
-- })

-- neo-tree
vim.keymap.set('n', '<leader>n', ':Neotree action=show position=right reveal=true toggle<CR>',
  { desc = "Neotree: Toggle", silent = true }) -- action=focus/show
---- using neotree in place of outline
-- vim.keymap.set('n', '<leader>o', ':Neotree source=document_symbols position=right action=show reveal=true toggle<CR>',
--   { desc = "Neotree: Toggle Document Symbols", silent = true })

-- outline
vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { silent = true, desc = "Outline: Toggle" })

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
    map('n', 'gn', vim.lsp.buf.rename, 'LSP: Rename')
    map({ 'n', 'x' }, 'gf', function()
      vim.notify("Formatting..")
      vim.lsp.buf.format({ async = true })
    end, 'LSP: Format')
    map('n', 'gc', vim.lsp.buf.code_action, 'LSP: Code Action')
    map('n', 'ge', vim.diagnostic.open_float, 'Diagnostic: Open Float')
    map('n', 'gt', function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, 'Diagnostic: Toggle')
    map('n', 'gF', '<cmd>ToggleFormat<CR>', 'Conform: Toggle Format-on-save')
  end
})

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
    { key = "gn",    desc = "Rename" },
    { key = "gf",    desc = "Format" },
    { key = "gF",    desc = "Toggle Format-on-save" },
    { key = "gc",    desc = "Code Action" },
    { key = "ge",    desc = "Open Diagnostic" },
    { key = "gt",    desc = "Toggle Diagnostic" },
    { key = "[d",    desc = "Previous Diagnostic" },
    { key = "]d",    desc = "Next Diagnostic" },
  }

  local lines = { "LSP Keybindings:" }
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
  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, desc = "Keybind Help: Close", silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf, desc = "Keybind Help: Close", silent = true })
end

vim.keymap.set('n', '<leader>?', show_lsp_zero_keybindings,
  { desc = "Keybind Help: Open", silent = true })

-- grug-far
vim.keymap.set('n', '<leader>g', '<cmd>GrugFar<CR>', { desc = "GrugFar", silent = true })

-- codewindow
local codewindow = require('codewindow')
vim.keymap.set('n', '<leader>mf', codewindow.toggle_focus, { desc = "Codewindow: Focus", silent = true })
vim.keymap.set('n', '<leader>mm', codewindow.toggle_minimap,
  { desc = "Codewindow: Toggle", silent = true })

-- jupyter stuff; treesitter textobjects, molten, quarto
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    ---- insert python codeblock
    vim.keymap.set('n', '<Leader>jb', function()
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.api.nvim_put({ '', '```python', '', '```' }, 'l', false, true)
      vim.api.nvim_win_set_cursor(0, { pos[1] + 1, 0 }) -- Move to the middle empty line
      vim.cmd('startinsert')
    end, { desc = "Markdown: Insert Python code block" })

    ---- treesitter
    vim.keymap.set("n", "]]", "<cmd>TSTextobjectGotoNextStart @code_cell.inner | norm! zz<CR>",
      { desc = "TS: Next Code Block", silent = true, buffer = true })
    vim.keymap.set("n", "[[", "<cmd>TSTextobjectGotoPreviousStart @code_cell.inner | norm! zz<CR>",
      { desc = "TS: Prev Code Block", silent = true, buffer = true })
    vim.keymap.set({ "x", "o" }, "ib", "<cmd><C-u>TSTextobjectSelect @code_cell.inner<CR>",
      { desc = "TS: Select Inner Block", silent = true, buffer = true })
    vim.keymap.set({ "x", "o" }, "ab", "<cmd><C-u>TSTextobjectSelect @code_cell.outer<CR>",
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
    vim.keymap.set("n", "<leader>jR", '<cmd>MoltenRestart<CR>',
      { desc = "Molten: Restart Kernel", silent = true })
    vim.keymap.set("n", "<leader>jr", '<cmd>MoltenRestart!<CR>',
      { desc = "Molten: Restart Kernel and Clear All", silent = true })
    vim.keymap.set("n", "<leader>ji", '<cmd>MoltenInterrupt<CR>',
      { desc = "Molten: Interrupt", silent = true })

    -- enter/exit molten output
    -- also use q or esc to exit
    vim.keymap.set("n", "<leader>je", function()
      if vim.bo.filetype == "molten_output" then
        vim.cmd("MoltenHideOutput")
      else
        vim.cmd("noautocmd MoltenEnterOutput")
        vim.keymap.set("n", "q", "<cmd>MoltenHideOutput<CR>",
          { buffer = true, desc = "Molten: Exit Output", silent = true })
        vim.keymap.set("n", "<Esc>", "<cmd>MoltenHideOutput<CR>",
          { buffer = true, desc = "Molten: Exit Output", silent = true })
      end
    end, { desc = "Molten: Toggle Output", silent = true })

    -- markdown-preview
    vim.keymap.set("n", "<leader>jo", "<cmd>MarkdownPreviewToggle<CR>",
      { desc = "Markdown: Preview", silent = true })

    -- jupyter (cli)
    local function convert_and_open_notebook(use_pretty_style)
      local current_file = vim.fn.expand('%:p')
      if not current_file:match('%.ipynb$') then
        vim.notify('Jupyter: Current file is not a Jupyter notebook', vim.log.levels.ERROR)
        return
      end

      local open_cmd = vim.fn.has('mac') == 1 and 'open' or 'xdg-open'
      local html_file = vim.fn.expand('%:p:r') .. '.html'

      local convert_cmd
      if use_pretty_style then
        convert_cmd = string.format(
          'jt -t gruvboxl && jupyter nbconvert %s --to html --template lab', current_file)
      else
        convert_cmd = string.format('jt -r || jupyter nbconvert %s --to html --template lab',
          current_file)
      end
      local convert_result = vim.fn.system(convert_cmd)
      if vim.v.shell_error ~= 0 then
        vim.notify('Jupyter: Failed to convert notebook: ' .. convert_result,
          vim.log.levels.ERROR)
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
        vim.notify('Jupyter: Failed to open browser: ' .. open_result, vim.log.levels.ERROR)
        return
      end

      vim.notify('Jupyter: Notebook converted and opened in browser', vim.log.levels.INFO)
    end

    local function open_html_in_browser()
      convert_and_open_notebook(false)
    end

    local function open_pretty_html_in_browser()
      convert_and_open_notebook(true)
    end

    vim.keymap.set('n', '<leader>jh', open_html_in_browser,
      { desc = "Jupyter: Open in Browser", silent = true })
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
vim.keymap.set('v', '<leader>re',
  '"+y<ESC>:lua vim.fn.system("open \'raycast://ai-commands/explain-code-step-by-step-clipboard\'")<CR>',
  { desc = "Raycast: Explain Code", silent = true })

-- codecompanion
local codecompanion = require("codecompanion")
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>",
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

-- searchbox
vim.keymap.set('n', '<leader>r', ":SearchBoxReplace confirm=menu -- <C-r>=expand('<cword>')<CR><CR>",
  { desc = "Searchbox: Replace Current Word", silent = true })
vim.keymap.set('x', '<leader>r', ":SearchBoxReplace visual_mode=true -- <C-r>=expand('<cword>')<CR><CR>",
  { desc = "Searchbox: Replace", silent = true })


-- latex stuff
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.keymap.set("n", "<leader>vv", "<cmd>VimtexView<CR>",
      { desc = "Vimtex: View / Forward Search", silent = true })
    vim.keymap.set("n", "<leader>vt", "<cmd>VimtexTocToggle<CR>",
      { desc = "Vimtex: Toggle TOC", silent = true })
    vim.keymap.set("n", "<leader>vc", "<cmd>VimtexCompile<CR>",
      { desc = "Vimtex: Compile Continuously", silent = true })
    vim.keymap.set("n", "<leader>vs", "<cmd>VimtexCompile<CR>",
      { desc = "Vimtex: Stop Compilation", silent = true })
    vim.keymap.set("n", "<leader>vw", "<cmd>VimtexCountWords<CR>",
      { desc = "Vimtex: Count Words", silent = true })
  end
})

---- set filetype for ghosttext
vim.keymap.set('n', '<leader>/', ":set filetype=python<CR>",
  { desc = "Filetype: Python", silent = true })

---- pastify
vim.keymap.set('v', '<leader>p', '<cmd>PastifyAfter<CR>', { desc = "Pastify", silent = true })
vim.keymap.set('n', '<leader>p', '<cmd>PastifyAfter<CR>', { desc = "Pastify", silent = true })

---- python-repl
local python_repl = require('nvim-python-repl')
vim.keymap.set("n", '<leader>tt', function() python_repl.send_statement_definition() end,
  { desc = "Python-REPL: Send semantic unit" })

vim.keymap.set("v", '<leader>tt', function() python_repl.send_visual_to_repl() end,
  { desc = "Python-REPL: Send visual selection" })

vim.keymap.set("n", '<leader>tb', function() python_repl.send_buffer_to_repl() end,
  { desc = "Python-REPL: Send buffer" })

vim.keymap.set("n", '<leader>te', function() python_repl.toggle_execute() end,
  { desc = "Python-REPL: Toggle auto-execute" })

vim.keymap.set("n", '<leader>tv', function() python_repl.toggle_vertical() end,
  { desc = "Python-REPL: Toggle split direction" })

vim.keymap.set("n", '<leader>to', function() python_repl.open_repl() end, { desc = "Python-REPL: Open window split" })

-- Wrap
vim.keymap.set('n', '<leader>wh', function() vim.cmd([[%s/.\{90,99} /&↵\r/g | 1]]) end,
  { desc = "Vim: Hard Wrap", silent = true })

vim.keymap.set('v', '<leader>wh', function()
  vim.cmd.normal('gv')
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local cmd = string.format([[%d,%d s/.\{90,99} /&↵\r/g]], start_line, end_line)
  vim.cmd(cmd)
  vim.cmd.normal('<Esc>')
end, { desc = "Vim: Hard Wrap Selection", silent = true })

vim.keymap.set('n', '<leader>wu', function() vim.cmd([[%s/↵\n// | 1]]) end,
  { desc = "Vim: Undo Hard Wrap", silent = true })

vim.keymap.set('v', '<leader>wu', function()
  vim.cmd.normal('gv')
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  vim.cmd(string.format([[%d,%ds/↵\n//g]], start_line, end_line))
  vim.cmd.normal('<Esc>')
end, { desc = "Vim: Undo Hard Wrap Selection", silent = true })

vim.keymap.set('n', '<leader>ws', function()
  vim.o.wrap = not vim.o.wrap
end, { desc = 'Toggle Soft Wrap', silent = true })

-- Luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { desc = "Luasnip: Next choice", silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end, { desc = "Luasnip: Previous choice", silent = true })

-- Arduino
vim.keymap.set('n', '<leader>aa', '<cmd>ArduinoAttach<CR>', { desc = 'Arduino: Attach' })
vim.keymap.set('n', '<leader>av', '<cmd>ArduinoVerify<CR>', { desc = 'Arduino: Verify' })
vim.keymap.set('n', '<leader>au', '<cmd>ArduinoUpload<CR>', { desc = 'Arduino: Upload' })
vim.keymap.set('n', '<leader>aU', '<cmd>ArduinoUploadAndSerial<CR>', { desc = 'Arduino: Upload and Serial' })
vim.keymap.set('n', '<leader>as', '<cmd>ArduinoSerial<CR>', { desc = 'Arduino: Serial' })
vim.keymap.set('n', '<leader>ab', '<cmd>ArduinoChooseBoard<CR>', { desc = 'Arduino: Choose Board' })
vim.keymap.set('n', '<leader>ap', '<cmd>ArduinoChooseProgrammer<CR>', { desc = 'Arduino: Choose Programmer' })
vim.keymap.set('n', '<leader>ai', '<cmd>ArduinoInfo<CR>', { desc = 'Arduino: Info' })

-- Function to update sketch.yaml with current board info
-- vim.api.nvim_create_user_command('ArduinoUpdateFQBN', function()
--   local handle = io.popen('arduino-cli board list')
--   if handle then
--     local result = handle:read("*a")
--     handle:close()
--
--     -- Match just the port path at the start of the line
--     for line in result:gmatch("[^\r\n]+") do
--       local port = line:match("^(/dev/[%S]+)")
--       local fqbn = line:match("esp32:esp32:esp32_%S+")
--       if port and fqbn then
--         local sketch_yaml = io.open('sketch.yaml', 'w')
--         if sketch_yaml then
--           sketch_yaml:write(string.format("default_fqbn: %s\n", fqbn))
--           sketch_yaml:write(string.format("default_port: %s\n", port))
--           sketch_yaml:close()
--           print("Updated sketch.yaml with FQBN: " .. fqbn .. " and port: " .. port)
--           return
--         end
--       end
--     end
--   end
--   print("Failed to update sketch.yaml")
-- end, {})

-- Bind it to a key
vim.keymap.set('n', '<leader>af', '<cmd>ArduinoUpdateFQBN<CR>', { silent = true })
