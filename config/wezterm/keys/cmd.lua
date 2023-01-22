local cmd = {{
    key = "n",
    mods = "CMD",
    action = "ShowLauncher"
}, {
    key = "d",
    mods = "CMD",
    action = act.SplitVertical {
        domain = "CurrentPaneDomain"
    }
}, {
    key = "D",
    mods = "CMD",
    action = act.SplitHorizontal {
        domain = "CurrentPaneDomain"
    }
}, {
    key = "h",
    mods = "CMD",
    action = act.ActivatePaneDirection "Left"
}, {
    key = "l",
    mods = "CMD",
    action = act.ActivatePaneDirection "Right"
}, {
    key = "k",
    mods = "CMD",
    action = act.ActivatePaneDirection "Up"
}, {
    key = "j",
    mods = "CMD",
    action = act.ActivatePaneDirection "Down"
}, {
    key = "LeftArrow",
    mods = "CMD",
    action = act.SendKey {
        key = "a",
        mods = "CTRL"
    }
}, {
    key = "RightArrow",
    mods = "CMD",
    action = act.SendKey {
        key = "e",
        mods = "CTRL"
    }
}, {
    key = "Backspace",
    mods = "CMD",
    action = act.SendKey {
        key = "u",
        mods = "CTRL"
    }
}}

for i = 1, 9 do
    table.insert(cmd, {
        key = tostring(i),
        mods = "CMD",
        action = act {
            ActivateTab = i - 1
        }
    })
end

return cmd
