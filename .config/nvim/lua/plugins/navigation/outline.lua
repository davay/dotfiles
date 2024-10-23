return {
  "hedyhli/outline.nvim",
  config = function()
    require("outline").setup({
      outline_window = {
        auto_close = true,
      },
      preview_window = {
        auto_preview = true,
      },
      providers = {
        lsp = {
          blacklist_clients = { 'marksman' }, -- for jupyter
        }
      }
    })
  end,
}
