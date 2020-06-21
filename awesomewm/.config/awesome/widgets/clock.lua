local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

local textclock = wibox.widget {
  format = '<span font="Iosevka 25">%H:%M</span><span font="Iosevka 15"> %b %d</span>',
  refresh = 60,
  timezone = "Europe/Berlin",
  widget = wibox.widget.textclock,
}

return textclock
