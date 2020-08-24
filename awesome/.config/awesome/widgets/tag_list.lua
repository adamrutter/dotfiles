local font_size = 12

-- Individual tag icon
local function tag_item(icon)
  return wibox.widget {
    widget = wibox.widget.textbox,
    font = helpers.icon_font(font_size),
    forced_width = beautiful.wibar_base_height,
    align = "center",
    text = icon
  }
end

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
  local bg_normal = beautiful.bg_normal 
  local bg_active = beautiful.accent.hue_700
  -- Current tag
  if tag.selected then
    item.bg = bg_active
    item.fg = helpers.calculate_fg(bg_active)
    item.widget = tag_item(beautiful.taglist_text_focused[index])
    item.widget.font = helpers.icon_font(font_size, "solid")
  -- Urgent tag
  elseif tag.urgent then
    item.bg = beautiful.bg_urgent
    item.fg = beautiful.colors.white
    item.widget = tag_item(beautiful.taglist_text_urgent[index])
  -- Occupied tag
  elseif #tag:clients() > 0 then
    item.bg = bg_normal
    item.fg = beautiful.colors.white
    item.widget = tag_item(beautiful.taglist_text_occupied[index])
  -- Empty tag
  else
    item.bg = bg_normal
    item.fg = beautiful.colors.grey.hue_700
    item.widget = tag_item(beautiful.taglist_text_empty[index])
    item.widget.font = helpers.icon_font(nil, "light")
  end  
end

local function widget(s)
  local mouse_bindings = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end)
  )

  local tag_list = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    widget_template = {
      widget = wibox.widget.textbox,
      layout = wibox.container.background,
      create_callback = function(self, tag, index, _) 
        update_taglist(self, tag, index)
      end,
      update_callback = function(self, tag, index, _)
        update_taglist(self, tag, index)
      end,
    },
    buttons = mouse_bindings
  }

  local container = wibox.container.background(tag_list, "#00000000", function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
  end)
  container.shape_clip = true

  -- Hack to get current tag indicator to hot reload
  -- Not proud, get rekt
  awesome.connect_signal("hot_reload::colors", function()
    awful.tag.viewnext(s)
    awful.tag.viewprev(s)
  end)

  return container
end

return widget