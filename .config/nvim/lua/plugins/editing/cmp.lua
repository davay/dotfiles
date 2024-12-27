return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    'windwp/nvim-autopairs',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
  },
  config = function()
    local cmp = require('cmp')
    local cmp_format = require('lsp-zero').cmp_format({ details = false })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local luasnip = require('luasnip')
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and
          vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    cmp.setup({
      -- NOTE: right now always enabling so i can add slide metadata to md regions
      -- enabled = function()
      --   -- disable completion in comments
      --   local context = require 'cmp.config.context'
      --   -- keep command mode completion enabled when cursor is in a comment
      --   if vim.api.nvim_get_mode().mode == 'c' then
      --     return true
      --   else
      --     return not context.in_treesitter_capture("comment")
      --         and not context.in_syntax_group("Comment")
      --   end
      -- end,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      sources = {
        { name = 'luasnip',  priority = 1000 },
        { name = 'path',     priority = 900 },
        { name = 'buffer',   priority = 800 },
        { name = 'nvim_lsp', priority = 700 },
        { name = 'emoji',    priority = 600 },
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
}
