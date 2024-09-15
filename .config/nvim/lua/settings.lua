-- vim.opt is getting deprecated, eventually. It exists for conveniently interacting with
-- list- and map-style option from Lua: It allows accessing them as Lua tables and offers
-- object-oriented method for adding and removing entries.

---- General
vim.o.number = true             -- show line number on left column (gutter)
vim.o.mouse = 'a'               -- Let's you use mouse to select text
vim.o.clipboard = "unnamedplus" -- Use system clipboard for copy/pasting

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
