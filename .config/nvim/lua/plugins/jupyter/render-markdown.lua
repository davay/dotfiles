return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons' },
  opts = {
    heading = {
      border = true,
      -- Always use virtual lines for heading borders instead of attempting to use empty lines
      border_virtual = true,
    },
    code = {
      enabled = true,
      style = 'normal', -- normal/language/full
      above = '─',
      below = '─',
      highlight = '', -- HACK: very silly, but I just want the border lines without the actual highlight group since it interferes with vim-illuminate
    },
    bullet = {
      highlight = '@markup.list.markdown'
    }
  },
}
