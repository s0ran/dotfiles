.PHONY: all

all: gh/auth

$(GH_PATH):
	@$(INSTALL_GH)

gh: $(GH_PATH)
	@touch ${EMPTY_TARGET}/$@

gh/auth: gh
	@$(GH_PATH) auth login
	@touch ${EMPTY_TARGET}/$@