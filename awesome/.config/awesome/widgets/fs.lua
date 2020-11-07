local popup_template = require("widgets.popup")

local function widget()
  -- Bar widget
  local container = wibox.container.background()
  
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

  local function fs_bar(mount_point, free, usage, type, total)
    local function fs_icon(mount_point)
      if mount_point:match("^/$") then return ""
      elseif mount_point:match("games") then return ""
      elseif mount_point:match("home") then return ""
      elseif mount_point:match("ntfs") then return ""
      end
    end
    
    local icon = wibox.widget {
      widget = wibox.widget.textbox,
      text = fs_icon(mount_point),
      font = helpers.icon_font(20, "light"),
      align = "center",
      forced_width = 34
    }

    local name = wibox.widget {
      widget = wibox.widget.textbox,
      text = mount_point,
    }

    local bar_width = 150
    local bar = wibox.widget {
      widget = wibox.widget.progressbar,
      value = tonumber(usage:sub(1, -2)),
      max_value = 100,
      forced_height = 14,
      forced_width = bar_width
    }

    local free_space = wibox.widget {
      widget = wibox.container.background,
      fg = beautiful.fg_darker,
      {
        widget = wibox.widget.textbox,
        forced_width = bar_width,
        text = free .. " free of " .. total,
        font = helpers.font(nil, beautiful.font_size - 1)
      }     
    }

    return wibox.widget {
      widget = wibox.container.margin(),
      top = beautiful.popup_line_margin * 1.25,
      bottom = beautiful.popup_line_margin * 1.25,
      left = beautiful.popup_padding_x,
      right = beautiful.popup_padding_x,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.wibar_popup_spacer * 0.75,
        icon,
        {
          layout = wibox.layout.fixed.vertical,
          spacing = beautiful.wibar_popup_spacer * 0.25,
          name,
          bar,
          free_space
        }       
      }
    }
  end

  local function popup_update()
    awful.spawn.easy_async([[ bash -c "df -hT" ]], function(stdout)
      popup_content:reset()
      local lines = helpers.split_str(stdout, "\n")
      for i, line in pairs(lines) do
        if line:match(".*/dev/sd.*") then
          local data = helpers.split_str(line, "%s")
          popup_content:add(fs_bar(data[7], data[5], data[6], data[2], data[3]))
        end
      end
    end)
  end

  local update_timer = gears.timer {
    timeout = 10,
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