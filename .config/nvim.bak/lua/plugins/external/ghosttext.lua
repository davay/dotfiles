return {
  'subnut/nvim-ghost.nvim',
  cond = function()
    -- #arg is 0 when nvim is started with no arguments
    -- otherwise, this loads the python provider which really slows down startup on large python files.
    return vim.fn.argc() == 0
  end
}
