return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      swift = { "swiftlint" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = { "--config", vim.fn.expand("~/.markdownlint.yaml"), "--" },
      },
    },
  },
}
