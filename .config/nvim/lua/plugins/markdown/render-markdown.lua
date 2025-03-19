return {
  { 'jbyuki/nabla.nvim' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons' },
    ft = "markdown",
    opts = {
      latex = { enabled = false },
      win_options = { conceallevel = { rendered = 2 } },
      on = {
        attach = function()
          require('nabla').enable_virt({ autogen = true })
        end,
      },
      heading = {
        border = true,
        
        -- Always use virtual lines for heading borders instead of attempting to use empty lines
        -- border_virtual = true,
      },
      code = {
        enabled = true,
        style = 'normal', -- normal/language/full
        -- above = '─',
        -- below = '─',
        -- highlight = '', -- HACK: very silly, but I just want the border lines without the actual highlight group since it interferes with vim-illuminate
        sign = false,
      },
      bullet = {
        highlight = '@markup.list.markdown'
      }
    },
  }
}
