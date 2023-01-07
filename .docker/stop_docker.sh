#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/config.sh

running_contis=$(docker ps --format "{{.Names}}")

if [[ "${running_contis}" == *"${name}"* ]]
then
    docker stop $name
else
    echo "No docker with name ${name} running"
fi

