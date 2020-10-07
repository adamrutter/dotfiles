local function widget(s)
  bg_color = "hue_700"
  
  local container = wibox.container.background()
  -- container.bg = beautiful.accent[bg_color]
  container.fg = helpers.calculate_fg(beautiful.accent[bg_color])

  container:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc(1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end)
  ))

  
  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin
 
  local icon = awful.widget.layoutbox(s)
  beautiful.theme_assets.recolor_layout(beautiful, beautiful.icon_color)
  icon.forced_height = dpi(15)
  icon.forced_width = dpi(15)

  local align_icon = wibox.widget {
    layout = wibox.layout.align.vertical,
    nil,
    icon,
    nil,
    expand = "outside"
  }

  local text = wibox.widget.textbox()
 
  -- Update widget text on layout change
  tag.connect_signal("property::layout", function()
    text.text = beautiful.layout_name[awful.layout.getname(awful.layout.get(s))]
  end)
  
  -- Update widget text on tag change
  screen[s]:connect_signal("tag::history::update", function()
    text.text = beautiful.layout_name[awful.layout.getname(awful.layout.get(s))]
  end)

  container.widget = content
  content.widget = wibox.widget {
    align_icon,
    text,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.wibar_widget_icon_margin
  }

  return container
end

return widget
