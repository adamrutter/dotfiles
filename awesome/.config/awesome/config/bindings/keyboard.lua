-- Global bindings (not client specific)
globalkeys = gears.table.join(
	-- Awesome
	awful.key({ modkey }, "F1", hotkeys_popup.show_help, {description="show help", group="awesome"}),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Control", "Shift" }, "BackSpace", awesome.quit, { description = "quit awesome", group = "awesome" }),

	-- Launcher
	awful.key({ modkey }, "space", function() awful.spawn("/home/adam/.config/rofi/menu/launch.sh ") end,{ description = "launcher", group = "launcher" }),
	awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, { description = "open a terminal", group = "launcher" }),

	-- Tags
	awful.key({ modkey }, "Tab", awful.tag.viewnext, { description = "view next tag", group = "tag" }),
	awful.key({ modkey, "Shift" }, "Tab", awful.tag.viewprev, { description = "view previous tag", group = "tag" }),

	-- Layouts
	awful.key({ modkey }, "e", function() awful.layout.inc( 1) end, { description = "change tag to next layout", group = "layout" }),
	awful.key({ modkey, "Shift" }, "e", function() awful.layout.inc( -1) end, { description = "change tag to previous layout", group = "layout" }),
	awful.key({ modkey, "Shift" }, "d", function() awful.tag.incmwfact( 0.05) end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "a", function() awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "w", function() awful.tag.incncol( 1, nil, true) end,{ description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Shift" }, "s", function() awful.tag.incncol(-1, nil, true) end,{ description = "decrease the number of columns", group = "layout" })
)

-- Client specific bindings
clientkeys = gears.table.join(
	awful.key({ modkey }, "q", function(c) c:kill() end, { description = "close", group = "client" }),
	awful.key({ modkey }, "t", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
	
	-- Focus clients
	awful.key({ modkey_2 }, "w", function(c) awful.client.focus.bydirection ("up") end, { description = "focus client above", group = "client" }),
	awful.key({ modkey_2 }, "a", function(c) awful.client.focus.bydirection ("left") end, { description = "focus client to left", group = "client" }),
	awful.key({ modkey_2 }, "s", function(c) awful.client.focus.bydirection ("down") end, { description = "focus client below", group = "client" }),
	awful.key({ modkey_2 }, "d", function(c) awful.client.focus.bydirection ("right") end, { description = "focus client to right", group = "client" }),
	
	-- Move clients
	awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "w", function(c) awful.client.swap.bydirection("up") end, { description = "move client up", group = "client" }),
	awful.key({ modkey }, "a", function(c) awful.client.swap.bydirection("left") end, { description = "move client left", group = "client" }),
	awful.key({ modkey }, "s", function(c) awful.client.swap.bydirection("down") end, { description = "move client down", group = "client" }),
	awful.key({ modkey }, "d", function(c) awful.client.swap.bydirection("right") end, { description = "move client right", group = "client" }),
	
	awful.key({ modkey }, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{ description = "(un)maximize", group = "client" }
	),
	awful.key({ modkey, "Control" }, "m",
		function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end ,
		{ description = "(un)maximize vertically", group = "client" }
	),
	awful.key({ modkey, "Shift" }, "m",
		function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end ,
		{ description = "(un)maximize horizontally", group = "client" }
	),
	awful.key({ modkey }, "f",
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{ description = "toggle fullscreen", group = "client" }
	)
)

-- Bind all key numbers to tags.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only
		awful.key({ modkey }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{ description = "view tag #"..i, group = "tag" }
		),
		-- Move client to tag
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "move focused client to tag #"..i, group = "tag" }
		)
	)
end

clientbuttons = gears.table.join(
	awful.button({ }, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

root.keys(globalkeys)