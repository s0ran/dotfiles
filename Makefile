.PHONY: test-ubuntu2004 down-ubuntu2004 check-ubuntu2004 test-ubuntu2204 down-ubuntu2204 check-ubuntu2204

UNAME := $(shell uname)
LOCAL_USER:=$(shell whoami)
LOCAL_UID:=$(shell id -u $(LOCAL_USER))
LOCAL_GID:=$(shell id -g $(LOCAL_USER))
HOME_DIR:=$(shell echo ~$(LOCAL_USER))
SHELL := /bin/bash
MODE := "minimum"


# eval for each OS
ifeq ($(UNAME),Darwin)
	export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
	PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
	FISH_DEPENDENCIES := brew
	INSTALL_FISH := brew install fish
	BREW_SRC := curl
	HOMEBREW_PREFIX
else ifeq ($(UNAME),Linux)
	export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
	PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
	FISH_DEPENDENCIES := brew
	INSTALL_FISH := brew install fish
	BREW_SRC := curl build-essential git ruby
	HOMEBREW_PREFIX:= /home/linuxbrew/.linuxbrew
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

# general
all:
	@/bin/bash -c "`echo 'echo World'`"
	@echo "`whoami`test"
	@echo ${VPATH}
	@echo $$PATH

build:
	@echo "Building the project"
build/windows: sudo fish
sudo:
	curl -s https://raw.githubusercontent.com/imachug/win-sudo/master/install.sh | sh
inspect:
	@echo "ID: $(LOCAL_UID):$(LOCAL_GID)"
	@echo "USER: $(LOCAL_USER)"
	@echo "HOME: $(HOME_DIR)"
	@echo "UNAME: $(UNAME)"
	@echo "SHELL: $(SHELL)"
	@echo "PATH: $(PATH)"
	@echo "VPATH: $(VPATH)"

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
	@echo "Installing fish"
	@$(INSTALL_FISH)
	@echo $(PATH)
	@which fish
else
fish: brew-packages
endif
~/.config/fish:
	@mkdir -p ~/.config/fish

~/.config/fish/config.fish: ~/.config/fish
	@cp config/fish/config.fish ~/.config/fish/config.fish

~/.config/fish/fish_plugins: ~/.config/fish
	@cp config/fish/fish_plugins ~/.config/fish/fish_plugins

chsh-fish:fish ~/.config/fish/config.fish
	@echo $(PATH)
	@echo $$PATH
	@which brew
	@ls -la $(HOMEBREW_PREFIX)/bin
ifeq ($(shell cat /etc/shells | grep fish),)
	@echo $(FISH_PATH) | sudo tee -a /etc/shells
endif
	@cat /etc/shells
	@sudo chsh -s $(FISH_PATH)

check-fish: ~/.config/fish/config.fish chsh-fish
	@echo "Checking fish"
	@fish -v
	@echo $$SHELL
fisher: curl chsh-fish
	@fish -c "curl -sL https://git.io/fisher |source && sleep 3 && fisher install jorgebucaran/fisher"
	@fish -c "fisher -v"
fish-packages: fisher ~/.config/fish/fish_plugins
	@fish -c "fisher update"
	@fish -c "fisher list"

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
