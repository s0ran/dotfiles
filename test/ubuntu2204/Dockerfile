FROM ubuntu:22.04
SHELL ["/bin/bash","-c"]
COPY ./Makefile /Makefile
COPY ./Makefiles /Makefiles
RUN echo $PATH
RUN apt update && apt install -y make sudo
RUN make build