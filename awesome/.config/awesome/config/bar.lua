-- Widgets
local layout_box = require("widgets.layout_box")
local tag_list = require("widgets.tag_list")
local clock = require("widgets.clock")
local launcher = require("widgets.launcher")
local volume = require("widgets.volume")
local fs = require("widgets.fs")
local mem = require("widgets.mem")
local gpu = require("widgets.gpu")
local cpu = require("widgets.cpu")
local date = require("widgets.date")
local weather = require("widgets.weather")

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    
  s.layout_box = layout_box(s)
  s.tag_list = tag_list(s)
  s.clock = clock()
  s.launcher = launcher()
  s.volume = volume()
  s.fs = fs()
  s.mem = mem()
  s.gpu = gpu()
  s.cpu = cpu()
  s.date = date()
  s.weather = weather()

  local separator = wibox.widget.separator()
  separator.orientation = "vertical"
  separator.span_ratio = 0.5
  separator.forced_width = beautiful.wibar_widget_margin * 2
  separator.color = beautiful.fg_inactive

  -- Create the wibox
  s.bar = awful.wibar({ position = "bottom", screen = s })

  -- Add widgets to the wibox
  local bar_left = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    s.launcher,
    separator,
    {
      s.tag_list,      
      layout = wibox.container.margin,
      left = beautiful.useless_gap * 0,
    },
  }

  local bar_centre = wibox.widget {
    layout = wibox.layout.align.horizontal,
  }

  local bar_right = wibox.container.background()
  bar_right.shape_clip = true
  bar_right.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    s.fs,
    s.mem,
    s.gpu,
    s.cpu,
    separator,
    s.volume,    
    s.layout_box,
    separator,
    s.weather,
    s.date,
    s.clock,
  }

  s.bar:setup {
    layout = wibox.container.margin,
    -- bottom = beautiful.useless_gap * 2,
    -- left = beautiful.useless_gap * 2, 
    -- right = beautiful.useless_gap * 2,
    {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      bar_left,
      bar_center,
      bar_right
    }
  }
end)