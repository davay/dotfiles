return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    "xiyaowong/telescope-emoji.nvim",
    "IllustratedMan-code/telescope-conda.nvim"
  },
  opts = {
    extensions = {
      conda = {
        anaconda_path = "/opt/homebrew/anaconda3/"
      }
    },
    defaults = require('telescope.themes').get_ivy()
  },
  init = function()
    local telescope = require('telescope')
    telescope.load_extension('undo')
    telescope.load_extension('emoji')
    telescope.load_extension('conda')
  end
}
