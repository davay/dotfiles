return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  cond = function()
    local filename = vim.fn.expand("%:t") -- Get current buffer's filename
    return filename == "leetcode.nvim"
  end,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    lang = "python3",
    storage = {
      home = "/Users/davay/Repos/Personal/leetcode",
    },
    injector = {
      ["python3"] = {
        before = {
          "# type: ignore",
          "# flake8: noqa",
        },
      },
    },
  },
}
