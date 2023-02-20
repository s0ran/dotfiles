.PHONY: all abbr sync

SHELL:=$(shell which fish)

all: abbr

config/fish/abbrfile.fish:
	@abbr -s > $@	

abbr:
	@. config/fish/abbrfile.fish

sync: 
	@abbr -s > config/fish/abbrfile.fish
