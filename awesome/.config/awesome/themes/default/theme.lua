local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local colors = require("themes.default.colors")
local beautiful = require("beautiful")
dpi = xresources.apply_dpi

local theme = { }

-- Load GTK
theme.gtk = beautiful.gtk.get_theme_variables()

-- Colors
theme.colors = colors
theme.accent = colors.color5
theme.icon_color = theme.accent.hue_400

theme.bg_normal = theme.colors.background.hue_400
theme.bg_focus = theme.bg_normal
theme.bg_urgent = theme.colors.red
theme.bg_minimize = "#ff00ff"
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.colors.foreground.hue_500
theme.fg_focus = colors.grey.hue_100
theme.fg_urgent = colors.white
theme.fg_minimize = colors.white
theme.fg_inactive = tostring(Color.new(theme.colors.background.hue_500):lighten_to(0.4))
theme.fg_darker = tostring(Color.new(theme.colors.background.hue_500):lighten_to(0.8))

theme.border_color = theme.colors.background.hue_600

-- Fonts
theme.font_name = "ubuntu"
theme.font_size = "10"
theme.font = theme.font_name .. " " .. " " .. theme.font_size
theme.icon_font = "font awesome 5 pro"
theme.icon_size = "11"

-- Icon theme
theme.icon_theme = nil

-- Borders
theme.useless_gap = dpi(7)
theme.border_width = dpi(0)
theme.border_color_normal = "#ffff00"
theme.border_color_active = "#ff0000"
theme.border_color_marked = "#91231c"
theme.border_radius = dpi(5)
theme.border_normal = "#00ff00"
theme.border_focus = "#00ff00"

-- Bar
theme.wibar_spacer = theme.font_size * 1.75
theme.wibar_base_height = dpi(34)
theme.wibar_height = theme.wibar_base_height + theme.useless_gap * 0
theme.wibar_fg = colors.fg_normal
theme.wibar_bg = theme.colors.background.hue_500

theme.wibar_widget_margin = theme.wibar_spacer * 0.75
theme.wibar_widget_icon_margin = theme.wibar_spacer * 0.5


-- Taglist
theme.taglist_bg_focus = colors.color10
theme.taglist_fg_focus = colors.white
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_text_urgent = {"󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳", "󰎶", "󰎹", "󰎼", }
theme.taglist_text_empty = {"󰎦", "󰎩", "󰎬", "󰎮", "󰎰", "󰎵", "󰎸", "󰎻", "󰎾", }
theme.taglist_text_occupied = {"󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳", "󰎶", "󰎹", "󰎼", }
theme.taglist_text_focused = {"󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳", "󰎶", "󰎹", "󰎼", }

-- Menus
theme.menu_submenu_icon = theme_path .. "/icons/menu/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- Layouts
theme.layout_fairh = theme_path .. "/icons/layouts/fairh.png"
theme.layout_fairv = theme_path .. "/icons/layouts/fairv.png"
theme.layout_floating = theme_path .. "/icons/layouts/floating.png"
theme.layout_magnifier = theme_path .. "/icons/layouts/magnifier.png"
theme.layout_max = theme_path .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme_path .. "/icons/layouts/fullscreen.png"
theme.layout_tilebottom = theme_path .. "/icons/layouts/tilebottom.png"
theme.layout_tileleft = theme_path .. "/icons/layouts/tileleft.png"
theme.layout_tile = theme_path .. "/icons/layouts/tile.png"
theme.layout_tiletop = theme_path .. "/icons/layouts/tiletop.png"
theme.layout_spiral = theme_path .. "/icons/layouts/spiral.png"
theme.layout_dwindle = theme_path .. "/icons/layouts/dwindle.png"
theme.layout_cornernw = theme_path .. "/icons/layouts/cornernw.png"
theme.layout_cornerne = theme_path .. "/icons/layouts/cornerne.png"
theme.layout_cornersw = theme_path .. "/icons/layouts/cornersw.png"
theme.layout_cornerse = theme_path .. "/icons/layouts/cornerse.png"

theme.layout_name = {
	fairh = "Fair (H)",
	fairv = "Fair (V)",
	floating = "Floating",
	magnifier = "Magnified",
	max = "Max",
	fullscreen = "Fullscreen",
	tilebottom = "Tile (Bottom)",
	tileleft = "Tile (Left)",
	tile = "Tile",
	tiletop = "Tile (Top)",
	spiral  = "Spiral",
	dwindle = "Dwindle",
	cornernw = "Corner (NW)",
	cornerne = "Corner (NE)",
	cornersw = "Corner (SW)",
	cornerse = "Corner (SE)",
}

-- Progress bars
theme.progressbar_bg = theme.colors.background.hue_500
theme.progressbar_fg = theme.icon_color
theme.progressbar_paddings = 0
theme.progressbar_border_width = 1
theme.progressbar_border_color = theme.border_color
theme.progressbar_shape = gears.shape.rounded_bar
theme.progressbar_bar_shape = gears.shape.rounded_bar

-- Popups
theme.wibar_popup_offset = theme.useless_gap * -1
theme.wibar_popup_spacer = theme.wibar_spacer
theme.popup_line_margin = theme.wibar_popup_spacer * 0.4
theme.popup_padding_x = theme.wibar_popup_spacer * 0.75
theme.popup_padding_y = theme.wibar_popup_spacer * 0.9

-- Calendar
theme.calendar_font = helpers.font(theme.font, theme.font_size)
theme.calendar_spacing = theme.wibar_popup_spacer * 0
theme.calendar_weekend_bg = theme.colors.background.hue_600
theme.calendar_focus_style = {
	bg = theme.icon_color,
	fg = theme.colors.white
}
theme.calendar_weekday_style = {
	fg = theme.accent.hue_300,
	markup = function(t) return '<b>' .. t .. '</b>' end,
}

-- Notifications
theme.notification_margin = dpi(10)
theme.notification_border_width = 1
theme.notification_border_color = theme.border_color
theme.notification_spacing = theme.useless_gap
theme.notification_width = dpi(350)
theme.notification_padding = dpi(15)
theme.notification_icon_bg = {
	["low"] = theme.colors.background.hue_600,
	["normal"] = theme.colors.background.hue_600,
	["critical"] = "darkred"
}
theme.notification_message_fg = theme.fg_darker
theme.notification_title_font = helpers.font(theme.font, theme.font_size + 1)
theme.notification_title_margin_bottom = theme.font_size * 0.25
theme.notification_max_height = dpi(250)

-- Titlebar
theme.titlebar_fg = theme.colors.white

return theme
