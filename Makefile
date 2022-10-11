.PHONY: test-ubuntu2004 check-ubuntu2004 test-ubuntu2204 check-ubuntu2204

UNAME := $(shell uname)

all:
	@echo test

build:
	@echo ${UNAME}
	sudo apt install -y build-essential

test-ubuntu2004:
	docker build -f test/ubuntu2004/Dockerfile . -ttest_ubuntu2004 --no-cache

check-ubuntu2004:
	docker run -it test_ubuntu2004 bash

test-ubuntu2204:
	docker build -f test/ubuntu2204/Dockerfile . -ttest_ubuntu2004 --no-cache

check-ubuntu2204:
	docker run -it test_ubuntu2204 bash