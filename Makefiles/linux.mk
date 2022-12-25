HOMEBREW_PREFIX:= /home/linuxbrew/.linuxbrew
export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
FISH_DEPENDENCIES := brew
BREW_INSTALL := brew install
INSTALL_FISH := $(BREW_INSTALL) fish
BREW_SRC := curl build-essential git ruby
APT_INSTALL := sudo apt install -y
ifeq ($(FISH_PATH),)
FISH_PATH := $(PACKAGE_ROOT)/fish
endif
dependencies: 
	@$(APT_INSTALL) $(BREW_SRC)