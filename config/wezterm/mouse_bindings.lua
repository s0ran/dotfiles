local mouse_boundings = {{
    event = {
        Down = {
            streak = 1,
            button = 'Right'
        }
    },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard'
}}
return mouse_boundings