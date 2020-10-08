local popup_template = require("widgets.popup")

local function widget()
  -- Bar widget
  local container = wibox.container.background()
  local bg = beautiful.accent.hue_500
  
  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin
  
  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font()
  icon_content.text = ""
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1
  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  icon.widget = icon_content
  
  local get_fs_usage = [[ bash -c "df -h 2>/dev/null | awk '/\/home/{print $5}'" ]]
  local value = awful.widget.watch(get_fs_usage, 5, function(widget, stdout)
    widget:set_text(stdout:match("%g*"))
  end)

  -- Popup
  local popup_content = wibox.layout.fixed.vertical() 
  local popup = popup_template(popup_content)

  local function fs_bar(mount_point, free, usage, type)   
    local icon = wibox.widget.textbox()
    icon.font = helpers.icon_font()
    icon.text = ""
    icon.align = "center"
    icon.forced_width = 20
    local icon_container = wibox.container.background()
    icon_container.fg = beautiful.icon_color
    icon_container.widget = icon
    -- Add custom icons for specific mount points
    if mount_point:match("^/$") then icon.text = ""
    elseif mount_point:match("games") then icon.text = ""
    elseif mount_point:match("home") then icon.text = ""
    elseif mount_point:match("ntfs") then icon.text = ""
    end

    local name = wibox.widget.textbox()
    name.forced_width = 100
    name.text = mount_point

    local bar = wibox.widget.progressbar()
    local bar_width = 150
    bar.value = tonumber(usage:sub(1, -2))
    bar.max_value = 100
    bar.forced_height = 20
    bar.forced_width = bar_width

    local free_space = wibox.widget.textbox()
    free_space.forced_width = bar_width
    free_space.text = free .. " free"
    free_space.align = "center"
    free_space.font = helpers.font(nil, beautiful.font_size - 2)

    local free_space_container = wibox.container.background()
    free_space_container.fg = helpers.calculate_fg(beautiful.bg_normal)
    free_space_container.widget = free_space

    local bar_container = wibox.widget {
      layout = wibox.layout.stack,
      bar,
      free_space_container
    }

    local container = wibox.container.margin()
    container.margins = beautiful.wibar_popup_spacer * 0.5
    container.widget = {
      layout = wibox.layout.fixed.horizontal,
      spacing = beautiful.wibar_popup_spacer,
      icon_container,
      name,
      bar_container
    }

    return container
  end

  local function popup_update()
    awful.spawn.easy_async([[ bash -c "df -hT" ]], function(stdout)
      popup_content:reset()
      local lines = helpers.split_str(stdout, "\n")
      for i, line in pairs(lines) do
        if line:match(".*/dev/sd.*") then
          local data = helpers.split_str(line, "%s")
          popup_content:add(fs_bar(data[7], data[5], data[6], data[2]))
        end
      end
    end)
  end

  local update_timer = gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = popup_update
  }

  -- Show popup
  container:connect_signal("mouse::enter", function()
    -- Move popup to bar widget's container
    popup:move_next_to(mouse.current_widget_geometries[5])
    popup.visible = true
  end)
  container:connect_signal("mouse::leave", function()
    popup.visible = false
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