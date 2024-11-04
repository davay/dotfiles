return {
  {
    'stevearc/conform.nvim', -- really I just installed this for jupyter formatting
    config = function()
      require('conform').setup({
        default_format_opts = {
          timeout_ms = 1000,
          async = false,           -- not recommended to change
          quiet = false,           -- not recommended to change
          lsp_format = 'fallback', -- not recommended to change
        },

        format_on_save = function(bufnr)
          if vim.b[bufnr].disable_autoformat then
            return
          end
          return {} -- enables format_on_save with defaults
        end,

        vim.api.nvim_create_user_command("ToggleFormat", function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
          vim.notify("Conform: Format-on-save is " .. (vim.b[bufnr].disable_autoformat and "disabled" or "enabled"))
        end, {
          desc = "Toggle format-on-save",
        }),

        formatters_by_ft = {
          markdown = { 'injected' },
          python = {
            'ruff_format',
            'ruff_organize_imports',
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
      if not package.loaded['jupytext'] then
        vim.api.nvim_create_autocmd({ 'BufWriteCmd', 'FileWriteCmd' },
          {
            pattern = '*.ipynb',
            callback = function()
              require('conform').format({ async = false })
            end,
          })
      else
        vim.notify('Jupytext already loaded - autocmd ordering may not be reliable')
      end
    end
  },
  {
    'dundalek/lazy-lsp.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'windwp/nvim-autopairs',
      'saadparwaiz1/cmp_luasnip',
      'RRethy/vim-illuminate',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
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
          'ltex', -- because of ltex-ls linkage error
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

      local cmp = require('cmp')
      local cmp_format = require('lsp-zero').cmp_format({ details = false })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local luasnip = require('luasnip')

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
        experimental = {
          ghost_text = {
            hl_group = "Comment",
          },
        },
        mapping = cmp.mapping.preset.insert {
          -- Manually show completion menu
          ['<C-Space>'] = cmp.mapping(function(fallback)
            if has_words_before() then
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end, { 'i', 's' }),

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
            else
              fallback()
            end
          end, { 'i', 's' }),


          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- Only use enter to complete explicitly selected items,
          -- otherwise it closes the autocomplete menu, so that it
          -- doesn't create a newline and i can still jump to next node
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if cmp.get_active_entry() then
                cmp.confirm({ select = false })
              else
                cmp.close()
              end
            else
              fallback()
            end
          end, { 'i', 's' }),
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
    end
  } }
