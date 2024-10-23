return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup {
      render = "compact",
      stages = "fade",
      timeout = 1000,
    }
    vim.notify = require("notify")
  end
}
