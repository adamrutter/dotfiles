-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

awesome.connect_signal('exit', function()
  awesome.kill(get_forecast, awesome.unix_signal.SIGTERM)
end)

-- Emit a signal when the layout changes
tag.connect_signal("property::layout", function() 
  awesome.emit_signal("layout_changed")
end)

-- Emit a signal when the tag changes
tag.connect_signal("property::selected", function(tag)
  if (tag.selected == true) then
    awesome.emit_signal("tag_changed")
  end
end)