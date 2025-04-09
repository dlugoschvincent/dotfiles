local wezterm = require("wezterm")

local config = wezterm.config_builder()
local io = require("io")
local os = require("os")
local act = wezterm.action

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

config.max_fps = 120
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.color_scheme = "tokyonight_night"
config.tab_max_width = 50

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local function tab_title(tab_info)
		local cwd = tab_info.active_pane.current_working_dir.file_path:match("([^/]+)$") or "/"

		local process = tab_info.active_pane.foreground_process_name:match(".*/(.*)$")
		if process and cwd then
			return process .. "@" .. cwd
		end
	end

	local title = " " .. tab_title(tab) .. " "
	local LEFT_HARD_DIVIDER = wezterm.nerdfonts.pl_left_hard_divider
	local background = "#000000"
	local foreground = "#c0caf5"
	if tab.is_active then
		foreground = "#ff9e64"
	end

	if tab.tab_index == 0 then
		return {
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = title },
			{ Background = { Color = "#1a1b26" } },
			{ Foreground = { Color = background } },
			{ Text = LEFT_HARD_DIVIDER },
		}
	end
	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = "#1a1b26" } },
		{ Text = LEFT_HARD_DIVIDER },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = "#1a1b26" } },
		{ Foreground = { Color = background } },
		{ Text = LEFT_HARD_DIVIDER },
	}
end)

-- config.char_select_font = wezterm.font("0xProto Nerd Font")
-- config.char_select_font_size = 12.0
--
-- config.command_palette_font = wezterm.font("0xProto Nerd Font")
-- config.command_palette_font_size = 12.0

config.font = wezterm.font("0xProto Nerd Font")
config.font_size = 12.0

config.freetype_load_flags = "NO_HINTING"
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 0.5,
}

config.enable_kitty_graphics = true
config.enable_wayland = true
config.window_padding = {
	right = 0,
	bottom = 0,
	left = 0,
	top = 0,
}

if is_darwin then
	config.window_decorations = "RESIZE"
end

config.window_decorations = "NONE"

config.front_end = "WebGpu"
config.ssh_domains = {
	{
		name = "dlugoschvincent.de",
		remote_address = "185.170.113.126",
		username = "vdlugosch",
	},
	{
		name = "dakispro.de",
		remote_address = "152.53.20.250",
		username = "vdlugosch",
	},
}

config.unix_domains = {
	{
		name = "unix",
		local_echo_threshold_ms = 10,
	},
}

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace() .. " in " .. pane:get_domain_name())
end)

config.keys = {
	{ key = "-", mods = "ALT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "_", mods = "ALT|SHIFT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_window()
		end),
	},
	{ key = "c", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "H", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "f", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
	{ key = "u", mods = "ALT", action = wezterm.action.ShowLauncher },
	{
		key = "d",
		mods = "ALT",
		action = act.DetachDomain("CurrentPaneDomain"),
	},
	{
		key = "Enter",
		mods = "ALT",
		action = act.SwitchToWorkspace({
			name = "default",
		}),
	},

	{
		key = "s",
		mods = "ALT",
		action = act.SwitchToWorkspace({
			name = "spotify",
			spawn = {
				args = { "ncspot" },
			},
		}),
	},
	{
		key = "t",
		mods = "ALT",
		action = act.SwitchToWorkspace({
			name = "task",
		}),
	},
}

-- and finally, return the configuration to wezterm
return config
