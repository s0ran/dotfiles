.PHONY: all

export
override SHELL := ${FISH_PATH}
#MAKESHELL := ${FISH_PATH}

all: fish-packages
~/.config/fish/fish_plugins:
	@cp config/fish/fish_plugins ~/.config/fish/fish_plugins
fisher:
	@echo COMSPEC: $$COMSPEC
	@echo SHELL: $$SHELL
	@echo MAKESHELL: $$MAKESHELL
	@curl -sL https://git.io/fisher | source && sleep 3 && fisher install jorgebucaran/fisher && fisher -v
	@fisher -v
fish-packages: fisher ~/.config/fish/fish_plugins
	@fisher update
	@fisher list