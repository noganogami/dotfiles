-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

local mux = wezterm.mux

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- Optionally: config.color_scheme_dirs = { '/.../.config/wezterm/colors/' }
config.color_scheme = 'Yorumi Abyss' -- Options: Yorumi-[Mist|Abyss|Kraken|Shade]

-- config.window_background_image = wezterm.home_dir .. '/.config/wezterm/images/divergence-meter.jpg'
-- config.window_background_opacity = 0.2

config.font = wezterm.font("HackGen Console NF")

config.use_ime = false

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.native_macos_fullscreen_mode = true

config.leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 }
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
    {
        mods   = 'LEADER',
        key    = "[",
        action = act.ActivateCopyMode,
    },
    {
        mods = 'LEADER',
        key = 'p',
        action = act.PasteFrom 'Clipboard'
    },
    {
        mods = 'LEADER',
        key = 'q',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- -- -- Prompt for a name to use for a new workspace and switch to it.
    {
        mods = 'LEADER',
        key = 'w',
        action = wezterm.action_callback(function(window, pane)
            -- Here you can dynamically construct a longer list if needed
            local workspaces = {}
            for i, name in ipairs(wezterm.mux.get_workspace_names()) do
                table.insert(workspaces, {
                    id = name,
                    label = string.format("Swhich to Workspace: %s", name),
                })
            end
            table.insert(workspaces, {
                id = "CREATE",
                label = "Create new Workspace",
            })
            local active = window:active_workspace()
            window:perform_action(
                act.InputSelector {
                    action = wezterm.action_callback(
                        function(inner_window, inner_pane, id, label)
                            if not id and not label then
                                wezterm.log_info 'cancelled'
                            elseif id == "CREATE" then
                                inner_window:perform_action(
                                    act.PromptInputLine {
                                        description = wezterm.format {
                                            { Attribute = { Intensity = 'Bold' } },
                                            { Foreground = { AnsiColor = 'Fuchsia' } },
                                            { Text = 'Enter name for new workspace' },
                                        },
                                        action = wezterm.action_callback(function(prompt_window, prompt_pane, line)
                                            -- line will be `nil` if they hit escape without entering anything
                                            -- An empty string if they just hit enter
                                            -- Or the actual line of text they wrote
                                            if line then
                                                wezterm.log_info 'created'
                                                wezterm.log_info('name: ' .. line)
                                                prompt_window:perform_action(
                                                    act.SwitchToWorkspace {
                                                        name = line,
                                                    },
                                                    prompt_pane
                                                )
                                            end
                                        end),
                                    },
                                    inner_pane
                                )
                            else
                                wezterm.log_info('name: ' .. id)
                                inner_window:perform_action(
                                    act.SwitchToWorkspace {
                                        name = id,
                                    },
                                    inner_pane
                                )
                            end
                        end
                    ),
                    title = 'Choose Workspace',
                    choices = workspaces,
                    fuzzy = false,
                    description = string.format("Select or make a workspace (current is '%s')", active),
                },
                pane
            )
        end),
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

wezterm.on('gui-startup', function(cmd)
    local _, pane, window = mux.spawn_window(cmd or {})
    local gui_window = window:gui_window();
    gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_domain = 'WSL:Ubuntu'
end

-- and finally, return the configuration to wezterm
return config
