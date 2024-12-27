-- arduino issue: https://github.com/arduino/arduino-language-server/issues/187

return {
  'dundalek/lazy-lsp.nvim',
  dependencies = {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    'neovim/nvim-lspconfig',
    'RRethy/vim-illuminate',
  },
  config = function()
    require 'lspconfig'.arduino_language_server.setup {
      on_new_config = function(config, root_dir)
        local file = io.open(root_dir .. '/sketch.yaml', "r")
        if file == nil then
          return
        end

        local fqbn = "arduino:avr:uno"
        local lines = file:lines()
        for line in lines do
          if string.find(line, "fqbn") then
            fqbn = string.gsub(line, "%s+fqbn:%s", "")
          end
        end

        file:close()

        config.cmd = {
          "arduino-language-server",
          "-fqbn", fqbn,
        }
      end,
      cmd = {
        "arduino-language-server",
        "-fqbn", "arduino:avr:uno",
      }
    }

    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      -- For vim-illuminate
      vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'CursorLine' })
      vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'CursorLine' })
      vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'CursorLine' })
    end)

    -- For HTML autocompletion
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true

    require('lazy-lsp').setup {
      prefer_local = true, -- prefer locally installed server, mostly for arduino-language-server
      excluded_servers = {
        'bufls',           -- 2024-11-10: deprecated, use buf_ls instead, lazy-lsp needs to fix
        'ruff_lsp',        -- 2024-11-10: deprecated, use ruff instead, lazy-lsp needs to fix
        'ltex',            -- because of ltex-ls linkage error, but latex should be handled by vimtex anyway
      },
      preferred_servers = {
        python = { 'ruff_lsp', 'pyright' },
        cpp = { 'clangd' }
      },
      configs = {
        -- html = {
        --   capabilities = capabilities
        -- },
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
