return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup {
      render = "compact",
      stages = "fade",
      timeout = 300,
    }
    vim.notify = require("notify")
  end
}
