local font_size = 14

-- Individual tag icon
local function tag_item(icon)
  return wibox.widget {
    widget = wibox.widget.textbox,
    font = helpers.font("material design icons", font_size),
    forced_width = beautiful.wibar_base_height,
    align = "center",
    text = icon
  }
end

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
  local icon_parent = item:get_children_by_id("icon_parent")[1]
  local bg_normal = beautiful.colors.background.hue_500
  local bg_active = beautiful.icon_color
  -- Current tag
  if tag.selected then
    item.fg = beautiful.icon_color
    icon_parent.widget = tag_item(beautiful.taglist_text_focused[index])
  -- Urgent tag
  elseif tag.urgent then
    item.fg = beautiful.colors.white
    icon_parent.widget = tag_item(beautiful.taglist_text_urgent[index])
  -- Occupied tag
  elseif #tag:clients() > 0 then
    item.fg = beautiful.colors.foreground.hue_500
    icon_parent.widget = tag_item(beautiful.taglist_text_occupied[index])
  -- Empty tag
  else
    item.fg = beautiful.fg_inactive
    icon_parent.widget = tag_item(beautiful.taglist_text_empty[index])
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
      widget = wibox.container.background,
      id = "background",
      {
        widget = wibox.container.margin,
        left = beautiful.wibar_padding * 0.125,
        right = beautiful.wibar_padding * 0.125,
        id = "icon_parent"
      },
      create_callback = function(self, tag, index, _)
        update_taglist(self, tag, index)
      end,
      update_callback = function(self, tag, index, _)
        update_taglist(self, tag, index)
      end,
    },
    buttons = mouse_bindings
  }

  local container = wibox.container.margin(tag_list)
  container.left = beautiful.wibar_padding * 0
  container.shape_clip = true

  return container
end

return widget