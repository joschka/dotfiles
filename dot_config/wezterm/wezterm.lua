local wezterm = require("wezterm")

local launch_menu = {
	{ args = { "nvim", "." } },
	{ args = { "npm", "install" } },
	{ args = { "npm", "start" } },
	{ args = { "lazygit" } },
	{ args = { "node" } },
	{ args = { "irb" } },
	{ args = { "ipython" } },
	{ args = { "lua" } },
	{ cwd = wezterm.home_dir .. "/.config/wezterm", args = { "nvim", "wezterm.lua" } },
	{ cwd = wezterm.home_dir .. "/.config/fish", args = { "nvim", "config.fish" } },
	{ label = "nvim obsidian", cwd = wezterm.home_dir .. "/Vault/Default", args = { "nvim", "." } },
	{ cwd = wezterm.home_dir, args = { "nvim", "todo.txt" } },
}

local keys = {
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "Y", mods = "CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "P", mods = "CTRL", action = "Paste" },
	{ key = "C", mods = "CTRL", action = "ActivateCopyMode" },
	{ key = "F", mods = "CTRL", action = "QuickSelect" },
	{ key = "/", mods = "CTRL", action = wezterm.action({ Search = { CaseInSensitiveString = "" } }) },
	{ key = "<", mods = "CTRL", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = ">", mods = "CTRL", action = wezterm.action({ MoveTabRelative = 1 }) },
	{ key = "X", mods = "CTRL", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = " ", mods = "ALT", action = "ShowTabNavigator" },
	{ key = " ", mods = "CTRL", action = "ShowLauncher" },
	{ key = "=", mods = "CTRL", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "|", mods = "CTRL", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
}

for i = 1, 12 do
	if launch_menu[i] then
		table.insert(
			keys,
			{ key = "F" .. i, mods = "CTRL", action = wezterm.action({ SpawnCommandInNewTab = launch_menu[i] }) }
		)
	end
end

return {
	launch_menu = launch_menu,
	keys = keys,
	font_size = 18.4,
	color_scheme = "nord",
	colors = {
		tab_bar = {
			background = "#8fbcbb",
			active_tab = { bg_color = "#2e3440", fg_color = "#d8dee9" },
			inactive_tab = { bg_color = "#8fbcbb", fg_color = "#2e3440" },
			inactive_tab_hover = { bg_color = "#3b4252", fg_color = "#d8dee9" },
			new_tab = { bg_color = "#d08770", fg_color = "#2e3440" },
			new_tab_hover = { bg_color = "#d08770", fg_color = "#2e3440" },
		},
	},
	inactive_pane_hsb = { saturation = 0.8, brightness = 0.3 },
	window_padding = { left = 2, right = 2, top = 0, bottom = 0 },
	quick_select_alphabet = "qwertz",
	set_environment_variables = {
		VTE_VERSION = "6003", -- fish & OSC 7 https://github.com/wez/wezterm/issues/115#issuecomment-765869705
	},
	exit_behavior = "Close",
}
