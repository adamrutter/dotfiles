-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard libraries
gears = require("gears")
awful = require("awful")
wibox = require("wibox")
beautiful = require("beautiful")
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")
dpi = xresources.apply_dpi

-- Helper functions
Color = require("shared.colors")
helpers = require("shared.helpers")
json = require("shared.json")

-- Errors
require("config.errors")

-- Variable definitions
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
modkey_2 = "Mod1"

-- Theme
local theme = "default"
local themes_dir = gears.filesystem.get_configuration_dir() .. "themes/"
theme_path = themes_dir .. theme
beautiful.init(theme_path .. "/theme.lua")

-- Signals
require("config.signals")

-- Bindings
require("config.bindings.mouse")
require("config.bindings.keyboard")

-- Layouts
require("config.layouts")

-- Window rules
require("config.rules")

-- Bar
require("config.bar")

-- Title bar
require("config.title_bar")

-- Tags
require("config.tags")

-- Client
require("config.client")