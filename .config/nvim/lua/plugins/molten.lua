-- Required Python packages: pynvim, jupyter_client, ipykernel
local is_kitty = os.getenv("KITTY_WINDOW_ID") ~= nil
local is_ghostty = os.getenv("GHOSTTY_BIN_DIR") ~= nil

local deps = {}
if is_kitty or is_ghostty then
  deps = { "3rd/image.nvim" }
end

return {
  {
    "benlubas/molten-nvim",
    dependencies = deps,
    ft = "markdown",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_auto_open_output = false

      if is_kitty or is_ghostty then
        vim.g.molten_image_provider = "image.nvim"
      else
        vim.g.molten_image_provider = "none"
      end

      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

      -- disable code highlight
      vim.api.nvim_set_hl(0, "MoltenCell", {})
    end,
  },
}
