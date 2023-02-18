.PHONY: all

export
override SHELL := ${FISH_PATH}
FISH_FUNCTIONS_DIR := ${HOME}/.config/fish/functions
#MAKESHELL := ${FISH_PATH}

all: fish/packages

${FISH_CONFIG_DIR}: ${FISH_FUNCTIONS_DIR}/fisher.fish
	@ln -sf ${PWD}/config/fish $@
	cat ~/.config/fish/fish_plugins
	cat config/fish/fish_plugins

#~/.config/fish/fish_plugins: ${FISH_FUNCTIONS_DIR}/fisher.fish
#	@ln -sf ${PWD}/config/fish/fish_plugins ~/.config/fish/fish_plugins

${FISH_FUNCTIONS_DIR}/fisher.fish:
	@curl -sL https://git.io/fisher | source && sleep 3 && fisher install jorgebucaran/fisher

fish/packages: ${FISH_CONFIG_DIR}
	@fisher update
	@touch ${EMPTY_TARGET}/fish/packages