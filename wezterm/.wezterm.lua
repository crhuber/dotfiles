-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {
}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = 'tokyonight'
config.enable_scroll_bar = true
config.font = wezterm.font { family = 'Jetbrains Mono', weight = 'Bold'}
config.font_size = 12
config.scrollback_lines = 100000
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
-- we achieve a minimalist design by disabling the title bar and enabling the resizable borders
-- config.window_decorations = "TITLE"

config.colors = {
  -- The default text color
  foreground = 'white',
}

--  so you can easily see which pane you're currently on when you switch between them.
config.inactive_pane_hsb = {
 saturation = 0.8,
 brightness = 0.5
}

config.default_prog = { 'zsh','-i','-c','/usr/local/bin/fish'}

config.keys = {
  -- CMD-y starts `top` in a new window
  {
    key = 'y',
    mods = 'CMD',
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { 'top' },
    },
  },
}

config.launch_menu = {
  {
    label = 'fish',
    args = { '/usr/local/bin/fish'},
  },
}


-- and finally, return the configuration to wezterm
return config

