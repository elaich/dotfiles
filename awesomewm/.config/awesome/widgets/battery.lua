local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local gears = require("gears")

local battery_widget = wibox.widget {
  resize = true,
  widget = wibox.widget.imagebox
}

local battery_level = wibox.widget {
  font = 'Barlow Condensed 14',
  valign = "bottom",
  align = "right",
  widget = wibox.widget.textbox
}

local battery_widget_container = wibox.widget {
  {
    battery_level,
    battery_widget,
    spacing = 2,
    layout = wibox.layout.fixed.horizontal
  },
  top = 5, bottom = 5, 
  right = 0, left = 0,
  widget = wibox.container.margin
}

local function update_widget(state, value)
  if (state == "Discharging") then
    if ( tonumber(value) < 15 ) then 
      battery_widget.image = beautiful.widget_battery_icon_alert
    else
      battery_widget.image = beautiful.widget_battery_icon_discharging
    end
  elseif (state == "Charging") then
    battery_widget.image = beautiful.widget_battery_icon_charging
  elseif (state == "Full") then
    battery_widget.image = beautiful.widget_battery_icon_full
  elseif (state == "Unknown") then
    battery_widget.image = beautiful.widget_battery_icon_unknown
  end
  battery_level.text = value..'%'
end

gears.timer {
  timeout   = 10,
  call_now  = true,
  autostart = true,
  callback  = function()
    awful.spawn.easy_async_with_shell("acpi", function(out)
      local state, level = string.match(out, '%w+ %d: (%w+), (%d+)')
      update_widget(state, level)
    end)
  end
}

return battery_widget_container
