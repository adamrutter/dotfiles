local function widget(content, title, x_padding)
  local heading = nil
  if title then
    heading = wibox.widget {
      widget = wibox.widget.background,
      bg = beautiful.colors.background.hue_500,
      fg = beautiful.colors.white,
      {
        widget = wibox.container.margin,
        top = beautiful.popup_padding_y * 0.75,
        bottom = beautiful.popup_padding_y * 0.75,
        left = beautiful.popup_padding_left,
        right = beautiful.popup_padding_right,
        {
          widget = wibox.widget.textbox,
          text = title,
        }
      }    
    }
  end

  local container = wibox.widget {
    widget = wibox.container.margin,
    top = beautiful.popup_padding_y,
    bottom = beautiful.popup_padding_y,
    left = x_padding,
    right = x_padding,
    content
  }

  return awful.popup {
    visible = false,
    ontop = true,
    offset = beautiful.wibar_popup_offset,
    preferred_anchors = { "middle" },
    border_width = 1,
    border_color = beautiful.colors.background.hue_600,
    widget = wibox.widget {
      layout = wibox.layout.fixed.vertical,
      heading,
      container,
    }
  }
end

return widget