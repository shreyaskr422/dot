local wezterm = require("wezterm")
return {
	adjust_window_size_when_changing_font_size = false,
	-- color_scheme = "Everforest Light (Gogh)",
	-- color_scheme = "Kanagawa Dragon (Gogh)",
	-- color_scheme = "Papercolor Light (Gogh)",
	-- color_scheme = "Everforest Dark Soft (Gogh)",
	color_scheme = "Everforest Dark Medium (Gogh)",
	-- color_scheme = "Dracula+",
	-- color_scheme = "duckbones",
	-- color_scheme = "Django",
	-- color_scheme = "rose-pine-dawn",
	-- color_scheme = "Gruvbox light, soft (base16)",
	-- color_scheme = "Gruvbox dark, soft (base16)",
	-- color_scheme = "Builtin Solarized Dark",
	-- color_scheme = "Solarized Dark - Patched",

	font_size = 14.0,
	font = wezterm.font({
		-- family = "SFMono Nerd Font",
		family = "Iosevka Nerd Font Mono",
		--weight = "Bold",
	}),

	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
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
	window_background_opacity = 0.97,
	window_decorations = "NONE",
	window_padding = {
		left = 25,
		right = 25,
		top = 25,
		bottom = 25,
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
