return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    -- hijack_netrw_behavior = 'disabled', -- don't use neo-tree when opening directory
    close_if_last_window = true,
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "Outline" }, -- when opening files, do not use windows containing these filetypes or buftypes
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    window = {
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = true,
        },
      }
    },
    document_symbols = {
      follow_cursor = true,
    },
    -- event_handlers = {
    --   {
    --     -- auto close after opening file
    --     event = "file_open_requested",
    --     handler = function()
    --       require("neo-tree.command").execute({ action = "close" })
    --     end
    --   },
    -- }
  }
}
