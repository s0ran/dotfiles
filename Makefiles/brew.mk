# Brew dependencies for Linux
git:
	@echo "Installing git"
	@sudo apt install -y git

build-essential:
	@echo "Installing build-essential"
	@sudo apt install -y build-essential

curl:
	@echo "Installing curl"
	@sudo apt install -y curl

ruby:
	@echo "Installing ruby"
	@sudo apt install -y ruby

# Brew Installation for Mac, Linux
brew: ${BREW_SRC}
	@echo "Installing brew"
	@/bin/bash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh`"
	@echo $$PATH
	@brew -v

~/.Brewfile:
	cp Brewfile ~/.Brewfile

# Install Brew Packages
brew-packages: brew ~/.Brewfile
	@brew bundle --global || true