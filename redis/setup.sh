#!/bin/bash

sudo echo never > /sys/kernel/mm/transparent_hugepage/enabled

redis-server
# /etc/rc.local
