wezterm = require 'wezterm'
act = wezterm.action

local keys = require 'keys.cmd'
local mouse_bindings = require 'mouse_bindings'
local copy_mode = require 'keys.copy_mode'

return {
    font = wezterm.font 'JetBrains Mono',
    font_size = 14.0,
    color_scheme = "Afterglow",
    hide_tab_bar_if_only_one_tab = true,
    keys = keys,
    key_tables = {
        copy_mode = copy_mode
    },
    use_ime = true,
    mouse_bindings = mouse_bindings
}
