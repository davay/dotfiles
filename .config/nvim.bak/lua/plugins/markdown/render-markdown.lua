return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons' },
    ft = "markdown",
    opts = {
      code = {
        enabled = false,
      },
      bullet = {
        highlight = '@markup.list.markdown'
      },
      html = {
        comment = {
          conceal = false,
        }
      }
    }
  }
}
