.PHONY: all
# fishがインストールされていれば、fishのシェルが登録されているかチェックする
# なければ、fishをインストールする
# そして、fishのシェルを登録する
export
FISH_CONFIG_DIR:=${HOME}/.config/fish

all: ${EMPTY_TARGET}/fish/chsh
	@$(MAKE) -e --makefile=Makefiles/fish_packages.mk all

$(FISH_PATH) ${EMPTY_TARGET}/fish &:
	@$(INSTALL_FISH)
	@mkdir -p ${EMPTY_TARGET}/fish

${FISH_CONFIG_DIR}:
	@ln -s ${PWD}/config/fish $@

#${FISH_CONFIG_DIR}/config.fish: ${FISH_CONFIG_DIR} config/fish/config.fish
#	@cp config/fish/config.fish ${FISH_CONFIG_DIR}/config.fish

${EMPTY_TARGET}/fish/chsh: $(FISH_PATH) ${EMPTY_TARGET}/fish ${FISH_CONFIG_DIR}
ifeq ($(shell cat /etc/shells | grep fish),)
	@echo `which fish` | sudo tee -a /etc/shells
endif
	echo ${FISH_CONFIG_DIR}
	@$(CHANGE_SHELL)
	@touch ${EMPTY_TARGET}/fish/chsh

