return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  ft = "swift",
  config = function()
    require("xcodebuild").setup({
      code_coverage = {
        enabled = true,
      },
    })
  end,
}
