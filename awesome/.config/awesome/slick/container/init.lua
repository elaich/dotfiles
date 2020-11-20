local base = require("wibox.widget.base")

return setmetatable({ scale = require("slick.container.scale"); }, 
{__call = function(_, args) return base.make_widget_declarative(args) end})

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
