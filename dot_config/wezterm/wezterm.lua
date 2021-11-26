local wezterm = require 'wezterm';

local openEditor = {label = 'Open editor in current directory', args = {'nvim', '.'}}
local npmInstall = {args = {'npm', 'install'}}
local npmStart = {args = {'npm', 'start'}}
local lazygit = {args = {'lazygit'}}
local nodeRepl = {label = 'Node.js REPL', args = {'node'}}
local rubyRepl = {label = 'Ruby REPL', args = {'irb'}}
local pythonRepl = {label = 'Python REPL', args = {'ipython'}}
local luaRepl = {label = 'Lua REPL', args = {'lua'}}
local weztermConfig = {label = 'Edit wezterm config', cwd = wezterm.home_dir .. '/.config/wezterm', args = {'nvim', 'wezterm.lua'}}
local fishConfig = {label = 'Edit fish config', cwd = wezterm.home_dir .. '/.config/fish', args = {'nvim', 'config.fish'}}
local obsidian = {label = 'Edit Obsidian files', cwd = wezterm.home_dir .. '/Vault/Default', args = {'nvim', '.'}}
local todos = {label = 'Edit todo list', cwd = wezterm.home_dir, args = {'nvim', 'todo.txt'}}

return {
  launch_menu = {
    openEditor,
    npmInstall,
    npmStart,
    lazygit,
    nodeRepl,
    rubyRepl,
    pythonRepl,
    luaRepl,
    weztermConfig,
    fishConfig,
    obsidian,
    todos,
  },
  font_size = 18.4,
  color_scheme = 'nord',
  colors = {
    tab_bar = {
      background = '#8fbcbb',
      active_tab = {bg_color = '#2e3440', fg_color = '#d8dee9'},
      inactive_tab = {bg_color = '#8fbcbb', fg_color = '#2e3440'},
      inactive_tab_hover = {bg_color = '#3b4252', fg_color = '#d8dee9'},
      new_tab = {bg_color = '#d08770', fg_color = '#2e3440'},
      new_tab_hover = {bg_color = '#d08770', fg_color = '#2e3440'},
    },
  },
  inactive_pane_hsb = {saturation = 0.8, brightness = 0.3},
  window_padding = {left = 2, right = 2, top = 0, bottom = 0},
  quick_select_alphabet = 'qwertz',
  keys = {
    {key = '+', mods = 'CTRL', action = 'IncreaseFontSize'},
    {key = 'Y', mods = 'CTRL', action = wezterm.action{CopyTo='Clipboard'}},
    {key = 'P', mods = 'CTRL', action = 'Paste'},
    {key = 'C', mods = 'CTRL', action = 'ActivateCopyMode'},
    {key = '/', mods = 'CTRL', action = wezterm.action{Search = {CaseInSensitiveString=''}}},
    {key = 'F', mods = 'CTRL', action = 'QuickSelect'},
    {key = '<', mods = 'CTRL', action = wezterm.action{MoveTabRelative=-1}},
    {key = '>', mods = 'CTRL', action = wezterm.action{MoveTabRelative=1}},
    {key = 'X', mods = 'CTRL', action = wezterm.action{CloseCurrentPane={confirm=true}}},
    {key = 'F1', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=openEditor}},
    {key = 'F2', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=npmInstall}},
    {key = 'F3', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=npmStart}},
    {key = 'F4', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=lazygit}},
    {key = 'F5', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=nodeRepl}},
    {key = 'F6', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=rubyRepl}},
    {key = 'F7', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=pythonRepl}},
    {key = 'F8', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=luaRepl}},
    {key = 'F9', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=weztermConfig}},
    {key = 'F10', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=fishConfig}},
    {key = 'F11', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=obsidian}},
    {key = 'F12', mods = 'CTRL', action = wezterm.action{SpawnCommandInNewTab=todos}},
    {key = ' ', mods = 'ALT', action='ShowTabNavigator'},
    {key = ' ', mods = 'CTRL', action='ShowLauncher'},
    {key = '=', mods = 'CTRL', action = wezterm.action{SplitVertical = {domain = 'CurrentPaneDomain'}}},
    {key = '|', mods = 'CTRL', action = wezterm.action{SplitHorizontal = {domain = 'CurrentPaneDomain'}}},
  },
  set_environment_variables = {
    VTE_VERSION = '6003', -- fish & OSC 7 https://github.com/wez/wezterm/issues/115#issuecomment-765869705
  },
  exit_behavior = 'Close',
}
