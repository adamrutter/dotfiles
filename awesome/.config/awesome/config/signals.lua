-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Reload Xresources values
awesome.connect_signal("hot_reload::xresources", function()
	helpers.set_xresources_colors(beautiful.colors)
	beautiful.accent = beautiful.colors[beautiful.accent_name]
end)
