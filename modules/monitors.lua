------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1.2",
})
hl.monitor({
	output = "DP-1",
	mode = "1920x1080@75.00",
	position = "1600x0",
	scale = "1",
})

-- When the laptop lid is closed: disable the internal display
hl.bind("switch:on:Lid Switch", function()
	hl.monitor({
		output = "eDP-1",
		disabled = true,
	})
end, { locked = true })

-- When the laptop lid is opened: re-enable the internal display
hl.bind("switch:off:Lid Switch", function()
	hl.monitor({
		output = "eDP-1",
		disabled = false,
		mode = "1920x1080@60",
		position = "0x0",
		scale = "1.2", -- Matched to your initial config scale
	})
end, { locked = true })
