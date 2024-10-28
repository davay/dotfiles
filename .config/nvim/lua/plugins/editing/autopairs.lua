return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      check_ts = true,
      enable_check_bracket_line = false,
    })
  end
}
