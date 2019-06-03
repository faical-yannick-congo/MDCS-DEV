#!/bin/bash

sudo service apache2 start
sudo service postgresql start
sudo -u postgres psql -c "create user "${postgres_user}" with password '"${postgres_password}"';"
sudo -u postgres psql -c "create database "${postgres_db}";"
sudo -u postgres psql -c "grant all privileges on database "${postgres_db}" to "${postgres_user}";"
tail -f /dev/null
