.PHONY: all

export
override SHELL := ${FISH_PATH}
FISH_FUNCTIONS_DIR := ${HOME}/.config/fish/functions
#MAKESHELL := ${FISH_PATH}

all: fish/packages

${FISH_CONFIG_DIR}: ${FISH_FUNCTIONS_DIR}/fisher.fish
	rm -rf ${FISH_CONFIG_DIR}
	ln -sf ${PWD}/config/fish ${FISH_CONFIG_DIR}


${FISH_FUNCTIONS_DIR}/fisher.fish:
	@curl -sL https://git.io/fisher | source && sleep 3 && fisher install jorgebucaran/fisher

fish/packages: ${FISH_CONFIG_DIR}
	cat ~/.config/fish/fish_plugins
ifeq ($(UNAME),$(filter $(UNAME),Darwin Linux))
	@fisher update
else
	@fish -c fisher update
endif
	@touch ${EMPTY_TARGET}/fish/packages