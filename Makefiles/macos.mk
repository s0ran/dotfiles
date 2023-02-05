BREW_PATH := $(shell which brew)

# brew is not installed
ifeq ($(BREW_PATH),)
HOMEBREW_PREFIX:=/opt/homebrew
export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
BREW_PATH:=$(PACKAGE_ROOT)/brew
else
PACKAGE_ROOT:=$(shell dirname ${BREW_PATH})
endif

# set for fish install
FISH_DEPENDENCIES := $(BREW_PATH)
BREW_INSTALL := brew install
INSTALL_FISH := $(BREW_INSTALL) fish
CHANGE_SHELL := sudo chsh -s `which fish`

# fish is not installed
ifeq ($(FISH_PATH),)
FISH_PATH := $(PACKAGE_ROOT)/fish
endif


