return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "debugloop/telescope-undo.nvim",
  },
  opts = {
    defaults = require('telescope.themes').get_ivy(),
  },
  config = function()
    require('telescope').load_extension('undo')
  end
}
