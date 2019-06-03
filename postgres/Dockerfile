## MDCS Postgres micro-service.
FROM ubuntu:16.04

## Arguments
ARG docker_admin
ARG postgres_user
ARG postgres_password
ARG postgres_db

## System updates
RUN apt-get -y update
RUN apt-get install -y sudo
RUN apt-get install -y apt-utils
RUN apt-get install bzip2
RUN apt-get install -y build-essential
RUN apt-get -y update
RUN apt-get install -y curl
RUN sudo apt-get install -y postgresql postgresql-contrib
RUN sudo apt-get install -y php-pgsql
RUN sudo apt-get install -y phppgadmin

## Create a user with no sudo password.
RUN useradd -m ${docker_admin}
RUN passwd -d ${docker_admin}
RUN adduser ${docker_admin} sudo
RUN echo '${docker_admin} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Create database user.
RUN useradd -m $postgres_user
RUN passwd -d $postgres_user
RUN adduser $postgres_user sudo
RUN echo '$postgres_user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${docker_admin}
WORKDIR /home/${docker_admin}
COPY setup.sh .

# Setup environment
ENV conda_path /home/${docker_admin}/anaconda

## Configuring the container access.
EXPOSE 80
EXPOSE 5432

VOLUME /var/lib/pgsql/data
VOLUME /var/www/html/phpPgAdmin/conf

ENV docker_admin ${docker_admin}
ENV postgres_user ${postgres_user}
ENV postgres_password ${postgres_password}
ENV postgres_db ${postgres_db}

## Executing the services.
CMD bash setup.sh
