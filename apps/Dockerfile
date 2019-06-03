## MDCS base container
## It contains all the apps dependencies
FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

## Arguments
ARG docker_admin

## System updates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y sudo
RUN apt-get install -y apt-utils
RUN apt-get -y update
RUN apt-get install -y build-essential
RUN apt-get install -y wget

## Create a user with no sudo password
RUN useradd -m ${docker_admin}
RUN passwd -d ${docker_admin}
RUN adduser ${docker_admin} sudo
RUN echo '${docker_admin} ALL=(ALL) NOPASSWD:ALL' >> /etc/users
USER ${docker_admin}
WORKDIR /home/${docker_admin}

## Setup the environment
COPY requirements.yml /home/${docker_admin}/requirements.yml
COPY . /home/${docker_admin}/apps
RUN sudo chown ${docker_admin}:${docker_admin} /home/${docker_admin}/apps -R
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/${docker_admin}/anaconda
RUN echo 'export PATH="/home/'${docker_admin}'/anaconda/bin:$PATH"' >> /home/${docker_admin}/.bashrc
ENV conda_path /home/${docker_admin}/anaconda

RUN ${conda_path}/bin/conda update -y conda
RUN ${conda_path}/bin/conda create -y -n mdcs python=2.7
RUN ${conda_path}/bin/conda env update -n mdcs --file /home/${docker_admin}/requirements.yml

## Build the apps
## For production: add -e .[pypi]
## These are layed out in the right order for their dependency to each other.
RUN ${conda_path}/envs/mdcs/bin/python apps/xml_utils/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/signals_utils/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/blob_utils/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_main_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_parser_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_composer_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_website_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_dashboard_common_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_explore_common_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_curate_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_dashboard_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_explore_example_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_explore_keyword_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_federated_search_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_explore_federated_search_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_oaipmh_common_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_oaipmh_harvester_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_oaipmh_provider_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_explore_oaipmh_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_exporters_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_module_blob_host_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_module_excel_uploader_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_module_periodic_table_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_module_chemical_composition_app/setup.py install
RUN ${conda_path}/envs/mdcs/bin/python apps/core_module_text_area_app/setup.py install
