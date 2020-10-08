-- Display a clock/calendar
local function widget()
  local container = wibox.container.background()
  local bg = beautiful.accent.hue_800
  -- container.bg = bg
  container.fg = helpers.calculate_fg(bg)

  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin

  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font()
  icon_content.text = ""
  icon.widget = icon_content
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1

  -- Init clock/calendar
  local clock = wibox.widget.textclock("%H:%M")

  -- Construct widget
  container.widget = content
  content.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    icon,
    clock,
    spacing = beautiful.wibar_widget_icon_margin
  }

  return container
end

return widget