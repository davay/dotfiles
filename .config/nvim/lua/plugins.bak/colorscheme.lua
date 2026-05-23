-- this one is a bit different to the other plugin lua files
-- usually the name of the file matches the plugin exactly
-- but this one should just have whatever colorscheme im using currently
return {
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
