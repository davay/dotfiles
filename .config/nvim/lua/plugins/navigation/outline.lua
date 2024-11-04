return {
  "hedyhli/outline.nvim",
  event = "LspAttach", -- hover_symbol is much more reliable if we wait
  config = function()
    local function get_blacklist_clients()
      local ext = vim.fn.expand('%:e')
      local ft = vim.bo.filetype
      if ft == 'python' then
        return { 'ruff_lsp' }                                  -- only pyright works
      elseif ext == 'ipynb' then
        return { 'marksman', 'yamlls', 'ruff_lsp', 'pyright' } -- for jupyter, prefer otter
      else
        return { 'tailwindcss', 'otter-ls[1]' }                -- for normal markdown files, prefer marksman
      end
    end

    require("outline").setup({
      outline_items = {
        show_symbol_details = true, -- BUG: Only works in some languages like Lua, doesn't seem to work in Python
        show_symbol_lineno = true,
        auto_update_events = {
          follow = { 'CursorMoved' },
          items = {
            'InsertLeave',
            'WinEnter',
            'BufEnter',
            'BufWinEnter',
            'TabEnter',
            'BufWritePost',
            'LspAttach' -- my addition; convenient when switching files with outline window open
          },
        },
      },
      outline_window = {
        auto_close = false,
        auto_jump = false,
      },
      symbol_folding = {
        autofold_depth = 2
      },
      preview_window = {
        auto_preview = true,
        open_hover_on_preview = false, -- BUG: Doesn't seem to work? I think the hover is behind the preview
        live = true,
      },
      providers = {
        priority = { 'lsp' },
        lsp = {
          blacklist_clients = get_blacklist_clients()
        },
      },
      keymaps = {
        -- Set to '{}' to disable
        show_help = '?',
        close = 'q',
        goto_location = '<Cr>',
        goto_and_close = '{}',
        restore_location = '{}',
        hover_symbol = '<C-k>', -- match lsp
        toggle_preview = { 'p', 'P' },
        rename_symbol = '<F2>', -- match LSP
        code_actions = '<F4>',  -- match LSP
        fold = 'h',
        unfold = 'l',
        fold_toggle = '{}',
        fold_toggle_all = '{}',
        fold_all = 'H',
        unfold_all = 'L',
        fold_reset = '<bs>', -- bs is not bound for ft==outline/neo-tree
        down_and_jump = '{}',
        up_and_jump = '{}',
      },
    })
  end,
}
