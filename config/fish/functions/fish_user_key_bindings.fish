function fish_user_key_bindings
	fish_vi_key_bindings
	bind \cr peco_select_history
	bind -M default \ecopy copy_line
end
