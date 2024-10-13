return {
  'gorbit99/codewindow.nvim',
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup({
      max_minimap_height = 30,
      minimap_width = 8,
      auto_enable = true,
    })
  end,
}
