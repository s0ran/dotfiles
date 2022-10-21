.PHONY: test-ubuntu2004 down-ubuntu2004 check-ubuntu2004 test-ubuntu2204 down-ubuntu2204 check-ubuntu2204

UNAME := $(shell uname)
PACKAGE_MANAGER = $(shell if [ "$(UNAME)" = "Darwin" ]; then echo "brew"; else echo "apt-get"; fi)
BREW_SRC := $(shell if [ "$(UNAME)" = "Darwin" ]; then echo "curl"; else echo "ruby curl build-essential git"; fi)
HOMEBREW_PREFIX := $(shell if [ "$(UNAME)" = "Darwin" ]; then echo "/opt/homebrew"; else echo "/home/linuxbrew/.linuxbrew"; fi)
GLOBAL_PATH:= $(shell echo "$$PATH")
VPATH := $(shell pwd):${GLOBAL_PATH}
LOCAL_USER:=$(shell whoami)
LOCAL_UID:=$(shell id -u $(LOCAL_USER))
LOCAL_GID:=$(shell id -g $(LOCAL_USER))


build:
	@echo ${UNAME}

all:
	@/bin/bash -c "`echo 'echo World'`"
	@echo "`whoami`test"
	@echo ${VPATH}
	@echo $$PATH

git:
	@echo "Installing git"
	@sudo apt install -y git

build-essential:
	@echo "Installing build-essential"
	@sudo apt install -y build-essential

curl:
	@echo "Installing curl"
	@sudo apt install -y curl

ruby:
	@echo "Installing ruby"
	@sudo apt install -y ruby

ruby-old: build-essential curl
	@curl -# -O https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.8.tar.bz2
	@tar xf ruby-2.6.8.tar.bz2
	@cd ruby-2.6.8 \
	&& RUBY_VERSION="2.6.8" \
	&& PREFIX=/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby \
	&& INSTALL_DIR=${PREFIX}/${RUBY_VERSION} \
	&& ./configure --prefix=${INSTALL_DIR} --enable-load-relative --with-static-linked-ext --with-out-ext=tk,sdbm,gdbm,dbm --without-gmp --disable-install-doc 	--disable-install-rdoc --disable-dependency-tracking \
	&& make \
	&& make install
	@cd ${PREFIX} \
	&& ln -s ${RUBY_VERSION} current \
	&& PATH=${PREFIX}/current/bin:${PATH}

brew: ${BREW_SRC}
	echo "Installing brew"
	/bin/bash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh`"
	export PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:$$PATH
	echo $$PATH

choco:
	@echo "Installing choco"
	@powerline -Command {Set-ExecutionPolicy Bypass -Scope Process -Force\; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072\; iex \(\(New-Object System.Net.WebClient\).DownloadString\('https://chocolatey.org/install.ps1'\)\)}

brew-old: ${BREW_SRC}
	@echo "Installing brew"
	@mkdir -p /home/linuxbrew/.linuxbrew
	@cd /home/linuxbrew/.linuxbrew/ \
	&& @sudo git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew \
	&& @sudo mkdir /home/linuxbrew/.linuxbrew/bin \
	&& @sudo ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin \
	&& @eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)


#	sudo apt install -y build-essential
test-ubuntu2004:
	docker build -f test/ubuntu2004/Dockerfile . -ttest_ubuntu2004
	docker run -v $(shell pwd):/home/docker -e LOCAL_UID=${LOCAL_UID} -e LOCAL_GID=${LOCAL_GID} --name test_ubuntu2004 -itd test_ubuntu2004 /bin/bash

down-ubuntu2004:
	docker stop test_ubuntu2004
	docker rm test_ubuntu2004

check-ubuntu2004:
	docker exec -it test_ubuntu2004 bash

test-ubuntu2204:
	docker build -f test/ubuntu2204/Dockerfile . -ttest_ubuntu2004 --no-cache --progress=plain
	docker run -dit -v $(shell pwd):/home/docker --name test_ubuntu2204 test_ubuntu2004 bash

down-ubuntu2204:
	docker stop test_ubuntu2204
	docker rm test_ubuntu2204

check-ubuntu2204:
	docker exec -it test_ubuntu2204 bash
