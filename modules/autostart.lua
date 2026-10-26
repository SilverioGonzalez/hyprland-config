-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	-- 1. Standard graphical environment utilities
	hl.exec_cmd("waybar")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	-- 2. Clipboard tracking daemons
	hl.exec_cmd('bash -c "wl-paste --type text --watch cliphist store"')
	hl.exec_cmd('bash -c "wl-paste --type image --watch cliphist store"')
end)
