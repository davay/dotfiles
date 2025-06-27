return {
  "stevearc/vim-arduino",
  config = function()
    vim.g.arduino_auto_baud = 1
    vim.g.arduino_serial_baud = 115200
  end
}
