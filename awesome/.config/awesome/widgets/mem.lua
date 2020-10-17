local function widget()
  -- Bar widget
  local container = wibox.container.background()
  local bg = beautiful.accent.hue_500
  
  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin
  
  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font(11)
  icon_content.text = ""
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1
  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  icon.widget = icon_content
  
  local get_mem_usage = [[ bash -c "cat /proc/meminfo | grep 'MemTotal\|MemAvailable' | awk '{print $2}' | tr '\n' ' ' | awk '{print (1 - ($2 / $1)) * 100}' | awk -F. '{print $1}'" ]]
  local value = awful.widget.watch(get_mem_usage, 5, function(widget, stdout)
    widget:set_text(helpers.round(stdout:match("%g*")) .. "%")
  end)
  
  -- Construct widget
  content.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    icon,
    value,
    spacing = beautiful.wibar_widget_icon_margin
  }
  container.widget = content

  return container
end

return widget