# fishがインストールされていれば、fishのシェルが登録されているかチェックする
# なければ、fishをインストールする
# そして、fishのシェルを登録する
all: $(FISH_PATH) ${HOME}/.config/fish/config.fish
	$(MAKE) -e --makefile=Makefiles/fish_package.mk all

$(FISH_PATH):
	$(INSTALL_FISH)

${HOME}/.config/fish:
	@mkdir -p ${HOME}/.config/fish

${HOME}/.config/fish/config.fish: |${HOME}/.config/fish
	@cp config/fish/config.fish ${HOME}/.config/fish/config.fish

#chsh/fish: |$(FISH_PATH) ${HOME}/.config/fish/config.fish 
#ifeq ($(shell cat /etc/shells | grep fish),)
#	echo `which fish`
#	echo `which fish` | sudo tee -a /etc/shells
#endif
#	sudo chsh -s `which fish`

