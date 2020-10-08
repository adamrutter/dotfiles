local popup_template = require("widgets.popup")

-- Display the date
local function widget()
  local container = wibox.container.background()
  local bg = beautiful.accent.hue_800
  -- container.bg = bg
  container.fg = helpers.calculate_fg(bg)

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

    -- Change background color for weekends
    local d = {
      year = date.year, 
      month = date.month or 1, 
      day = date.day or 1
    }
    local weekday = tonumber(os.date('%w', os.time(d)))
    local weekend_bg = (weekday==0 or weekday==6) and beautiful.calendar_weekend_bg
    
    return wibox.widget {
      {
        widget,
        widget  = wibox.container.margin,
        margins = beautiful.wibar_popup_spacer * 0.4
      },
      widget = wibox.container.background,
      bg = style.bg or weekend_bg,
      fg = style.fg,
      border_width = style.border_width,
      border_color = style.border_color
    }
  end

  local cal = wibox.widget {
    date     = os.date('*t'),
    widget   = wibox.widget.calendar.month,
    fn_embed = decorate_cal,
  }

  -- Spawn calendar popup
  local popup = popup_template(cal)
  container:connect_signal("mouse::enter", function()
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