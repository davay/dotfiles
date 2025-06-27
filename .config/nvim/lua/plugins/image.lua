return {
  "3rd/image.nvim",
  build = false,
  cond = function()
    local is_kitty = os.getenv("KITTY_WINDOW_ID") ~= nil
    local is_ghostty = os.getenv("GHOSTTY_BIN_DIR") ~= nil
    return is_kitty or is_ghostty
  end,
  opts = {
    processor = "magick_cli",
  },
}
