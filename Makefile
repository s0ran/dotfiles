.PHONY: all abbr build brew fish test-ubuntu2004 down-ubuntu2004 check-ubuntu2004 test-ubuntu2204 down-ubuntu2204 check-ubuntu2204
.SHELLFLAGS := -ec

export
UNAME := $(shell uname)
MACHINE_TYPE := $(shell uname -m)
LOCAL_USER:=$(shell whoami)
LOCAL_UID:=$(shell id -u $(LOCAL_USER))
LOCAL_GID:=$(shell id -g $(LOCAL_USER))
HOME:=$(shell echo ~$(LOCAL_USER))
SHELL:=/bin/bash
PWD:=$(shell pwd)
PROJECT_ROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

# path
FISH_PATH:=$(shell which fish)
GH_PATH:=$(shell which gh)

# multi profile
USAGE:="personal" # personal
# USAGE:="work" # work
# USAGE:="minimum" # minimum

# eval for each OS
ifeq ($(UNAME),Darwin)
	include Makefiles/macos.mk
else ifeq ($(UNAME),Linux)
	include Makefiles/linux.mk
else
	include Makefiles/windows.mk
endif

EMPTY_TARGET:=target
VPATH:=${EMPTY_TARGET}

all:abbr wezterm nvim gh/pubkey

build:abbr

${BREW_PATH}:
	@$(MAKE) -e --makefile=Makefiles/brew.mk all

${HOME}/.config:
	mkdir -p $@

fish: ${FISH_DEPENDENCIES} ${HOME}/.config
	@$(MAKE) -e --makefile=Makefiles/fish.mk all

abbr:fish
	@$(MAKE) -e --makefile=Makefiles/abbr.mk all

wezterm: ${BREW_PATH} ${HOME}/.config
	@$(MAKE) -e --makefile=Makefiles/wezterm.mk all

nvim: ${BREW_PATH} ${HOME}/.config
	@$(MAKE) -e --makefile=Makefiles/nvim.mk all

gh/pubkey:
	@$(MAKE) -e --makefile=Makefiles/gh_pubkey.mk all

sync:
	@$(MAKE) -e --makefile=Makefiles/abbr.mk sync
	@$(MAKE) -e --makefile=Makefiles/brew.mk sync

inspect:
	@echo "ID: $(LOCAL_UID):$(LOCAL_GID)"
	@echo "USER: $(LOCAL_USER)"
	@echo "HOME: $(HOME)"
	@echo "UNAME: $(UNAME)"
	@echo "MACHINE_TYPE: $(MACHINE_TYPE)"
	@echo "PROJECT_ROOT: $(PROJECT_ROOT)"
	@echo "SHELL: $(SHELL)"
	@echo "PWD: $(PWD)"
	@echo "PATH: $(PATH)"
	@echo "VPATH: $(VPATH)"
	@echo "VARIABLES: $(.VARIABLES)"
	@echo "MAKELEVEL: $(MAKELEVEL)"
	@echo "MAKEFILE_LIST: $(MAKEFILE_LIST)"
	@echo "MAKEFILES: $(MAKEFILES)"
	@echo "MAKECMDGOALS: $(MAKECMDGOALS)"
	@echo "MAKEOVERRIDES: $(MAKEOVERRIDES)"
	@echo "MAKEFLAGS: $(MAKEFLAGS)"
	@echo "MAKE_VERSION: $(MAKE_VERSION)"
	@echo "MAKE_RESTARTS: $(MAKE_RESTARTS)"

clean:
	@rm -rf ${EMPTY_TARGET}

# Test
test-ubuntu2004:
	docker build -f test/ubuntu2004/Dockerfile . -ttest_ubuntu2004
	docker run -v $(shell pwd):/home/docker -e LOCAL_UID=${LOCAL_UID} -e LOCAL_GID=${LOCAL_GID} --name test_ubuntu2004 -itd test_ubuntu2004 /bin/bash

down-ubuntu2004:
	docker stop test_ubuntu2004
	docker rm test_ubuntu2004

check-ubuntu2004:
	docker exec -it test_ubuntu2004 bash

test-ubuntu2204:
	docker build -f test/ubuntu2204/Dockerfile . -ttest_ubuntu2004 --no-cache --progress=plain
	docker run -dit -v $(shell pwd):/home/docker --name test_ubuntu2204 test_ubuntu2004 bash

down-ubuntu2204:
	docker stop test_ubuntu2204
	docker rm test_ubuntu2204

check-ubuntu2204:
	docker exec -it test_ubuntu2204 bash
