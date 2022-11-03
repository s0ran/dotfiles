.PHONY: test-ubuntu2004 down-ubuntu2004 check-ubuntu2004 test-ubuntu2204 down-ubuntu2204 check-ubuntu2204
.SHELLFLAGS := -ec

export
UNAME := $(shell uname)
LOCAL_USER:=$(shell whoami)
LOCAL_UID:=$(shell id -u $(LOCAL_USER))
LOCAL_GID:=$(shell id -g $(LOCAL_USER))
HOME_DIR:=$(shell echo ~$(LOCAL_USER))
SHELL := /bin/bash
MODE := "minimum"


# eval for each OS
ifeq ($(UNAME),Darwin)
	HOMEBREW_PREFIX := /opt/homebrew
	export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
	PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
	FISH_DEPENDENCIES := brew
	BREW_INSTALL := brew install
	INSTALL_FISH := $(BREW_INSTALL) fish
	BREW_SRC := curl
	
else ifeq ($(UNAME),Linux)
	HOMEBREW_PREFIX:= /home/linuxbrew/.linuxbrew
	export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
	PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
	FISH_DEPENDENCIES := brew
	BREW_INSTALL := brew install
	INSTALL_FISH := $(BREW_INSTALL) fish
	BREW_SRC := curl build-essential git ruby
	
else
	PROGRAM_DATA_DIR:=/c/ProgramData
	CHOCOLATEY_ROOT := $(PROGRAM_DATA_DIR)/chocolatey
	export PATH:= $(CHOCOLATEY_ROOT)/bin:$(shell echo "$$PATH")
	FISH_DEPENDENCIES := 
	PACMAN_INSTALL := pacman -S --noconfirm
	INSTALL_FISH := $(PACMAN_INSTALL) fish
endif

# eval VPATH
VPATH := $(shell pwd):${PATH}

# package path
FISH_PATH = $(shell which fish)

include Makefiles/choco.mk Makefiles/fish.mk  

# general
all:
	@/bin/bash -c "`echo 'echo World'`"
	@echo "`whoami`test"
	@echo ${VPATH}
	@echo $$PATH
	@echo $(SHELL)
	env |grep FISH
	echo $${FISH_PATH}
	echo $(shell env |grep FISH)
	env |grep FISH

build:
	@echo "Building the project"
build/windows: sudo fish
inspect:
	@echo "ID: $(LOCAL_UID):$(LOCAL_GID)"
	@echo "USER: $(LOCAL_USER)"
	@echo "HOME: $(HOME_DIR)"
	@echo "UNAME: $(UNAME)"
	@echo "SHELL: $(SHELL)"
	@echo "PATH: $(PATH)"
	@echo "VPATH: $(VPATH)"

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
