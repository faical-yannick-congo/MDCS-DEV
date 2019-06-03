## MDCS Redis database micro-service.
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
RUN apt-get install -y wget
RUN apt-get install -y tar
RUN apt install make gcc libc6-dev tcl
RUN wget http://download.redis.io/redis-stable.tar.gz

## Create a user with no sudo password.
RUN useradd -m ${docker_admin}
RUN passwd -d ${docker_admin}
RUN adduser ${docker_admin} sudo
RUN echo '${docker_admin} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${docker_admin}
WORKDIR /home/${docker_admin}
COPY setup.sh .

RUN wget http://download.redis.io/redis-stable.tar.gz
RUN tar xvzf redis-stable.tar.gz
RUN cd redis-stable; sudo make install

# Setup environment
ENV conda_path /home/${docker_admin}/anaconda

## Configuring the container access.
EXPOSE 6379
EXPOSE 6380

## Executing the services.
CMD bash setup.sh
