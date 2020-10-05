-- Display the current weather
local function widget()
  -- Command to fetch API data
  local forecast_api = [[bash -c "while true; do
      echo $(curl -s http://api.openweathermap.org/data/2.5/weather?q=chichester,gb\&appid=$OPEN_WEATHER_MAP_API_KEY\&units=metric)
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
  local bg = beautiful.accent.hue_800
  container.fg = helpers.calculate_fg(bg)

  local content = wibox.container.margin()
  content.left = beautiful.wibar_padding * 0.75
  content.right = beautiful.wibar_padding * 0.75

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
    spacing = beautiful.wibar_padding / 2
  }

  -- Set icon/text
  get_forecast = awful.spawn.with_line_callback(forecast_api, {
    stdout = function(data)
      local forecast = json.decode(data)
      temp.text = math.floor(forecast.main.temp+0.5) .. "°"
      icon_content.text = icon_map[forecast.weather[1].icon]
      -- Stop icon getting clipped
      icon_content.forced_width = icon_content:get_preferred_size() + 1
    end
  })

  return container
end

return widget