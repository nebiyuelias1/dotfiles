-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- 1. External Monitor (starts at the far left origin)
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "0x0", scale = 1.33 })

-- 2. Primary Laptop Display (placed to the right of DP-2)
-- 1920 / 1.33 = ~1443 logical pixels wide, so they stitch perfectly.
hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "1443x0", scale = 1.5 })

-- 3. Dynamic fallback catch-all (keep this at the bottom!)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })
