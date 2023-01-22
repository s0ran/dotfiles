.PHONY: all

all: ${HOME}/.config/wezterm

${HOME}/.config/wezterm:
	ln -s ${PWD}/config/wezterm $@