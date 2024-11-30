return {
  'dundalek/lazy-lsp.nvim',
  dependencies = {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    'neovim/nvim-lspconfig',
    'RRethy/vim-illuminate',
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      -- For vim-illuminate
      vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'CursorLine' })
      vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'CursorLine' })
      vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'CursorLine' })
    end)

    require('lazy-lsp').setup {
      excluded_servers = {
        'bufls',    -- 2024-11-10: deprecated, use buf_ls instead, lazy-lsp needs to fix
        'ruff_lsp', -- 2024-11-10: deprecated, use ruff instead, lazy-lsp needs to fix
        'ltex',     -- because of ltex-ls linkage error, but latex should be handled by vimtex anyway
      },
      preferred_servers = {
        python = { 'ruff_lsp', 'pyright' },
      },
      configs = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
            },
          },
        },
      }
    }
  end
}
