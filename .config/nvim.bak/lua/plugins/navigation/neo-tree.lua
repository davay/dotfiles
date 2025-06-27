return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = 'Neotree',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information NOTE: DOESN'T WORK
  },
  config = function()
    require("neo-tree").setup({
      hijack_netrw_behavior = "open_default",
      enable_git_status = true,
      enable_diagnostics = false,
      close_if_last_window = true,
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "Outline" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      window = {
        width = 30,
        position = "right",
        mappings = {
          ["<space>"] = {
            "toggle_node",
            nowait = true,
          },
          -- ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
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

      -- auto-open, but no longer needed since auto-session hooks
      -- vim.cmd [[
      --   augroup NEOTREE_AUGROUP
      --   autocmd!
      --   au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree action=show position=right reveal_force_cwd=true") end, 10)
      --   augroup END
      -- ]]
    })
  end
}
