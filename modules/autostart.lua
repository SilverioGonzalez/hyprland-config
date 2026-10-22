-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	-- 1. Standard graphical environment utilities
	hl.exec_cmd("waybar")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprpaper")
	-- 2. Clipboard tracking daemons
	-- Complex shell pipelines (|) require bash execution wrapping to resolve correctly
	hl.exec_cmd('bash -c "wl-paste --type text --watch cliphist store"')
	hl.exec_cmd('bash -c "wl-paste --type image --watch cliphist store"')
end)
