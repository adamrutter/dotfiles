-- Helper function to return an icon based on given volume level
local function icon_text(vol)
  if vol == 0 then
    return ""
  elseif (vol > 0 and vol <= 25) then
    return ""
  elseif (vol > 25 and vol <= 50) then
    return ""
  elseif (vol > 50 and vol <= 75) then
    return ""
  elseif (vol > 75 and vol <= 100) then
    return ""
  end
end

-- Helper function to format the output from pamixer
local function format_vol(vol)
  return tonumber(vol:sub(1, -3)) or 0
end

-- Display/control volume
local function widget()

  -- Background colour
  local container = wibox.container.background()
  
  -- Content container with to pad inside of background container
  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin
  
  -- Create an icon textbox, and asynchronously set an icon as its inital text
  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font()
  awful.spawn.easy_async_with_shell("pamixer --get-volume-human", function(stdout) 
  icon_content.text = icon_text(format_vol(stdout)) 
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1
end)
icon.widget = icon_content

-- Create an value textbox, and asynchronously set a value as its intial text
local value = wibox.widget.textbox()
awful.spawn.easy_async_with_shell("pamixer --get-volume-human", function(stdout) 
value.text = format_vol(stdout) .. "%"
end)

-- Listen for a volume_changed signal, and update the icon/value
awesome.connect_signal("volume_changed", function(stdout)
  local vol = format_vol(stdout)   
  value.text = vol .. "%"
  icon_content.text = icon_text(vol)
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1
end)

-- Mouse bindings for the widget
container:buttons(gears.table.join(
    awful.button(nil, 1, function() awful.spawn.easy_async_with_shell(
      "pamixer --toggle-mute && pamixer --get-volume-human", 
      function(stdout)
        awesome.emit_signal("volume_changed", stdout)
      end) 
    end),
    awful.button(nil, 4, function() awful.spawn.easy_async_with_shell(
      "pamixer --increase 2 && pamixer --get-volume-human", 
      function(stdout)
        awesome.emit_signal("volume_changed", stdout)
      end) 
    end),
    awful.button(nil, 5, function() awful.spawn.easy_async_with_shell(
      "pamixer --decrease 2 && pamixer --get-volume-human", 
      function(stdout)
        awesome.emit_signal("volume_changed", stdout)
      end) 
    end)
  ))

  container.widget = content
  content.widget = wibox.widget {
    icon,
    value,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.wibar_widget_icon_margin
  }

  return container
end

return widget
