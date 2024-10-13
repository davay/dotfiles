return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local loader = require("luasnip.loaders.from_vscode")
    -- custom snippets
    loader.lazy_load({ paths = { "~/.config/nvim/snippets" } })
    -- friendly-snippets
    loader.lazy_load()

    local ls = require("luasnip")
    ls.filetype_extend("markdown", { "python" })
    ls.setup({
      link_children = true,
      link_roots = false,
      keep_roots = false,
    })

    local c = ls.choice_node
    ls.choice_node = function(pos, choices, opts)
      if opts then
        opts.restore_cursor = true
      else
        opts = { restore_cursor = true }
      end
      return c(pos, choices, opts)
    end
  end,
}
