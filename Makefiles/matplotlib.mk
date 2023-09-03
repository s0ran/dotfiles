.PHONY: all

all: ${HOME}/.config/matplotlib

${HOME}/.config/matplotlib:
	ln -s ${PWD}/config/matplotlib $@