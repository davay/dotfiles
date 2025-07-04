return {
  "3rd/image.nvim",
  build = false,
  cond = function()
    local is_kitty = os.getenv("KITTY_WINDOW_ID") ~= nil
    local is_ghostty = os.getenv("GHOSTTY_BIN_DIR") ~= nil
    return is_kitty or is_ghostty
  end,
  config = function()
    require("image").setup({
      backend = "kitty", -- kitty or ueberzug
      max_height = 33,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped -- disabled so images dont disappear when i use which-key
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        floating_windows = false,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" }, -- can also add quarto
      }
    })
  end
}
