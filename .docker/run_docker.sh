#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/build_docker.sh

docker run -d --rm --name $name \
    --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /tmp/jenkins_keys:/keys \
    --user $(id -u) \
    --env="DISPLAY" \
    -p 8080:8080 \
    -p 50000:50000 \
    -v $(pwd)/jenkins_home:$(pwd)/jenkins_home \
    -v $(pwd)/jenkins_home/jenkins_casc.yaml:/tmp/jenkins/jenkins_casc.yaml \
    -w $(pwd)/jenkins_home \
    $dockername /bin/bash -c "export JENKINS_HOME=$(pwd)/jenkins_home; $@"
