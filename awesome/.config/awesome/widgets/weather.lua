local popup_template = require("widgets.popup")

-- Display the current weather
local function widget()
  -- Command to fetch API data
  local forecast_api = [[bash -c "while true; do
      echo $(curl -s https://api.openweathermap.org/data/2.5/onecall?lat=50.8376\&lon=0.7749\&appid=$OPEN_WEATHER_MAP_API_KEY\&units=metric)
      sleep 200
    done"
  ]]

  local icon_map = {
    ["01d"] = "",
    ["01n"] = "",
    ["02d"] = "",
    ["02n"] = "",
    ["03d"] = "",
    ["03n"] = "",
    ["04d"] = "",
    ["04n"] = "",
    ["09d"] = "",
    ["09n"] = "",
    ["10d"] = "",
    ["10n"] = "",
    ["11d"] = "",
    ["11n"] = "",
    ["13d"] = "",
    ["13n"] = "",
    ["50d"] = "",
    ["50n"] = "",
  }

  -- Construct widget
  local container = wibox.container.background()

  local content = wibox.container.margin()
  content.left = beautiful.wibar_widget_margin
  content.right = beautiful.wibar_widget_margin

  local icon_content = wibox.widget.textbox()
  icon_content.font = helpers.icon_font()

  local icon = wibox.widget.background()
  icon.fg = beautiful.icon_color
  icon.widget = icon_content

  local temp = wibox.widget.textbox()

  container.widget = content
  content.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    icon,
    temp,
    spacing = beautiful.wibar_widget_icon_margin
  }

   -- Init popup
   local popup_content = wibox.layout.fixed.horizontal() 
   local popup = popup_template(popup_content)

    -- Set icon/text
    get_forecast = awful.spawn.with_line_callback(forecast_api, {
      stdout = function(data)
        local forecast = json.decode(data)
        temp.text = helpers.round(forecast.current.temp) .. "°"
        icon_content.text = icon_map[forecast.current.weather[1].icon]
        -- Stop icon getting clipped
        icon_content.forced_width = icon_content:get_preferred_size() + 1

        -- Popup content
        popup_content:reset()
        local number_of_hours = 5
        for i = 1, number_of_hours do
          local time = wibox.widget {
            widget = wibox.container.margin,
            bottom = dpi(6),
            {
              widget = wibox.container.background,
              fg = beautiful.fg_darker,
              {
                widget = wibox.widget.textbox,
                text = os.date("%H:%M", forecast.hourly[i].dt),
                align = "center"
              }   
            }                             
          }
          
          local icon_and_temp = wibox.widget {
            layout = wibox.layout.fixed.vertical,
            spacing = beautiful.popup_line_margin * 0.75,
            {
              widget = wibox.widget.textbox,
              text = icon_map[forecast.hourly[i].weather[1].icon],
              font = helpers.icon_font(beautiful.icon_size + 12),
              align = "center"
            },
            {
              widget = wibox.widget.textbox,
              align = "center",
              font = helpers.font(nil, beautiful.font_size + 3),
              markup = "<b>"..helpers.round(forecast.hourly[i].temp) .. "°</b>",
            },                             
          }

          local wind = wibox.widget {
            widget = wibox.container.background,
            fg = beautiful.fg_darker,         
            {
              widget = wibox.widget.textbox,
              text = helpers.round(forecast.hourly[i].wind_speed) .. "mph",
              align = "center"
            }, 
          }

          local section = wibox.widget {                      
            widget = wibox.container.margin,
            left = beautiful.popup_padding_x * 0.33,
            right = beautiful.popup_padding_x * 0.33,
            {
              layout = wibox.layout.fixed.vertical,
              spacing = beautiful.popup_line_margin * 2,
              forced_width = beautiful.font_size * 5,
              time,
              icon_and_temp,
              wind
            }          
          }
          popup_content:add(section)
        end
      end
    })

  helpers.toggle_popup(popup, container, 5)

  return container
end

return widget