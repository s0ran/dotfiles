PROGRAM_DATA_DIR:=/c/ProgramData

CHOCOLATEY_ROOT := $(PROGRAM_DATA_DIR)/chocolatey
CHOCOLATEY_INSTALL := choco install
export PATH:= $(CHOCOLATEY_ROOT)/bin:$(shell echo "$$PATH")

PACMAN_INSTALL := pacman -S --noconfirm
INSTALL_FISH := $(PACMAN_INSTALL) fish
FISH_PATH ?= /usr/bin/fish
FISH_DEPENDENCIES := 

dependencies:
	$(PACMAN_INSTALL) base-devel mingw-64-x86_64-toolchain