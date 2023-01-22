.PHONY: all nvim

all: ${HOME}/.config/nvim

${HOME}/.config/nvim:
	ln -s ${PWD}/config/nvim $@

clean:
	rm -rf ${HOME}/.config/nvim

