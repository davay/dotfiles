return {
  'echasnovski/mini.files',
  version = false,
  config = function()
    require('mini.files').setup({
      windows = {
        preview = true,
        max_number = 3,
        width_preview = 80,
        width_focus = 30,
        width_nofocus = 10,
      },
      mappings = {
        -- swap, always close explorer after going in
        go_in = 'L',
        go_in_plus = 'l',
      }
    })
  end
}
