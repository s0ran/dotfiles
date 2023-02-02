function fish_user_key_bindings
	fish_default_key_bindings -M insert
	fish_vi_key_bindings --no-erase
	bind \cr peco_select_history
	bind -M default \ecopy copy_line
end
