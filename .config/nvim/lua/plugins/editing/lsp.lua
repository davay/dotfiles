-- arduino issue: https://github.com/arduino/arduino-language-server/issues/187

return {
  'dundalek/lazy-lsp.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    -- Prefer treesitter coloring over LSP
    vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

    require('lazy-lsp').setup {
      prefer_local = true, -- prefer locally installed server, mostly for arduino-language-server
      excluded_servers = {
        'ltex',            -- because of ltex-ls linkage error, but latex should be handled by vimtex anyway
        'tailwindcss',     -- i keep getting errors, i dont use this anyway
      },
      preferred_servers = {
        python = { 'basedpyright' },
        cpp = { 'clangd' }
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
