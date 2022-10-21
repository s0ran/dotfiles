FROM ubuntu:20.04
SHELL ["/bin/bash","-c"]
RUN useradd -m -s /bin/bash -G sudo docker
WORKDIR /home/docker
COPY ./Makefile /home/docker/Makefile
COPY ./test/entrypoint/docker_user.sh /usr/local/bin/docker_user.sh
ENTRYPOINT ["/bin/bash","/usr/local/bin/docker_user.sh"]
RUN chmod +x /usr/local/bin/docker_user.sh
RUN echo $PWD
RUN apt update && apt install -y make sudo
RUN make build
CMD "bash"