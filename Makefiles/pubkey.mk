.PHONY: all

all:~/.ssh/id_ed25519.pub

~/.ssh:
	@mkdir -p $@

~/.ssh/id_ed25519.pub: ~/.ssh
	@ssh-keygen -t ed25519
