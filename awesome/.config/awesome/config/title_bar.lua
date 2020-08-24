-- Helper function to create a custom control button
local function custom_button(variant, c)
  -- Restrict size of the whole button
  local container = wibox.container.margin()
  container.top = 5
  container.bottom = 5
  -- Give the button shape/intial colour
  local control = wibox.container.background()
  control.shape = gears.shape.circle  
  -- Pad the inside of the button to make the background larger
  local padding = wibox.container.margin()
  padding.margins = 4 
  -- Load initial icon
  local icon = wibox.widget.textbox()
  icon.text = beautiful["titlebar_" .. variant .. "_button"]
  icon.font = helpers.icon_font(10, "solid")
  icon.align = "left"    

  -- Listen for client gaining focus so button can be styled/logic implemented
  local function style_client_control()
    control.fg = beautiful.fg_normal
    -- Mouse enters control
    control:connect_signal("mouse::enter", function()
      helpers.hot_reload_bg(control, "hue_500")
    end)   
    -- Button down on control
    control:connect_signal("button::press", function()
      helpers.hot_reload_bg(control, "hue_700", true)
      icon.opacity = 0.6
    end)   
    -- Button up on control
    control:connect_signal("button::release", function(self, lx, ly, button)
      helpers.hot_reload_bg(control, "hue_500")
      if (button == 1) then
        c:kill()
      end
    end)   
    -- Mouse leaves control
    control:connect_signal("mouse::leave", function()
      control.fg = beautiful.fg_normal
      control.bg = "#00000000"
      icon.opacity = 1 -- Reset for possible button down and leave
    end)
  end 
  c:connect_signal("focus", style_client_control)
  
  -- Listen for client losing focus so listener can be removed
  c:connect_signal("unfocus", function()
    c:disconnect_signal("focus", style_client_control)
  end)

  -- Construct button
  container.widget = control
  control.widget = padding
  padding.widget = icon

  return container
end

client.connect_signal("request::titlebars", function(c)
  -- Bindings for the titlebar
  local mouse_bindings = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  -- Client name widget
  local client_name = awful.titlebar.widget.titlewidget(c)
  client_name.font = helpers.font("sans-serif", "10")

  -- This is essentially the title bar, and will be put inside a proper 
  -- (invisible) title bar widget below. This means corners can be anti-aliased
  local bar_content = wibox.container.background(
    wibox.widget {
      layout = wibox.container.background,
      {
        layout = wibox.container.margin,
        left = beautiful.titlebar_height * 0.33,
        right = beautiful.titlebar_height * 0.2,
        {
          layout = wibox.layout.align.horizontal,
          {
            layout = wibox.layout.fixed.horizontal,
            buttons = mouse_bindings,
          },
          {
            layout = wibox.layout.fixed.horizontal,
            buttons = mouse_bindings,
            client_name,
          },
          {
            layout = wibox.layout.fixed.horizontal,
            custom_button("close", c)
          },
        }
      }
    }, 
    beautiful.bg_normal, 
    function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, beautiful.border_radius)
    end
  )

  -- Because title bar colour is now controlled by the container above, focus 
  -- behaviour needs to be re-implemented on that container
  c:connect_signal("focus", function()
    bar_content.bg = beautiful.bg_focus
    client_name.font = helpers.font("sans-serif", "10", "bold")
  end)

  c:connect_signal("unfocus", function()
    bar_content.bg = beautiful.bg_normal
    client_name.font = helpers.font("sans-serif", "10")
  end)
    
  -- Finally, spawn the proper title bar using the above container as its widget  
  local title_bar = awful.titlebar(c, {
    size = beautiful.titlebar_height,
    -- Transparent background for anti-aliasing (real background controlled above)
    bg_normal = "#00000000",
    bg_focus = "#00000000"
  })
  title_bar:setup {
    layout = wibox.container.margin,
    bar_content
  }
end)