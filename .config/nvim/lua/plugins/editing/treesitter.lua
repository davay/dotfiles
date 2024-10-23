return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context"
  },
  config = function()
    require('treesitter-context').setup({
      mode = 'cursor' -- cursor or topline
    })

    require 'nvim-treesitter.configs'.setup({
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/parsers.lua
      ensure_installed = {
        "awk", "c", "cpp", "c_sharp", "csv", "css", "diff", "dockerfile", "gitignore", "go", "html",
        "java", "javascript", "jq", "json", "latex", "lua", "markdown", "markdown_inline", "mermaid", "nginx",
        "python", "query", "r", "regex", "rst", "scss", "sql", "tsx", "typescript", "vim",
        "vimdoc", "xml", "yaml"
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,
        disable = {},

        -- To disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
        --   local max_filesize = 100 * 1024 -- 100 KB
        --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --   if ok and stats and stats.size > max_filesize then
        --     return true
        --   end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      -- keymaps defined in keymaps.lua
      textobjects = {
        move = {
          enable = true,
          set_jumps = false,
        },
        select = {
          enable = true,
          lookahead = true,
        }
      }
    })
    require("nvim-treesitter").setup()
  end
}
