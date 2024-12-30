return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  filetypes = { "markdown", "latex" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("markview").setup({
    })
  end
}
