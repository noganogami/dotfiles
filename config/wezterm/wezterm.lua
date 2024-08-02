-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Dracula+'

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.leader = { key = 'j', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 'c',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
        mods   = "LEADER",
        key    = "s",
        action = act.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        mods   = "LEADER",
        key    = "v",
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        mods   = 'LEADER',
        key    = "h",
        action = act.ActivatePaneDirection 'Left',
    },
    {
        mods   = 'LEADER',
        key    = "l",
        action = act.ActivatePaneDirection 'Right',
    },
    {
        mods   = 'LEADER',
        key    = "k",
        action = act.ActivatePaneDirection 'Up',
    },
    {
        mods   = 'LEADER',
        key    = "j",
        action = act.ActivatePaneDirection 'Down',
    },
    {
        mods = 'LEADER',
        key = 'z',
        action = act.TogglePaneZoomState,
    },
}
for i = 1, 8 do
    -- LEADER + number to activate that tab
    table.insert(config.keys, {
        mods = 'LEADER',
        key = tostring(i),
        action = act.ActivateTab(i - 1),
    })
    -- LEADER + number to move to that position
    table.insert(config.keys, {
        mods = 'LEADER',
        key = 'F' .. tostring(i),
        action = act.MoveTab(i - 1),
    })
end

-- and finally, return the configuration to wezterm
return config
