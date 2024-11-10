return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = {
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "<C>",
        M = "<M>",
        D = "<D>",
        S = "<S>",
        CR = "<CR>",
        Esc = "<Esc>",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "<NL>",
        BS = "<BS>",
        Space = "<Space>",
        Tab = "<Tab>",
        F1 = "F1",
        F2 = "F2",
        F3 = "F3",
        F4 = "F4",
        F5 = "F5",
        F6 = "F6",
        F7 = "F7",
        F8 = "F8",
        F9 = "F9",
        F10 = "F10",
        F11 = "F11",
        F12 = "F12",
      },
    }
  },
  dependencies = {
    'echasnovski/mini.icons', -- TODO: probably just use one
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    {
      "?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
