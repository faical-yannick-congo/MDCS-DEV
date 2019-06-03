## MDCS mongodb micro-service.
FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

## Arguments
ARG docker_admin

## System updates
RUN apt-get -y update
RUN apt-get install -y sudo
RUN apt-get install -y apt-utils
RUN apt-get install bzip2
RUN apt-get install -y build-essential
RUN apt-get -y update
RUN apt-get install -y curl
RUN sudo apt-get install -y mongodb

## Create a user with no sudo password.
RUN useradd -m ${docker_admin}
RUN passwd -d ${docker_admin}
RUN adduser ${docker_admin} sudo
RUN echo '${docker_admin} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${docker_admin}
WORKDIR /home/${docker_admin}

COPY mongodb.conf /home/${docker_admin}/mongodb.conf


## Configuring the container access.
EXPOSE 27017
EXPOSE 28017
VOLUME /data

RUN echo /home/${docker_admin}/mongodb.conf

## Executing the services.
ENV docker_admin ${docker_admin}
CMD sudo mongod --rest --config /home/${docker_admin}/mongodb.conf
