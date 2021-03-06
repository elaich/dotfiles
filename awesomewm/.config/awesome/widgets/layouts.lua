local widget = require("util.widgets")
local gtable = require("gears.table")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- beautiful var
local wibar_pos = beautiful.wibar_position or "top"
local fg = beautiful.layout_button or beautiful.fg_grey_light or "#daeda1"

local function fixed_position(want)
  if wibar_pos == "top" or wibar_pos == "bottom" then
    return want == 'string' and "horizontal" or wibox.layout.fixed.horizontal
  else
    return want == 'string' and "vertical" or wibox.layout.fixed.vertical
  end
end

local monitoring_button = widget.create_button(fg, " ")
monitoring_button:buttons(gtable.join(
  awful.button({}, 1, function()
    sidebar.visible = not sidebar.visible
  end)
))

local start_screen_button = widget.create_button(fg, " ")
start_screen_button:buttons(gtable.join(
  awful.button({}, 1, function()
    start_screen.visible = not start_screen.visible
  end)
))

local function set_tooltip(w, text)
  local tooltip = awful.tooltip({ objects = { w } })
  w:connect_signal('mouse::enter', function()
    tooltip.text = text
  end)
end

set_tooltip(monitoring_button, 'Show/Hide monitor bar')
set_tooltip(start_screen_button, 'Show/Hide start_screen')

local layouts_widget = wibox.widget {
  monitoring_button,
  start_screen_button,
  spacing = beautiful.widget_spacing or 1,
  layout = fixed_position(ob)
}

return layouts_widget
