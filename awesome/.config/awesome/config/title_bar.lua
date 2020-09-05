-- Nice config
-- https://github.com/mut-ex/awesome-wm-nice

local nice = require("modules.nice")

nice {
  titlebar_items = {
    left = { nil },
    right = { "ontop", "maximize", "close" }
  },
  ontop_color = beautiful.accent.hue_400,
  maximize_color = beautiful.accent.hue_500,
  close_color = beautiful.accent.hue_700,
  titlebar_height = 32,
  button_size = 14
}
