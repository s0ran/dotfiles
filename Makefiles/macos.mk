BREW_PATH := $(shell which brew)

# if brew is not installed
ifeq ($(BREW_PATH),)
ifeq ($(MACHINE_TYPE),arm64)
HOMEBREW_PREFIX:=/opt/homebrew
else
HOMEBREW_PREFIX:=/usr/local
endif
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

# if fish is not installed
ifeq ($(FISH_PATH),)
FISH_PATH := $(PACKAGE_ROOT)/fish
endif


