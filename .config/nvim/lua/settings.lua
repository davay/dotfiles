-- vim.opt is getting deprecated, eventually. It exists for conveniently interacting with
-- list- and map-style option from Lua: It allows accessing them as Lua tables and offers
-- object-oriented method for adding and removing entries.

---- General
vim.o.number = true             -- show line number on left column (gutter)
vim.o.mouse = 'a'               -- Let's you use mouse to select text
vim.o.clipboard = "unnamedplus" -- Use system clipboard for copy/pasting
vim.o.splitright = true         -- vsplit splits to the right, mostly for codecompanion

---- Tab and Spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.tabstop = 2      -- A TAB character looks like 4 spaces
vim.o.softtabstop = 2  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2   -- Number of spaces inserted when indenting

---- Appearance
vim.o.background = "dark" -- or "light" for light mode
vim.cmd.colorscheme('gruvbox')
-- Show the "best" version of the colorscheme. Each colorscheme can have two versions:
-- 1. one that works for terminals which only support 256 colors
-- 2. another that specifies colors in hexadecimal code (24-bit).
vim.o.termguicolors = true
vim.o.signcolumn = "yes:1" -- prevent sidebar from shifting

---- Search
vim.o.ignorecase = true -- ignore uppercase letters (good with smartcase)
vim.o.smartcase = true  -- ignore uppercase letters unless the search term has an uppercase
vim.o.hlsearch = false  -- disable highlighting of previous search result

---- Editor
vim.o.wrap = true
vim.o.breakindent = true -- wrapped lines are indented to match indentation of original
vim.o.linebreak = true   -- ensure words arent broken awkwardly
if vim.fn.has('linebreak') == 1 then
  vim.o.showbreak = '↳ '
end

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
