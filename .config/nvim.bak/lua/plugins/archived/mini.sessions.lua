return {
  'echasnovski/mini.sessions',
  version = false,
  config = function()
    require('mini.sessions').setup({
      autoread = true,
      autowrite = true
    })
  end
}
