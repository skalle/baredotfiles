local wezterm = require("wezterm")

return {
	-- font = wezterm.font 'MesloLGS NF',
	font = wezterm.font("Hack Nerd Font"),
	-- font = wezterm.font 'Monolisa',
	-- font = wezterm.font("Iosevka"),
	-- font = wezterm.font("Iosevka Nerd Font"), -- /home/olak/.local/share/fonts/Nerd
	--	font = wezterm.font("Iosevka Nerd Font", { weight = "Medium", stretch = "Normal", style = "Normal" }),
	color_scheme = "SolarizedDark (Gogh)",
	-- color_scheme = "nordfox",
	font_size = 8.0,
	-- Window stuff.
	hide_tab_bar_if_only_one_tab = true,
	-- 	enable_csi_u_key_encoding = true,
	keys = {
		-- CTRL-SHIFT-l activates the debug overlay
		{ key = "L", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	},
}
