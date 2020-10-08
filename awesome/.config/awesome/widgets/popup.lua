local function widget(content)
  local container = wibox.container.margin()
  container.top = beautiful.wibar_popup_spacer * 0.75
  container.bottom = beautiful.wibar_popup_spacer * 0.75
  container.left = beautiful.wibar_popup_spacer * 0.5
  container.right = beautiful.wibar_popup_spacer * 0.5
  container.widget = content

  return awful.popup {
    widget = container,
    visible = false,
    ontop = true,
    offset = beautiful.wibar_popup_offset,
    preferred_anchors = { "middle" },
    border_width = 1,
    border_color = beautiful.colors.background.hue_600,
  }
end

return widget