return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',   -- for session lens
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Downloads', '/' },
    -- log_level = 'debug',
    mappings = {},

    -- To fix the bug when using neotree too
    -- the file before last is always opened
    -- https://github.com/rmagatti/auto-session/issues/373
    -- called when no session is restored
    no_restore_cmds = {
      -- 'Neotree show',
    },

    -- called after a session is restored
    post_restore_cmds = {
      -- 'Neotree show',
    },
  }
}
