
include Makefiles/brew.mk

# Dependencies for Windows
sudo:
	curl -s https://raw.githubusercontent.com/imachug/win-sudo/master/install.sh | sh


# SETUP FISH
ifeq ($(MODE), "minimum")
fish: $(FISH_DEPENDENCIES)
	@$(INSTALL_FISH)
	echo $FISH_PATH
	echo $$FISH_PATH
	echo $(FISH_PATH)
	echo $$(FISH_PATH)
	echo $$$(FISH_PATH)
	echo ${FISH_PATH}
	echo $${FISH_PATH}
	echo $$${FISH_PATH}

else
fish: brew-packages
endif
~/.config/fish:
	@mkdir -p ~/.config/fish
~/.config/fish/config.fish: |~/.config/fish
	@echo "Installing fish config"
	@cp config/fish/config.fish ~/.config/fish/config.fish
	@echo "Installing fish functions"
~/.config/fish/fish_plugins: |~/.config/fish
	@cp config/fish/fish_plugins ~/.config/fish/fish_plugins
chsh-fish: |fish ~/.config/fish/config.fish 
ifeq ($(shell cat /etc/shells | grep fish),)
	echo $(FISH_PATH) | sudo tee -a /etc/shells
endif
	$(eval SHELL := $(FISH_PATH))
	＠sudo chsh -s $(FISH_PATH)
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
