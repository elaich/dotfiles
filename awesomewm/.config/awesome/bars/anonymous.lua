local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Approved widgets
local textclock = require("widgets.clock")
local weather = require("widgets.weather.widget")
local battery_widget = require("widgets.battery")

-- {{{ Wibar

-- Add the bar on each screen
awful.screen.connect_for_each_screen(function(s)
    -- For look like a detached bar, we have to add a fake invisible bar...
    s.useless_wibar = awful.wibar({ position = beautiful.wibar_position, screen = s, height = beautiful.screen_margin * 2, opacity = 0 })

    s.mytasklist = require("widgets.tasklist")(s)


    local bar = wibox.widget {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            textclock,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 50,
            wibox.widget.systray(),
            s.mytasklist,
        },
        { -- right
            layout = wibox.layout.fixed.horizontal,
            spacing = 2,
            battery_widget,
        }
    }

    -- Create the wibox with default options
    s.mywibox = awful.wibar({ height = beautiful.wibar_size, bg = beautiful.wibar_bg, width = beautiful.wibar_width, widget = bar })
end)
