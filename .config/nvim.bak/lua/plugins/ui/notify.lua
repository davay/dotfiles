return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup {
      -- level = "ERROR",
      render = "compact",
      stages = "static",
      -- stages = "fade_in_slide_out",
      timeout = 1000,
    }
    vim.notify = require("notify")
  end
}
