return {
  "gorbit99/codewindow.nvim",
  config = function()
    local codewindow = require("codewindow")
    codewindow.setup({
      -- max_minimap_height = 30,
      minimap_width = 6,
      auto_enable = false,
      screen_bounds = "background",
    })
  end,
}
