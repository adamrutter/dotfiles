local helpers = {}

-- Increase/decrease a color's perceived brightness using hue
-- More info on perceived brightness here 
-- (http://www.workwithcolor.com/color-luminance-2233.htm) or in Refactoring UI 
-- by Steve Schoger and Adam Wathan
function helpers.adjust_hue(hex, direction, amount)
  local hex = Color.new(hex)
  local hue = hex.H

  -- Darken the given color
  if (direction == "darker") then
    -- Calculate nearest dark hue
    local dark_hue = 0
    if (hue >= 0 and hue < 60 or hue >= 300) then dark_hue = 0
    elseif (hue >= 60 and hue < 180) then dark_hue = 120
    elseif (hue >= 180 and hue < 330) then dark_hue = 240
    end
    -- Calculate whether we need to increase/decrease hue value and return the
    -- new color
    if (hue < dark_hue) then
      return tostring(hex:hue_offset(amount))
    else
      return tostring(hex:hue_offset(-amount))
    end

  -- Brighten the given color
  elseif (direction == "brighter") then
    -- Calculate nearest bright hue
    local bright_hue = 0
    if (hue >= 0 and hue < 120) then bright_hue = 60
    elseif (hue >= 120 and hue < 240) then bright_hue = 180
    elseif (hue >= 240 and hue < 360) then bright_hue = 300
    end
    -- Calculate whether we need to increase/decrease hue value and return the
    -- new color
    if (hue < bright_hue) then
      return tostring(hex:hue_offset(amount))
    else
      return tostring(hex:hue_offset(-amount))
    end
  end
end

-- Calculate whether black or white is the best foreground for the given background
-- color. Taken from the Javascript algorithm below and rewritten in Lua
-- https://stackoverflow.com/a/35970186
function helpers.calculate_fg(hex)
  -- Remove leading hash
  local hex = hex:sub(2)
  -- Convert 3 digits to 6 digits
  if (hex:len() == 3) then
    hex = hex:sub(1,1) .. hex:sub(1,1) .. hex:sub(2,2) .. hex:sub(2,2) .. hex:sub(3,3) .. hex:sub(3,3)
  end
  -- Convert to RGB
  local red = tonumber("0x"..hex:sub(1,2))
  local green = tonumber("0x"..hex:sub(3,4))
  local blue = tonumber("0x"..hex:sub(5,6))
  -- Calculate/return the best foreground colour
  -- http://stackoverflow.com/a/3943023/112731
  return (red * 0.299 + green * 0.587 + blue * 0.114) > 186 and beautiful.colors.black or beautiful.colors.white
end

-- Print a table to the console
-- https://stackoverflow.com/a/27028488
function helpers.print_table(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. helpers.print_table(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

-- Notification boilerplate for debugging
function helpers.pop(text)
  naughty.notify({
    preset = naughty.config.presets.critical,
    text = text
  })
end

-- Generate tints/shades for each Xresources color
-- Depends on: https://github.com/adamrutter/lua-colors/tree/bugfix
function helpers.set_xresources_colors(colors)
  local xresources = require("beautiful.xresources").get_current_theme()
  for key, value in pairs(xresources) do
    -- We want to be able to hot reload these colors (if Xresources changes), 
    -- but Awesome only queries Xresources on startup. To resolve this, we're 
    -- going to manually grep for each key in the actual Xresources file, and 
    -- return the current value. io.popen() is used rather than an awful.spawn
    -- method as we NEED this to be blocking; if the startup process continues
    -- asynchronously before this is complete, it will fail because there won't
    -- be any colors yet!
    local xres_value = io.popen("grep -oP '(?<=\\*\\."..key..":)\\s*(#[[:xdigit:]]{6})' ~/.Xresources | tr -d '[:space:]'")
    local color = Color.new(xres_value:read())
    colors[key] = {
      hue_100 = helpers.adjust_hue(tostring(color:lighten_by(1.5):desaturate_by(1.5)), "brighter", 14),
      hue_200 = helpers.adjust_hue(tostring(color:lighten_by(1.375):desaturate_by(1.375)), "brighter", 12),
      hue_300 = helpers.adjust_hue(tostring(color:lighten_by(1.25):desaturate_by(1.25)), "brighter", 8),
      hue_400 = helpers.adjust_hue(tostring(color:lighten_by(1.125):desaturate_by(1.125)), "brighter", 4),
      hue_500 = tostring(color),
      hue_600 = helpers.adjust_hue(tostring(color:lighten_by(0.875):desaturate_by(1.125)), "darker", 4),
      hue_700 = helpers.adjust_hue(tostring(color:lighten_by(0.75):desaturate_by(1.25)), "darker", 8),
      hue_800 = helpers.adjust_hue(tostring(color:lighten_by(0.625):desaturate_by(1.375)), "darker", 12),
      hue_900 = helpers.adjust_hue(tostring(color:lighten_by(0.5):desaturate_by(1.5)), "darker", 16),
    }
  end
end

function helpers.font(font, size, style)
  local font = font or beautiful.font_name
  local size = size or beautiful.font_size
  local style = style or "regular"
  return tostring(font .. " " .. style .. " " .. size)
end

function helpers.icon_font(size, style) 
	local font = beautiful.icon_font
	local size = size or beautiful.icon_size
	local style = style or "regular"
	return tostring(font  .. " " .. style .. " " .. size)
end

function helpers.round(num)
  local num = tonumber(num)
  return num >=0 and math.floor(num + 0.5) or math.ceil(num - 0.5)
end

-- Split string
-- https://stackoverflow.com/a/7615129
function helpers.split_str(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

-- Show/hide a popup
function helpers.toggle_popup(popup, parent, parent_depth)
  parent:connect_signal("mouse::enter", function()
    awful.placement.next_to(popup, {
      preferred_anchors = "middle",
      geometry = mouse.current_widget_geometries[parent_depth],
      offset = { y = beautiful.wibar_popup_offset}
    })
    popup.visible = true
  end)
  parent:connect_signal("mouse::leave", function()
    popup.visible = false
  end)
end

return helpers