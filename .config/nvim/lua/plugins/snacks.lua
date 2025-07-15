return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = {
            hidden = { "input" },
          },
          win = {
            list = {
              keys = {
                ["<Tab>"] = false,
                ["<S-Tab>"] = false,
              },
            },
            input = {
              keys = {
                ["<Tab>"] = false,
                ["<S-Tab>"] = false,
              },
              enter = false,
            },
          },
        },
      },
    },
  },
}
