.PHONY: sync

# Brew Installation for Mac, Linux
all: $(BREW_PATH) brew
	$(MAKE) -e --makefile=Makefiles/brew_packages.mk all

# Brew Installation
$(BREW_PATH) brew &: ${BREW_SRC}
	@echo "Installing brew"
	# On arm mac install brew to /opt/homebrew
	# On intel mac install brew to /usr/local
	# On linux install brew to /home/linuxbrew/.linuxbrew
	# Add setting for PATH in config of shell
	@/bin/bash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh`"
	@mkdir -p ${EMPTY_TARGET}/brew	

sync:
	@brew bundle dump -f --global

