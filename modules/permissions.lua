-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- 1. Enable the Android-like explicit permission enforcement framework
hl.config({
	ecosystem = {
		enforce_permissions = true,
	},
})

-- 2. Whitelist Core System Utilities (Converted to proper Lua table syntax)
hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })

-- 3. Whitelist Status Bar (Waybar)
-- Prevents prompt loops when tracking active workspaces and cursor geometry
hl.permission({ binary = "/usr/bin/waybar", type = "cursorpos", mode = "allow" })

-- 4. Whitelist Clipboard Subsystem
-- Allows your background daemons and shell pipelines to track context seamlessly
hl.permission({ binary = "/usr/bin/bash", type = "input-capture", mode = "allow" })
hl.permission({ binary = "/usr/bin/wl-paste", type = "input-capture", mode = "allow" })
hl.permission({ binary = "/usr/bin/cliphist", type = "input-capture", mode = "allow" })
