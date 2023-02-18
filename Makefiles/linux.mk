#if brew is installed
BREW_PATH := $(shell which brew)

# if brew is not installed
ifeq ($(BREW_PATH),)
HOMEBREW_PREFIX:= /home/linuxbrew/.linuxbrew
export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
BREW_PATH:=$(PACKAGE_ROOT)/brew
else
PACKAGE_ROOT:=$(shell dirname ${BREW_PATH})
endif

# set for fish install
FISH_DEPENDENCIES := $(BREW_PATH)
BREW_INSTALL := $(BREW_PATH) install
INSTALL_FISH := $(BREW_INSTALL) fish
CHANGE_SHELL := sudo chsh -s `which fish`
BREW_SRC := curl build-essential git ruby

# apt install
APT_INSTALL := sudo apt install -y

# if fish is not installed
ifeq ($(FISH_PATH),)
FISH_PATH := $(PACKAGE_ROOT)/fish
endif

# if gh is not installed
ifeq ($(GH_PATH),)
GH_PATH := $(PACKAGE_ROOT)/gh
INSTALL_GH := $(BREW_INSTALL) gh
endif

dependencies: 
	@$(APT_INSTALL) $(BREW_SRC)