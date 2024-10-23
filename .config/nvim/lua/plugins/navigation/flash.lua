return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = {
        enabled = true,
        highlight = {
          backdrop = true
        }
      }
    },
    label = {
      rainbow = {
        enabled = true,
        -- number between 1 and 9
        shade = 9,
      },
    }
  },
}
