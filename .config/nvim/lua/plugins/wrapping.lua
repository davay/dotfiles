return {
  "andrewferrier/wrapping.nvim",
  config = function()
    require("wrapping").setup({
      auto_set_mode_filetype_allowlist = {
        "markdown",
      },
    })

    -- default to soft wrap for markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        require("wrapping").soft_wrap_mode()
      end,
    })
  end,
}
