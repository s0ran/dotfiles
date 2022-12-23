PROGRAM_DATA_DIR:=/c/ProgramData
CHOCOLATEY_ROOT := $(PROGRAM_DATA_DIR)/chocolatey
export PATH:= $(CHOCOLATEY_ROOT)/bin:$(shell echo "$$PATH")
FISH_DEPENDENCIES := 
PACMAN_INSTALL := pacman -S --noconfirm
INSTALL_FISH := $(PACMAN_INSTALL) fish