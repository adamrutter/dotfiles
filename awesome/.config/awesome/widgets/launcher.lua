-- Launcher button
local function launcher()
  local content = wibox.widget.textbox()
  content.forced_width = beautiful.wibar_base_height
  content.font = helpers.icon_font(17)  
  content.markup = ""
  content.align = "center"
  
  -- Put content in a container
  local container = wibox.container.background(content, nil, function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
  end)

  helpers.hot_reload_bg(container, "hue_800")
  
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
  
  return container
end

return launcher