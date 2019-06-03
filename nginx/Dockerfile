## CoRR nginx micro-service.
FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

## Arguments
ARG docker_admin

## System updates
RUN apt-get -y update
RUN apt-get install -y sudo
RUN apt-get install -y apt-utils
#RUN apt-get install -y build-essential
RUN apt-get -y update
RUN apt-get install -y curl
RUN sudo apt-get install -y nginx

## Create a user with no sudo password.
RUN useradd -m ${docker_admin}
RUN passwd -d ${docker_admin}
RUN adduser ${docker_admin} sudo
RUN echo '${docker_admin} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${docker_admin}
WORKDIR /home/${docker_admin}

# Setup environment
ENV conda_path /home/${docker_admin}/anaconda

## Configuring the container access.
EXPOSE 80
EXPOSE 443
VOLUME /etc/nginx/ssl

## Executing the services.
CMD sudo service nginx start; tail -f /dev/null
