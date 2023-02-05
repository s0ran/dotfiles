.PHONY: all anyenv

SHELL:=$(shell which fish)

all: ~/.anyenv

~/.anyenv:
	@git clone https://github.com/anyenv/anyenv ~/.anyenv