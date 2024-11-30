return {
  'echasnovski/mini.files',
  version = false,
  config = function()
    require('mini.files').setup({
      windows = {
        preview = true,
        max_number = 3,
        width_preview = 70,
        width_focus = 25,
        width_nofocus = 10,
      },
      mappings = {
        -- swap, always close explorer after going in
        close = '<Esc>',
        go_in = 'l',
        go_in_plus = '<CR>',

      }
    })
  end
}
