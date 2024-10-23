return {
  {
    'stevearc/conform.nvim', -- really I just installed this for jupyter formatting
    config = function()
      require("conform").setup({
        default_format_opts = {
          timeout_ms = 1000,
          async = false,           -- not recommended to change
          quiet = false,           -- not recommended to change
          lsp_format = "fallback", -- not recommended to change
        },
        format_on_save = {},       -- enables format_on_save with default options
        formatters_by_ft = {
          markdown = { 'injected' },
          python = {
            "ruff_fix",
            "ruff_format",
            "ruff_organize_imports",
          },
        },
        formatters = {
          injected = {
            ignore_errors = true,
          }
        }
      })

      -- Special case since jupytext creates autocmd for bufwritecmd and filewritecmd, bufwritepre doesn't get triggered.
      -- autocmd is ran in the order they're loaded in. Conform should always load first since it's set as a dependency, but check anyway, just in case.
      -- since I don't return anything before end, the next autocmd will be ran too
      if not package.loaded["jupytext"] then
        vim.api.nvim_create_autocmd({ "BufWriteCmd", "FileWriteCmd" },
          {
            pattern = "*.ipynb",
            callback = function()
              require("conform").format({ async = false })
            end,
          })
      else
        vim.notify("Jupytext already loaded - autocmd ordering may not be reliable")
      end
    end
  },
  {
    "dundalek/lazy-lsp.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "windwp/nvim-autopairs",
      "saadparwaiz1/cmp_luasnip",
      "RRethy/vim-illuminate",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(client, bufnr)
        -- For vim-illuminate
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine" })

        -- See :h lsp-zero-keybindings
        -- lsp_zero.default_keymaps({
        --   buffer = bufnr,
        --   preserve_mappings = false
        -- })
      end)

      require("lazy-lsp").setup {
        excluded_servers = {
          "ltex", -- because of ltex-ls linkage error
        },
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
      local luasnip = require('luasnip')

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        formatting = cmp_format,
        mapping = cmp.mapping.preset.insert {
          -- Manually show completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Smart Tab completion, only autocomplete when there's one option,
          -- Also jump to next/prev node in snippet
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Only use enter to complete explicitly selected items
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        },
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

      -- old format on save, without conform
      -- local excluded_filetypes = {
      --   "json",
      --   "markdown",
      -- }
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = { "*" },
      --   callback = function()
      --     if not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
      --       vim.lsp.buf.format({
      --         async = false -- wait until formatting to complete before saving
      --       })
      --     end
      --   end,
      -- })
    end
  } }
