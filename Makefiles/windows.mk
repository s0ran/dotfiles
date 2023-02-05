PROGRAM_DATA_DIR:=/c/ProgramData

CHOCOLATEY_ROOT := $(PROGRAM_DATA_DIR)/chocolatey
CHOCOLATEY_INSTALL := choco install
export PATH:= $(CHOCOLATEY_ROOT)/bin:$(shell echo "$$PATH")

PACMAN_INSTALL := pacman -S --noconfirm
INSTALL_FISH := $(PACMAN_INSTALL) fish
CHANGE_SHELL := mkpasswd -c|sed -e 's/bash/fish/g' > /etc/passwd

ifeq ($(FISH_PATH),)
FISH_PATH:=/usr/bin/fish.exe
endif
FISH_DEPENDENCIES := anyenv
