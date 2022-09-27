FROM ubuntu:20.04
SHELL ["/bin/bash","-c"]
COPY ./Makefile /Makefile
RUN apt update && apt install -y make sudo
RUN make -f /Makefile