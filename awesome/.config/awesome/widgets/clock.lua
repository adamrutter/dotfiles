-- Display a clock/calendar
local function widget()
  local container = wibox.container.background()
  helpers.hot_reload_bg(container, "hue_800")

  local content = wibox.container.margin()
  content.left = beautiful.wibar_padding * 0.75
  content.right = beautiful.wibar_padding * 0.75

  local icon = wibox.widget.textbox()
  icon.font = helpers.icon_font()
  icon.text = ""
  -- Stop icon getting clipped
  icon.forced_width = icon:get_preferred_size() + 1

  -- Init clock/calendar
  local clock = wibox.widget.textclock("%H:%M")
  local cal = awful.widget.calendar_popup.month()

  -- Spawn calendar popup
  -- container:connect_signal("mouse::enter", function()
  --   cal.visible = true
  --   cal:call_calendar(0, "br")
  -- end)
  -- container:connect_signal("mouse::leave", function()
  --   cal.visible = false
  -- end)

  -- Construct widget
  container.widget = content
  content.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    icon,
    clock,
    spacing = beautiful.wibar_padding / 2
  }

  return container
end

return widget