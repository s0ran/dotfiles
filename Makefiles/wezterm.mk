.PHONY: all

all: ${HOME}/.config/wezterm

${HOME}/.config/wezterm: ${HOME}/.config
	ln -s ${PWD}/config/wezterm $@