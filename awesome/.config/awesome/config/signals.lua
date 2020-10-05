-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

awesome.connect_signal('exit', function()
  awesome.kill(get_forecast, awesome.unix_signal.SIGTERM)
end)
