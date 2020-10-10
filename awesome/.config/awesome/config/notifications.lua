naughty.config.padding = beautiful.useless_gap
naughty.config.spacing = beautiful.notification_spacing

naughty.config.defaults.border_width = beautiful.notification_border_width
naughty.config.defaults.border_color = beautiful.notification_border_color
naughty.config.defaults.timeout = 10

naughty.config.presets.critical.bg = beautiful.notification_bg
naughty.config.presets.critical.fg = beautiful.notification_fg

naughty.connect_signal("request::display", function(notification)
  -- Play a notification sound
  awful.spawn("canberra-gtk-play -i message")

  local icon_default = ""
  local icon_map = {
    ["critical"] = "",
    ["Screenshot"] = ""
  }
  
  local icon = wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.notification_icon_bg[notification.urgency],
    {
      widget = wibox.container.margin,
      left = beautiful.notification_padding * 1,
      right = beautiful.notification_padding * 1,
      {
        widget = wibox.widget.textbox,
        text = icon_map[notification.title] or icon_map[notification.app_name] or icon_map[notification.urgency] or icon_default,
        font = beautiful.icon_font,
        forced_width = beautiful.icon_size * 1.5,
        align = "center"
      }
    }
  }

  local content = wibox.widget {
    widget = wibox.container.margin,
    margins = beautiful.notification_padding,
    {
      layout = wibox.layout.fixed.vertical,
      spacing = (notification.title:len() > 0) and beautiful.notification_title_margin_bottom or 0,
      {
        widget = wibox.widget.textbox,
        markup = "<b>"..notification.title.."</b>",
        font = beautiful.notification_title_font,
      },
      {
        widget = wibox.container.background,
        fg = beautiful.notification_message_fg,
        {
          widget = naughty.widget.message
        }
      }
    }
  }

  naughty.layout.box {
    notification = notification,
    widget_template = {
      widget = wibox.container.margin, 
      {
        widget = wibox.container.constraint,
        strategy = "exact",
        width = beautiful.notification_width,
        {
          widget = wibox.container.constraint,
          strategy = "max",
          height = beautiful.notification_max_height,
          {
            id = "background_role",
            widget = wibox.container.background,
            {
              layout = wibox.layout.fixed.horizontal,
              icon,
              content
            }
          }
        }
      }
    }
  }
end)
