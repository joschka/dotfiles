local wezterm = require 'wezterm';

return {
  font_size = 18.4,
  color_scheme = 'nord',
  quick_select_alphabet = 'qwertz',
  window_padding = {left = 2, right = 2, top = 0, bottom = 0},
  keys = {
    {key = '"', mods = 'CTRL|ALT', action = wezterm.action{SplitVertical = {domain = 'CurrentPaneDomain'}}},
    {key = '%', mods = 'CTRL|ALT', action = wezterm.action{SplitHorizontal = {domain = 'CurrentPaneDomain'}}},
  },
  set_environment_variables = {
    VTE_VERSION = '6003', -- fish & OSC 7 https://github.com/wez/wezterm/issues/115#issuecomment-765869705
  },
}
