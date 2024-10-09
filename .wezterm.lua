local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Material (Gogh)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Gruvbox dark, pale (base16)'
config.font = wezterm.font('Liga SFMono Nerd Font', { weight = "Regular" })
config.font_size = 13
config.front_end = 'WebGpu'
config.freetype_load_target = "Light"
config.freetype_render_target = 'Light'
config.freetype_load_flags = 'NO_HINTING'
config.dpi = 144
config.enable_scroll_bar = true
config.bold_brightens_ansi_colors = 'No'
config.cell_width = 1

-- Command Palette
config.command_palette_rows = 7
config.command_palette_font_size = 15
config.command_palette_bg_color = "#44382D"
config.command_palette_fg_color = "#c4a389"


-- Visual bell
config.audible_bell = 'Disabled'
config.visual_bell = {
  target = "CursorColor",
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 300,
}

config.enable_kitty_graphics = true

config.keys = {
  {
    key = 'p',
    mods = 'CMD',
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal,
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical,
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

-- Mouse
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('ClipboardAndPrimarySelection'),
  },

  -- Open links on Cmd+click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

return config
