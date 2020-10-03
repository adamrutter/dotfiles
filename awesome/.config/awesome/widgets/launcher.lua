-- Launcher button
local function launcher()
  local content = wibox.widget.textbox()
  content.forced_width = beautiful.wibar_base_height
  content.font = helpers.icon_font(14)  
  content.markup = ""
  content.align = "center"
  
  local container = wibox.container.background()
  local bg = beautiful.accent.hue_800
  container.fg = beautiful.icon_color
  
  container:connect_signal("mouse::enter", function(self)
    -- container.bg = "#ff0000"
    -- content.text = "!"
  end)

  container:connect_signal("mouse::leave", function(self)
    -- container.bg = "#ff0000"
    -- content.text = "#"
  end)

  container:connect_signal("button::press", function(self)
    -- container.bg = "#ff0000"
    -- content.text = "#"
  end)

  container:connect_signal("button::release", function(self, lx, ly, button)
    -- container.bg = "#ff0000"
    -- content.text = "#"
    if (button == 1) then
      awful.spawn("/home/adam/.config/rofi/menu/launch.sh")
    end
  end)

  local padding = wibox.container.margin()
  padding.left = beautiful.wibar_padding * 0.25
  padding.right = beautiful.wibar_padding * 0.25

  -- Construct widget
  padding.widget = content
  container.widget = padding
  
  return container
end

return launcher