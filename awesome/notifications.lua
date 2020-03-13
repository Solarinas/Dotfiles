-- Notification settings

-- Standard Awesome Libraries
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local naughty = require("naughty")

-- Timeouts
naughty.config.defaults.timeout = 5
naughty.config.presets.low.timeout = 2 
naughty.config.presets.critical.timeout = 12

-- Apply theme variables
naughty.config.padding = beautiful.notification_padding
naughty.config.spacing = beautiful.notification_spacing
naughty.config.defaults.margin = beautiful.notification_margin
naughty.config.defaults.border_width = beautiful.notification_border_width

naughty.config.presets.normal = {
    font = beautiful.notification_font,
    fg = beautiful.notification_fg,
    bg = beautiful.notification_bg,
    border_width = beautiful.notification_border_width,
    margin = beautiful.notifcation_margin,
    position = beautiful.notificaion_position
}

naughty.config.presets.low = {
    font = beautiful.notification_font,
    fg = beautiful.notification_fg,
    bg = beautiful.notification_bg,
    border_width = beautiful.notification_border_width,
    margin = beautiful.notifcation_margin,
    position = beautiful.notificaion_position
}

naughty.config.presets.ok = naughty.config.prsets.low
naughty.config.presets.info = naughty.config.prsets.low
naughty.config.presets.warn = naughty.config.presets.normal 

naughty.config.presets.critical = {
    font = beautiful.notification_font,
    fg = beautiful.notification_crit_fg,
    bg = beautiful.notification_crit_bg,
    border_width = beautiful.notification_border_width,
    margin = beautiful.notfication_margin,
    position = beautiful.notification_position
}

-- For anti-aliasing 
local notification_bg = beautiful.notification_bg
beautiful.notification_bg = "#00000000"

-- Template
-- ================================================== 
naughty.connect_signal("request::display", function(n)

    -- Debugging
    -- print(n.title)
    -- print(n.message)

    -- Custom icon widget
    -- It can be used instead of naughty.widget.icon if you prefer your icon to be
    -- a textbox instead of an image. However, you have to determine its
    -- text/markup value from the notification before creating the
    -- naughty.layout.box.
    local custom_notification_icon = wibox.widget {
        font = "icomoon 14",
        -- font = "icomoon bold 40",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }


    -- Default symbol and color
    local symbol = ""
    local color = beautiful.xforeground

    -- Try to detect the notification source and change the symbol and/or color ccordingly
    if n.title == "Telegram" then
        symbol = ""
    elseif n.title == "Volume" then
        symbol = ""
        n.title = ""
    elseif n.title == "Screenshot" then
        -- symbol = ""
        symbol = ""
        n.title = ""
    elseif n.title == "Performance mode" then
        symbol = ""
    elseif n.title == "Night mode" then
        symbol = ""
    elseif n.title:match('Connection') then
        symbol = ""
    elseif n.title == "Battery status" then
        -- symbol = ""
        symbol = ""
    elseif n.title == "Charger status" then
        symbol = ""
        n.title = ""
    elseif n.title:match('YouTube') then
        -- symbol = ""
        -- symbol = ""
        symbol = ""
    end

    naughty.layout.box {
        notification = n,
        type = "splash",
        -- For antialiasing: The real shape is set in widget_template
        shape = gears.shape.rectangle,
        border_width = beautiful.notification_border_width,
        border_color = beautiful.notification_border_color,
        -- position = beautiful.notification_position,
        -- placement       = awful.placement.bottom,
        -- offset          = beautiful.useless_gap * 2,
        widget_template = {
            {
                {
                    {
                        {
                            -- {
                                -- naughty.widget.icon,
                                {
                                    {
                                        {
                                            markup = helpers.colorize_text(symbol, color),
                                            widget = custom_notification_icon,
                                        },
                                        margins = beautiful.notification_margin,
                                        widget  = wibox.container.margin,
                                    },
                                    bg = beautiful.xcolor0,
                                    widget  = wibox.container.background,
                                },
                                {
                                    rainbow_stripe,
                                    forced_height = dpi(4),
                                    -- shape = gears.shape.rounded_bar,
                                    widget = wibox.container.background
                                },
                                {
                                    {
                                        {
                                            {
                                                align = "center",
                                                widget = naughty.widget.title,
                                            },
                                            {
                                                align = "center",
                                                widget = naughty.widget.message,
                                            },
                                            -- spacing = dpi(4),
                                            layout  = wibox.layout.fixed.vertical,
                                        },
                                        margins = beautiful.notification_margin,
                                        widget  = wibox.container.margin,
                                    },
                                    bg = notification_bg,
                                    widget  = wibox.container.background,
                                },
                                -- naughty.list.actions,
                                -- spacing = dpi(4),
                                layout  = wibox.layout.fixed.vertical,
                            -- },
                            -- margins = beautiful.notification_margin,
                            -- widget  = wibox.container.margin,
                        },
                        bg = "#00000000",
                        id     = "background_role",
                        widget = naughty.container.background,
                    },
                    strategy = "min",
                    width    = dpi(160),
                    widget   = wibox.container.constraint,
                },
                strategy = "max",
                width    = beautiful.notification_max_width or dpi(500),
                widget   = wibox.container.constraint,
            },
            -- Anti-aliasing container
            bg = notification_bg,
            -- bg = "#00000000",
            -- This will be the anti-aliased shape of the notification
            shape = helpers.rrect(beautiful.notification_border_radius),
            widget = wibox.container.background
        }
    }

end)
