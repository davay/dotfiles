return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "debugloop/telescope-undo.nvim",
    "xiyaowong/telescope-emoji.nvim",
  },
  opts = {
    defaults = require('telescope.themes').get_ivy(),
  },
  config = function()
    local telescope = require('telescope')
    telescope.load_extension('undo')
    telescope.load_extension('emoji')
  end
}
