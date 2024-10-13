return {
  "quarto-dev/quarto-nvim",
  dependencies = {
    "jmbuhr/otter.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "quarto", "markdown" },
  opts = {
    lspFeatures = {
      enabled = true,
      chunks = "all",
      languages = { "r", "python" },
      diagnostics = {
        enabled = true,
        triggers = { "BufWritePost" },
      },
      completion = {
        enabled = true,
      },
    },
    codeRunner = {
      enabled = true,
      default_method = "molten", -- 'molten' or 'slime'
      ft_runners = {},           -- filetype to runner, ie. `{ python = "molten" }`.
      -- Takes precedence over `default_method`
      never_run = { "yaml" },    -- filetypes which are never sent to a code runner
    },

  }
}
