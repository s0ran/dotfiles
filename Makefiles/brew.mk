.PHONY: sync brew-packages

# Brew Installation for Mac, Linux
all: brew-packages

# Brew Installation
$(BREW_PATH): ${BREW_SRC}
	@echo "Installing brew"
	@/bin/bash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh`"
	# On arm mac install brew to /opt/homebrew
	# On intel mac install brew to /usr/local
	# On linux install brew to /home/linuxbrew/.linuxbrew
	# Add setting for PATH in config of shell

sync:
	@brew bundle dump -f --global

~/.Brewfile:
ifeq ($(USAGE),personal)
	@ln -sf ${PWD}/Brewfiles/Brewfile.personal ~/.Brewfile
else ifeq ($(USAGE),work)
	@ln -sf ${PWD}/Brewfiles/Brewfile.work ~/.Brewfile
else ifeq ($(USAGE),minimum)
	@ln -sf ${PWD}/Brewfiles/Brewfile.minimum ~/.Brewfile
else
	@echo "USAGE: personal, work, minimum"
endif

# Install Brew Packages
brew-packages: $(BREW_PATH) ~/.Brewfile
	@brew bundle --global || true