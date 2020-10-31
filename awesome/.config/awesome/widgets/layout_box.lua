local popup_template = require("widgets.popup")

local function widget(s)
  
  local container = wibox.container.background()

  container:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc(1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end)
  ))

  
  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin
 
  local icon = awful.widget.layoutbox(s)
  beautiful.theme_assets.recolor_layout(beautiful, beautiful.icon_color)
  icon.forced_height = dpi(beautiful.icon_size + 4)
  icon.forced_width = dpi(beautiful.icon_size + 4)

  local align_icon = wibox.widget {
    layout = wibox.layout.align.vertical,
    nil,
    icon,
    nil,
    expand = "outside"
  }

  local text = wibox.widget.textbox()
 
  -- Update widget text on layout change
  tag.connect_signal("property::layout", function()
    text.text = beautiful.layout_name[awful.layout.getname(awful.layout.get(s))]
  end)
  
  -- Update widget text on tag change
  screen[s]:connect_signal("tag::history::update", function()
    text.text = beautiful.layout_name[awful.layout.getname(awful.layout.get(s))]
  end)

  container.widget = content
  content.widget = wibox.widget {
    align_icon,
    text,
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.wibar_widget_icon_margin
  }

  -- Popup
  local popup_content = wibox.layout.fixed.vertical() 
  local popup = popup_template(popup_content)

  for key, value in pairs(awful.layout.layouts) do
    local line = wibox.widget {
      widget = wibox.container.background,
      {
        widget = wibox.container.margin,
        top = beautiful.popup_line_margin,
        bottom = beautiful.popup_line_margin,
        left = beautiful.popup_padding_left,
        right = beautiful.popup_padding_right,
        {
          widget = wibox.widget.textbox,
          text = beautiful.layout_name[value.name]
        }   
      }       
    }

    -- Highlight current layout
    awesome.connect_signal("layout_changed", function()
      if (value.name == awful.layout.get(s).name) then
        line.bg = beautiful.accent.hue_500
        line.fg = beautiful.colors.white
      else
        line.bg = nil
        line.fg = nil
      end
    end)

    popup_content:add(line)
  end

  helpers.toggle_popup(popup, container, 5)

  return container
end

return widget
