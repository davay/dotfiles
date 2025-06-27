-- by default init.lua checks for lua/ folder when asked to `require()`
require('plugin_manager') -- using lazy.nvim
require('settings') -- this checks for lua/settings.lua
require('keymaps')
