local wezterm = require("wezterm")
return {
	adjust_window_size_when_changing_font_size = true,
	-- color_scheme = "Everforest Light (Gogh)",
	-- color_scheme = "Kanagawa Dragon (Gogh)",
	color_scheme = "Papercolor Dark (Gogh)",
	-- color_scheme = "Everforest Dark Soft (Gogh)",
	-- color_scheme = "Everforest Dark Medium (Gogh)",
	-- color_scheme = "Dracula (Official)",
	-- color_scheme = "OneDark",
	-- color_scheme = "duckbones",
	-- color_scheme = "Django",
	-- color_scheme = "rose-pine",
	-- color_scheme = "Gruvbox light, soft (base16)",
	-- color_scheme = "Gruvbox dark, soft (base16)",
	-- color_scheme = "Builtin Solarized Dark",
	-- color_scheme = "Solarized Dark - Patched",
	-- color_scheme = "Ayu Dark (Gogh)",

	font_size = 15.0,
	line_height = 1.1,
	cell_width = 1.0,
	font = wezterm.font({
		-- family = "SFMono Nerd Font",
		-- family = "JetBrains Mono Nerd Font",
		family = "Dank Mono Nerd Font",
		-- family = "Iosevka Nerd Font  Mono",
		-- weight = "Regular",
	}),

	font = wezterm.font_with_fallback({
		{ family = "DankMono Nerd Font", weight = "Regular" },
		{ family = "Dank Mono", weight = "Regular" }, -- System fallback
	}),

	harfbuzz_features = { "calt=1", "clig=1", "liga=1", "kern=1" },
	front_end = "OpenGL",

	-- window_background_image = "/home/moon/Shrey/Pictures/rename.jpg",
	-- window_background_image_hsb = {
	-- brightness = 0.1,
	-- hue = 1.0,
	-- saturation = 1.0,
	--},

	window_close_confirmation = "NeverPrompt",
	enable_tab_bar = false,
	default_cursor_style = "SteadyBlock",
	window_background_opacity = 0.9,
	window_decorations = "NONE",
	window_padding = {
		left = 25,
		right = 25,
		top = 25,
		bottom = 15,
	},

	keys = {
		{

			key = "q",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
