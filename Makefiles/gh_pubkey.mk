all: gh/pubkey


~/id_ed25519.pub:
	$(MAKE) -e --makefile=Makefiles/pubkey.mk all

gh:
	@$(MAKE) -e --makefile=Makefiles/gh.mk all

gh/pubkey: ~/id_ed25519.pub gh
	@$(GH_PATH) ssh-key add $<
	@touch ${EMPTY_TARGET}/$@