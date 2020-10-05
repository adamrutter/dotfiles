-- Display the date
local function widget()
  local container = wibox.container.background()
  local bg = beautiful.accent.hue_800
  -- container.bg = bg
  container.fg = helpers.calculate_fg(bg)

  local content = wibox.container.margin()
  content.left = beautiful.wibar_padding * 0.75
  content.right = beautiful.wibar_padding * 0.75

  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font()
  icon_content.text = ""
  icon.widget = icon_content
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1

  -- Init clock/calendar
  local date = wibox.widget.textclock("%A, %-d %b")
  -- local cal = awful.widget.calendar_popup.month()

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
    date,
    spacing = beautiful.wibar_padding / 2
  }

  return container
end

return widget