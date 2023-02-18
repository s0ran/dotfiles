.PHONY: all

export
override SHELL := ${FISH_PATH}
FISH_FUNCTIONS_DIR := ${HOME}/.config/fish/functions
#MAKESHELL := ${FISH_PATH}

all: fish/packages

${FISH_FUNCTIONS_DIR}/fisher.fish:
	@curl -sL https://git.io/fisher | source && sleep 3 && fisher install jorgebucaran/fisher

${FISH_CONFIG_DIR}: ${FISH_FUNCTIONS_DIR}/fisher.fish
	ln -sf ${PWD}/config/fish ${FISH_CONFIG_DIR}
	ln -sf ${PWD}/config/fish/fish_plugins ${FISH_CONFIG_DIR}/fish_plugins

fish/packages: ${FISH_CONFIG_DIR}
	cat ~/.config/fish/fish_plugins
	@fish -c "fisher update"
	@touch ${EMPTY_TARGET}/fish/packages