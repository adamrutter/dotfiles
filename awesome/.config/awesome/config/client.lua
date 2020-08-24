-- Set border colours for focused/not focused clients
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Prevent clients from being unreachable after screen count changes.
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      awful.placement.no_offscreen(c)
  end
end)