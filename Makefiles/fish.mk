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
# Dependencies for Windows
sudo:
	curl -s https://raw.githubusercontent.com/imachug/win-sudo/master/install.sh | sh
# Chocolatey Installation for Windows
choco:
	@echo "Installing choco"
	powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

check-choco: choco
	@echo "Checking choco"
	@echo $(PATH)
	@echo $(VPATH)
	@$(CHOCOLATEY_ROOT)/bin/choco -v
	@choco -v

# SETUP FISH
ifeq ($(MODE), "minimum")
fish: $(FISH_DEPENDENCIES)
	@$(INSTALL_FISH)
else
fish: brew-packages
endif
~/.config/fish:
	@mkdir -p ~/.config/fish

~/.config/fish/config.fish: |~/.config/fish
	@cp config/fish/config.fish ~/.config/fish/config.fish

~/.config/fish/fish_plugins: |~/.config/fish
	@cp config/fish/fish_plugins ~/.config/fish/fish_plugins

chsh-fish:fish ~/.config/fish/config.fish
	$(eval FISH_PATH := $(shell which fish))
	@echo $(FISH_PATH)
ifeq ($(shell cat /etc/shells | grep fish),)
	@echo $(FISH_PATH) | sudo tee -a /etc/shells
endif
	$(eval SHELL := $(FISH_PATH))
	@sudo chsh -s $(FISH_PATH)

check-fish: ~/.config/fish/config.fish chsh-fish
	@echo "Checking fish"
	@fish -v
	@echo $$SHELL
fisher: curl chsh-fish
	@curl -sL https://git.io/fisher |source && sleep 3 && fisher install jorgebucaran/fisher
	@fisher -v
fish-packages: fisher ~/.config/fish/fish_plugins
	@fisher update
	@fisher list
