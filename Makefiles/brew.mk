# Brew Installation for Mac, Linux
all: brew-packages


$(BREW_PATH): ${BREW_SRC}
	@echo "Installing brew"
	@/bin/bash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh`"

~/.Brewfile:
	cp Brewfile ~/.Brewfile

# Install Brew Packages
brew-packages: $(BREW_PATH) ~/.Brewfile
	@brew bundle --global || true