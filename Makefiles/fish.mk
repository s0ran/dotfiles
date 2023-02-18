.PHONY: all
# fishがインストールされていれば、fishのシェルが登録されているかチェックする
# なければ、fishをインストールする
# そして、fishのシェルを登録する
export
FISH_CONFIG_DIR:=${HOME}/.config/fish

config/fish:

all: ${EMPTY_TARGET}/fish/chsh
	@$(MAKE) -e --makefile=Makefiles/fish_packages.mk all

$(FISH_PATH) ${EMPTY_TARGET}/fish &:
	@$(INSTALL_FISH)
	@mkdir -p ${EMPTY_TARGET}/fish

${EMPTY_TARGET}/fish/chsh: $(FISH_PATH) ${EMPTY_TARGET}/fish
ifeq ($(shell cat /etc/shells | grep fish),)
ifeq ($(UNAME),$(filter $(UNAME),Darwin Linux))
	@echo `which fish` | sudo tee -a /etc/shells
else
	@echo `which fish` | tee -a /etc/shells
endif
endif
	@$(CHANGE_SHELL)
	@touch ${EMPTY_TARGET}/fish/chsh

