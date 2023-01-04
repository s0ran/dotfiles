SHELL:=$(shell which fish)

all: abbr

abbr:
	fish config/fish/abbrfile.fish
