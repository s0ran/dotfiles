
include Makefiles/brew.mk

FISH_PATH = $(shell which fish)

# fishがインストールされていれば、fishのシェルが登録されているかチェックする
# なければ、fishをインストールする
# そして、fishのシェルを登録する
all:
	$(MAKE) $(FISH_PATH)
	$(MAKE) check-fish
	$(MAKE) --makefile=fish_package.mk all
	

$(FISH_PATH):${FISH_DEPENDENCIES}
	$(INSTALL_FISH)
# Dependencies for Windows
#sudo:
#	curl -s https://raw.githubusercontent.com/imachug/win-sudo/master/install.sh | sh


# SETUP FISH
ifeq ($(MODE), "minimum")
fish: $(FISH_DEPENDENCIES)
	@$(INSTALL_FISH)
	echo $(MAKELEVEL)
	echo  $(origin FISH_PATH)
else
fish: brew-packages
endif
~/.config/fish:
	@mkdir -p ~/.config/fish
~/.config/fish/config.fish: |~/.config/fish
	@echo "Installing fish config"
	@cp config/fish/config.fish ~/.config/fish/config.fish
	@echo "Installing fish functions"


chsh-fish: |fish ~/.config/fish/config.fish 
ifeq ($(shell cat /etc/shells | grep fish),)
	@echo `which fish`
	@echo `which fish` | sudo tee -a /etc/shells
endif
	@sudo chsh -s `which fish`
	$(eval SHELL := $(variable which fish))
check-fish: ~/.config/fish/config.fish chsh-fish
	@echo "Checking fish"
	@fish -v
	@echo $$SHELL
	@which fish

