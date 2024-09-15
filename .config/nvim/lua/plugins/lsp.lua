return {
  "dundalek/lazy-lsp.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "windwp/nvim-autopairs"
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings to learn the available actions
      lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false
      })
    end)

    require("lazy-lsp").setup {
      excluded_servers = {},
      preferred_servers = {
        python = { "ruff_lsp", "pyright" },
      },
      configs = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
            },
          },
        },
      }
    }

    local cmp = require('cmp')
    local cmp_format = require('lsp-zero').cmp_format({ details = false })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
      },
      formatting = cmp_format,
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      },
    })
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    -- format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*" },
      callback = function()
        if vim.bo.filetype ~= "json" then
          vim.lsp.buf.format({
            async = false -- wait until formatting to complete before saving
          })
        end
      end,
    })
  end
}
