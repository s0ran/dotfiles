SHELL:=$(shell which fish)

all: abbr

abbr:
	@fish config/fish/abbrfile.fish

sync:
	@abbr -s > config/fish/abbrfile.fish
