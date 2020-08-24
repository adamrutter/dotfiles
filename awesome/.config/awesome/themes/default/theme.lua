local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local colors = require("themes.default.colors")
local beautiful = require("beautiful")

local theme = { }

-- Load GTK
theme.gtk = beautiful.gtk.get_theme_variables()

-- Colors
theme.colors = colors
-- Theme accent is stored externally so it can be used across various software,
-- we need a way to read it on startup so Awesome is themed consistently with
-- the rest of the system. io.popen() is used as this needs to be blocking
theme.accent = colors[io.popen("cat ~/.theme_accent_name"):read()]

theme.bg_normal = theme.gtk.bg_color
theme.bg_focus = theme.bg_normal
theme.bg_urgent = theme.colors.red
theme.bg_minimize = "#ff00ff"
theme.bg_systray = theme.bg_normal

theme.fg_normal = colors.grey.hue_600
theme.fg_focus = colors.grey.hue_100
theme.fg_urgent = colors.white
theme.fg_minimize = colors.white

-- Fonts
theme.font = "mono"
theme.icon_font = "font awesome 5 pro"

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
theme.wibar_padding = dpi(16)
theme.wibar_base_height = dpi(34)
theme.wibar_height = theme.wibar_base_height + theme.useless_gap * 2
theme.wibar_fg = colors.white
theme.wibar_bg = "#00000000"

-- Taglist
theme.taglist_bg_focus = colors.color10
theme.taglist_fg_focus = colors.white
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_text_urgent = {"", "", "", "", "", "", "", "", "", }
theme.taglist_text_empty = {"", "", "", "", "", "", "", "", "", }
theme.taglist_text_occupied = {"", "", "", "", "", "", "", "", "", }
theme.taglist_text_focused = {"", "", "", "", "", "", "", "", "", }

-- Menus
theme.menu_submenu_icon = theme_path .. "/icons/menu/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

--- Titlebar
theme.titlebar_height = dpi(28)
theme.titlebar_close_button = ""

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
	tileleft   = "Tile (Left)",
	tile = "Tile",
	tiletop = "Tile (Top)",
	spiral  = "Spiral",
	dwindle = "Dwindle",
	cornernw = "Corner (NW)",
	cornerne = "Corner (NE)",
	cornersw = "Corner (SW)",
	cornerse = "Corner (SE)",
}

return theme