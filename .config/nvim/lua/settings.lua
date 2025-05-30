-- vim.opt is getting deprecated, eventually. It exists for conveniently interacting with
-- list- and map-style option from Lua: It allows accessing them as Lua tables and offers
-- object-oriented method for adding and removing entries.

---- General
vim.o.number = true             -- show line number on left column (gutter)
vim.o.mouse = 'a'               -- Let's you use mouse to select text
vim.o.clipboard = "unnamedplus" -- Use system clipboard for copy/pasting
vim.g.clipboard = {             -- this lets us copy to clipboard while ssh
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
vim.o.splitright = true -- vsplit splits to the right, mostly for codecompanion

---- Tab and Spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.tabstop = 2      -- A TAB character looks like 4 spaces
vim.o.softtabstop = 2  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2   -- Number of spaces inserted when indenting

---- Appearance
vim.o.background = "dark" -- or "light" for light mode
-- also change in lualine.lua and plugin_manager.lua
vim.cmd.colorscheme('gruvbox-material')

vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { italic = false }) -- in gruvbox everything is italicized in code block, remove it
vim.o.termguicolors = true
vim.o.signcolumn = "yes:1"                                               -- prevent sidebar from shifting

---- Search
vim.o.ignorecase = true -- ignore uppercase letters (good with smartcase)
vim.o.smartcase = true  -- ignore uppercase letters unless the search term has an uppercase
vim.o.hlsearch = false  -- disable highlighting of previous search result

---- Editor
--- Soft Wrap
vim.o.wrap = true
vim.o.breakindent = true -- wrapped lines are indented to match indentation of original
vim.o.linebreak = true   -- ensure words arent broken awkwardly
if vim.fn.has('linebreak') == 1 then
  vim.o.showbreak = '↳ '
end

--- mostly for jupyter so image.nvim works without wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.o.wrap = false
  end,
})

---- Disable notification "No information available" from lsp-zero when pressing K
-- https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if not (result and result.contents) then
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end
  return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end

---- Custom Functions
-- Function to list all highlight groups
local function list_highlight_groups()
  -- Get all highlight groups
  local highlights = vim.api.nvim_get_hl(0, {})

  -- Create a sorted list of highlight group names
  local highlight_names = {}
  for name, _ in pairs(highlights) do
    table.insert(highlight_names, name)
  end
  table.sort(highlight_names)

  -- Create a new buffer for displaying the highlights
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Format and display each highlight group
  local lines = {}
  for _, name in ipairs(highlight_names) do
    local hl = highlights[name]
    local attrs = {}

    if hl.fg then table.insert(attrs, string.format("fg=#%06x", hl.fg)) end
    if hl.bg then table.insert(attrs, string.format("bg=#%06x", hl.bg)) end
    if hl.bold then table.insert(attrs, "bold") end
    if hl.italic then table.insert(attrs, "italic") end
    if hl.underline then table.insert(attrs, "underline") end

    table.insert(lines, string.format("%s: %s", name, table.concat(attrs, ", ")))
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Open the buffer in a new window
  vim.cmd.vsplit()
  vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf)
end

-- Command to call the function
vim.api.nvim_create_user_command('ListHighlights', list_highlight_groups, {})

-- Big file mode
local function big_file_mode()
  vim.notify("Big file detected")

  if vim.fn.exists(':TSBufDisable') == 1 then
    vim.cmd('TSBufDisable autotag')
    vim.cmd('TSBufDisable highlight')
  end

  vim.opt.foldmethod = 'manual'
  vim.cmd('syntax clear')
  vim.cmd('syntax off')
  vim.cmd('filetype off')
  vim.opt.undofile = false
  -- vim.opt.swapfile = false -- This is ok, very fast on my mac still
  vim.opt.loadplugins = false
  vim.opt.wrap = false
end

local big_file_group = vim.api.nvim_create_augroup('BigFileDisable', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
  group = big_file_group,
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand('%'))
    if file_size > 32 * 1024 * 1024 then -- 32 MB
      big_file_mode()
    end
  end,
})

-- Disable unused providers to speed up start time
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
