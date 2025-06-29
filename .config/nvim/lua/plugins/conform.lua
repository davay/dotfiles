return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      swift = { "swiftformat" },
      markdown = { "injected" },
      python = { "ruff_format", "ruff_organize_imports" },
    },
  },
}