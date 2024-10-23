return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "tabs",
        themable = false,
        separator_style = "padded_slant",
        style_preset = {
          bufferline.style_preset.no_bold,
          -- bufferline.style_preset.no_italic
        },
        indicator = {
          style = 'none'
        },
        offsets = {
          {
            filetype = "oil",
            text = "File Explorer",
            highlight = "Directory",
            separator = true
          },
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true
          }
        },
        custom_filter = function(buf, buf_nums)
          -- Get the filetype of the buffer
          local ft = vim.bo[buf].filetype
          -- List of filetypes to ignore
          local ignore_filetypes = { 'qf', 'Outline', 'neo-tree', 'oil', 'TelescopePrompt' }

          -- Return false for filetypes we want to ignore
          if vim.tbl_contains(ignore_filetypes, ft) then
            return false
          end
          return true
        end
      }
    })
  end
}
