local popup_template = require("widgets.popup")

-- Display the date
local function widget()
  local container = wibox.container.background()

  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin

  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font()
  icon_content.text = ""
  icon.widget = icon_content
  -- Stop icon getting clipped
  icon_content.forced_width = icon_content:get_preferred_size() + 1

  -- Init clock/calendar
  local date = wibox.widget.textclock("%A, %-d %b")
  local function decorate_cal(widget, flag, date)
    local style = beautiful["calendar_" .. flag .. "_style"] or {}

    if style.markup and widget.get_text and widget.set_markup then
      widget:set_markup(style.markup(widget:get_text()))
    end

    -- Return the weekend bg color if current day is weekend, and cell is either
    -- a heading or a day (currently focused day is specific cell type)
    local function weekend_bg_color()
      local this_day = tonumber(os.date('%w', os.time({
        year = date.year, 
        month = date.month or 1, 
        day = date.day or 1
      })))

      if (this_day == 0 and flag == "normal") then return beautiful.calendar_weekend_bg
      elseif (this_day == 0 and flag == "weekday") then return beautiful.calendar_weekend_bg
      elseif (this_day == 6 and flag == "normal") then return beautiful.calendar_weekend_bg
      elseif (this_day == 6 and flag == "weekday") then return beautiful.calendar_weekend_bg
      end
    end
    
    return wibox.widget {
      {
        widget,
        widget = wibox.container.margin,
        margins = beautiful.font_size * 0.4
      },
      widget = wibox.container.background,
      bg = style.bg or weekend_bg_color() or nil,
      fg = style.fg,
      border_width = style.border_width,
      border_color = style.border_color
    }
  end

  local function cal() 
    return wibox.widget {
      date = os.date('*t'),
      widget = wibox.widget.calendar.month,
      fn_embed = decorate_cal,
    }
  end

  -- Spawn calendar popup
  local popup = popup_template()
  container:connect_signal("mouse::enter", function()
    popup.widget = wibox.widget {
      layout = wibox.container.margin,
      margins = beautiful.font_size * 0.5,
      { 
        widget = cal()
      }
    }
    popup:move_next_to(mouse.current_widget_geometries[5])
    popup.visible = true
  end)
  container:connect_signal("mouse::leave", function()
    popup.visible = false
  end)

  -- Construct widget
  container.widget = content
  content.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    icon,
    date,
    spacing = beautiful.wibar_widget_icon_margin
  }

  return container
end

return widget