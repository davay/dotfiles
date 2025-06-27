return {
  "geg2102/nvim-python-repl",
  dependencies = "nvim-treesitter",
  ft = { "python", "lua", "scala" },
  config = function()
    require("nvim-python-repl").setup({
      execute_on_send = true,
      vsplit = false,
    })
  end
}
