.PHONY: test-ubuntu2004 down-ubuntu2004 check-ubuntu2004 test-ubuntu2204 down-ubuntu2204 check-ubuntu2204
.SHELLFLAGS := -ec

export
UNAME := $(shell uname)
LOCAL_USER:=$(shell whoami)
LOCAL_UID:=$(shell id -u $(LOCAL_USER))
LOCAL_GID:=$(shell id -g $(LOCAL_USER))
HOME_DIR:=$(shell echo ~$(LOCAL_USER))
SHELL:=/bin/bash
MODE:="minimum"
# package path
FISH_PATH:=$(shell which fish)

# eval for each OS
ifeq ($(UNAME),Darwin)
	include Makefiles/macos.mk
else ifeq ($(UNAME),Linux)
	include Makefiles/linux.mk
else
	include Makefiles/windows.mk
	echo $(FISH_PATH)
endif

# eval VPATH
# VPATH := $(shell pwd):${PATH}
# general
all:
	@/bin/bash -c "`echo 'echo World'`"
	@echo "`whoami`test"
	@echo ${VPATH}
	@echo $$PATH
	@echo $(SHELL)

build:
	$(MAKE) check-fish
	
build/windows:
	$(MAKE) -e --makefile=Makefiles/fish.mk all

build/macos:
	$(MAKE) --makefile=Makefiles/brew.mk all
	$(MAKE) --makefile=Makefiles/fish.mk all

build/linux: |dependencies
	$(MAKE) --makefile=Makefiles/brew.mk all
	$(MAKE) --makefile=Makefiles/fish.mk all
	
inspect:
	@echo "ID: $(LOCAL_UID):$(LOCAL_GID)"
	@echo "USER: $(LOCAL_USER)"
	@echo "HOME: $(HOME_DIR)"
	@echo "UNAME: $(UNAME)"
	@echo "SHELL: $(SHELL)"
	@echo "PATH: $(PATH)"
	@echo "VPATH: $(VPATH)"
	@echo "VARIABLES: $(.VARIABLES)"
	@echo "MAKELEVEL: $(MAKELEVEL)"
	@echo "MAKEFILE_LIST: $(MAKEFILE_LIST)"
	@echo "MAKEFILES: $(MAKEFILES)"
	@echo "MAKECMDGOALS: $(MAKECMDGOALS)"
	@echo "MAKEOVERRIDES: $(MAKEOVERRIDES)"
	@echo "MAKEFLAGS: $(MAKEFLAGS)"
	@echo "MAKE_VERSION: $(MAKE_VERSION)"
	@echo "MAKE_RESTARTS: $(MAKE_RESTARTS)"

# Test
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
