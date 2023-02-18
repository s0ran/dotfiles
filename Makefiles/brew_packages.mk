.PHONY all

all: brew/packages

~/.Brewfile:
ifeq ($(USAGE),personal)
	@ln -sf ${PWD}/Brewfiles/Brewfile.personal ~/.Brewfile
else ifeq ($(USAGE),work)
	@ln -sf ${PWD}/Brewfiles/Brewfile.work ~/.Brewfile
else ifeq ($(USAGE),minimum)
	@brew bundle dump -f --global --file=${PWD}/Brewfiles/Brewfile.minimum
	@ln -sf ${PWD}/Brewfiles/Brewfile.minimum ~/.Brewfile
else
	@echo "USAGE: personal, work, minimum"
endif

# Install Brew Packages
brew/packages: ~/.Brewfile
	@brew bundle --global || true
	@touch ${EMPTY_TARGET}/brew/packages