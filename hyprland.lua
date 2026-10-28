------------------------
-- configuration start--
------------------------

-- modules--------

require("modules.appearance")
require("modules.inputs")
require("modules.monitors")
require("modules.autostart")
require("modules.permissions")
--require("modules.binds")
---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "ghostty"
local browser = "firefox"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("TERMINAL", terminal)

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local home = os.getenv("HOME")

-- Primary system window spawning hooks
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.window.close())

-- FZF run / wallpaper / power menu keybinds
hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd(
		string.format("%s/.local/bin/sys_term --class com.custom.centertui bash '%s/.local/bin/launch_app'", home, home)
	)
)
hl.bind(
	mainMod .. " + A",
	hl.dsp.exec_cmd(
		string.format("%s/.local/bin/sys_term --class com.custom.centertui bash '%s/.local/bin/add_app'", home, home)
	)
)
hl.bind(
	mainMod .. " + R",
	hl.dsp.exec_cmd(
		string.format("%s/.local/bin/sys_term --class com.custom.centertui '%s/.local/bin/fzf_run'", home, home)
	)
)
hl.bind(
	mainMod .. " + W",
	hl.dsp.exec_cmd(
		string.format(
			"%s/.local/bin/sys_term --class com.custom.large_centertui '%s/.local/bin/select_wallpaper'",
			home,
			home
		)
	)
)
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(string.format("'%s/.local/bin/random_wallpaper'", home)))
hl.bind(
	mainMod .. " + Escape",
	hl.dsp.exec_cmd(
		string.format("%s/.local/bin/sys_term --class com.custom.centertui '%s/.local/bin/power_menu'", home, home)
	)
)

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "center-tui-launcher",
	match = { class = "com.custom.centertui" },
	float = true,
	center = true,
	size = { 600, 400 },
	stay_focused = true,
	dim_around = true,
})
hl.window_rule({
	name = "large-center-tui-launcher",
	match = { class = "com.custom.large_centertui" },
	float = true,
	center = true,
	size = { 800, 600 },
	stay_focused = true,
	dim_around = true,
})
