return { -- treesitter compatible, unlike the other one
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_enable_italic = true
    -- Available values: 'hard', 'medium'(default), 'soft'
    vim.g.gruvbox_material_background = 'medium'
    -- Available values: 'material', 'mix' (mean), 'original'
    vim.g.gruvbox_material_foreground = 'original'
  end
}
