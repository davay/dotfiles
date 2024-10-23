return {
  'echasnovski/mini.diff',
  version = false,
  config = function()
    local minidiff = require('mini.diff')
    local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null') == 'true\n'

    minidiff.setup({
      source = is_git_repo and minidiff.gen_source.git() or minidiff.gen_source.save()
    })
  end
}
