return {
  'jmbuhr/otter.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = "markdown",
  config = function()
    local otter = require('otter')
    otter.setup({
      lsp = {
        diagnostic_update_events = { "InsertLeave", "TextChanged" }
      },
      buffers = {
        set_filetype = true
      }
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "markdown" },
      callback = function()
        otter.activate()
      end,
    })
  end
}
