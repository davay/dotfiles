-- Required Python packages: jupytext
return {
  "GCBallesteros/jupytext.nvim",
  dependencies = {
    "stevearc/conform.nvim"
  },
  lazy = false, -- can't be lazy loaded if i want detection to be reliable
  opts = {
    style = "markdown",
    output_extension = "md",
    force_ft = "markdown",
  },
}
