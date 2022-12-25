# fishがインストールされていれば、fishのシェルが登録されているかチェックする
# なければ、fishをインストールする
# そして、fishのシェルを登録する
all:
	$(MAKE) $(FISH_PATH)
	$(MAKE) --makefile=Makefiles/fish_package.mk all
	

$(FISH_PATH):${FISH_DEPENDENCIES}
	@echo "Installing fish"
	@echo ${FISH_PATH}
	$(INSTALL_FISH)
# Dependencies for Windows
#sudo:
#	curl -s https://raw.githubusercontent.com/imachug/win-sudo/master/install.sh | sh
${HOME}/.config/fish:
	@mkdir -p ${HOME}/.config/fish
${HOME}/.config/fish/config.fish: |${HOME}/.config/fish
	@echo "Installing fish config"
	@cp config/fish/config.fish ${HOME}/.config/fish/config.fish
	@echo "Installing fish functions"

chsh/fish: |$(FISH_PATH) ${HOME}/.config/fish/config.fish 
ifeq ($(shell cat /etc/shells | grep fish),)
	echo `which fish`
	echo `which fish` | sudo tee -a /etc/shells
endif
	sudo chsh -s `which fish`

