local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

-- widgets load
local pad = separators.pad
local mpc = require("widgets.button_only_mpc")
local change_theme = require("widgets.button_change_theme")
local desktop_ctrl = require("widgets.desktop-control")
local scrot = require("widgets.scrot")
local layouts = require("widgets.layouts")

-- for the top
local ram = require("widgets.ram")({ mode = "progressbar" })
local volume = require("widgets.volume")({ mode = "progressbar" })

-- {{{ Wibar
awful.screen.connect_for_each_screen(function(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  s.mytasklist = require("widgets.tasklist")(s)

  -- Create a taglist widget for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "line", want_layout = 'flex' })

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_size, bg = beautiful.wibar_bg })

  -- Add widgets to the wibox
  s.mywibox:setup {
    nil,
    {
      volume,
      pad(4),
      ram,
      layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand ="none",
    layout = wibox.layout.align.horizontal
  }

  -- tagslist bar
  s.mywibox_tags = awful.wibar({ screen = s, position = beautiful.wibar_position, height = dpi(5), bg = beautiful.wibar_bg })
  awful.placement.maximize_horizontally(s.mywibox_tags)

  s.mywibox_tags:setup {
    widget = s.mytaglist
  }

  -- bottom bar
  s.mywiboxbottom = awful.wibar({ position = "bottom", height = dpi(80), bg = beautiful.wibar_bg })

  s.mywiboxbottom:setup {
    { -- Left widgets
      layouts,
      layout = wibox.layout.align.horizontal
    },
    s.mytasklist, -- More or less Middle
    { -- Right widgets
      mpc,
      change_theme,
      desktop_ctrl,
      scrot,
      wibox.widget.textbox(" "),
      spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.horizontal
    },
    expand ="none",
    layout = wibox.layout.align.horizontal
  }
  
end)
