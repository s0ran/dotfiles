PHONY: setup

UNAME := $(shell uname)

all:
	@echo test

build:
	@echo ${UNAME}
	sudo apt install -y build-essential