local wezterm = require 'wezterm';

return {
  -- Set the window background opacity (0.0 for fully transparent, 1.0 for fully opaque)
  window_background_opacity = 0.5,

  -- Optionally, you can also set text background opacity
  text_background_opacity = 0.6,

  -- If you want to adjust the blur when transparent, you can add this
  macos_window_background_blur = 14,  -- Adjust the blur radius for macOS

  color_scheme = 'rose-pine-moon',

  hide_tab_bar_if_only_one_tab = true,

  tab_bar_at_bottom = true,

  -- window_background_image = '/path/to/wallpaper.jpg',
  -- .window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  -- brightness = 0.3,
  -- -- You can adjust the hue by scaling its value.
  -- -- a multiplier of 1.0 leaves the value unchanged.
  -- hue = 1.0,
  -- -- You can adjust the saturation also.
  -- saturation = 1.0,
  -- }
  -- window_background_gradient = {
  -- colors = { '#EEBD89', '#D13ABD' },
  -- Specifies a Linear gradient starting in the top left corner.
  -- orientation = { Linear = { angle = -45.0 } },
  -- }

  font = wezterm.font("Hack Nerd Font"),

  -- Map Option + Left or Right key to move one word
  keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = "LeftArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
  },
}
