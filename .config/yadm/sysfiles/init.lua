-- return {
--   colorscheme = "catppuccin-frappe",
-- 
--   plugins = {
--     {
--       "catppuccin/nvim",
--       name = "catppuccin",
--       config = function()
--         require("catppuccin").setup {}
--       end,
--     },
--   },
-- }
return {
  colorscheme = "gruvbox",
 
  plugins = {
    {
      "ellisonleao/gruvbox.nvim",
      name = "gruvbox",
      config = function()
        require("gruvbox").setup({})
      end,
    },
    {
      "kylechui/nvim-surround", 
      tag = "main", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({})
        end,
    }
  },
}
