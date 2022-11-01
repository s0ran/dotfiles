.PHONY: test-ubuntu2004 down-ubuntu2004 check-ubuntu2004 test-ubuntu2204 down-ubuntu2204 check-ubuntu2204

UNAME := $(shell uname)
PACKAGE_MANAGER = $(shell if [ "$(UNAME)" = "Darwin" ]; then echo "brew"; else echo "apt-get"; fi)
BREW_SRC := $(shell if [ "$(UNAME)" = "Darwin" ]; then echo "curl"; else echo "ruby curl build-essential git"; fi)
HOMEBREW_PREFIX := $(shell if [ "$(UNAME)" = "Darwin" ]; then echo "/opt/homebrew"; else echo "/home/linuxbrew/.linuxbrew"; fi)
export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
LOCAL_USER:=$(shell whoami)
LOCAL_UID:=$(shell id -u $(LOCAL_USER))
LOCAL_GID:=$(shell id -g $(LOCAL_USER))
HOME_DIR:=$(shell echo ~$(LOCAL_USER))

# eval for each OS
ifeq ($(UNAME),Darwin)
	export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
	PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
else ifeq ($(UNAME),Linux)
	export PATH:= $(HOMEBREW_PREFIX)/bin:$(HOMEBREW_PREFIX)/sbin:$(shell echo "$$PATH")
	PACKAGE_ROOT:=$(HOMEBREW_PREFIX)/bin
else
	PROGRAM_DATA_DIR:=C/ProgramData
	CHOCOLATEY_ROOT := $(PROGRAM_DATA_DIR)/chocolatey
	export PATH:= $(CHOCOLATEY_ROOT)/bin:$(shell echo "$$PATH")
endif

# eval VPATH
VPATH := $(shell pwd):${PATH}

# package path
FISH_PATH := $(PACKAGE_ROOT)/fish

# general
all:
	@/bin/bash -c "`echo 'echo World'`"
	@echo "`whoami`test"
	@echo ${VPATH}
	@echo $$PATH

build:
	@echo "Building the project"

inspect: ~/.anyenv
	@echo "ID: $(LOCAL_UID):$(LOCAL_GID)"
	@echo "USER: $(LOCAL_USER)"
	@echo "HOME: $(HOME_DIR)"
	@echo "UNAME: $(UNAME)"
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
	@choco -v


# SETUP FISH
${FISH_PATH} : brew-packages
~/.config/fish:
	@mkdir -p ~/.config/fish

~/.config/fish/config.fish: ~/.config/fish
	@cp fish/config.fish ~/.config/fish/config.fish

~/.config/fish/fish_plugins: ~/.config/fish
	@cp fish/fish_plugins ~/.config/fish/fish_plugins

chsh-fish: ${FISH_PATH}
	ifeq ($(shell cat /etc/shells | grep fish),)
		@echo "$(FISH_PATH) | sudo tee -a /etc/shells
	endif
	@sudo chsh -s $(FISH_PATH)
	@echo $$SHELL

check-fish: ~/.config/fish/config.fish ~/.config/fish/fish_plugins chsh-fish
	@echo "Checking fish"
	@fish -v
	@echo $$SHELL
	

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
