# fishがインストールされていれば、fishのシェルが登録されているかチェックする
# なければ、fishをインストールする
# そして、fishのシェルを登録する
export
FISH_CONFIG_DIR:=${HOME}/.config/fish


all: fish/chsh ${EMPTY_TARGET}/fish/chsh
	@$(MAKE) -e --makefile=Makefiles/fish_packages.mk all

$(FISH_PATH) ${EMPTY_TARGET}/fish &:
	@$(INSTALL_FISH)
	@mkdir -p ${EMPTY_TARGET}/fish

${FISH_CONFIG_DIR}:
	@mkdir -p ${FISH_CONFIG_DIR}

${FISH_CONFIG_DIR}/config.fish: ${FISH_CONFIG_DIR} config/fish/config.fish
	@cp config/fish/config.fish ${FISH_CONFIG_DIR}/config.fish

fish/chsh ${EMPTY_TARGET}/fish/chsh &: $(FISH_PATH) ${EMPTY_TARGET}/fish ${FISH_CONFIG_DIR}/config.fish 
ifeq ($(shell cat /etc/shells | grep fish),)
	@echo `which fish` | sudo tee -a /etc/shells
endif
	@sudo chsh -s `which fish`
	@touch ${EMPTY_TARGET}/fish/chsh

