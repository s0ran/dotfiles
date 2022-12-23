

fisher: curl chsh-fish
	@curl -sL https://git.io/fisher |source && sleep 3 && fisher install jorgebucaran/fisher
	@fisher -v
fish-packages: fisher ~/.config/fish/fish_plugins
	@fisher update
	@fisher list