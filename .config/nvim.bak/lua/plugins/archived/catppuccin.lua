return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
    })

    -- Set colorscheme after setup
    vim.cmd.colorscheme "catppuccin"
  end
}
