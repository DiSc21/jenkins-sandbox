#!/bin/bash

path=$(dirname "${BASH_SOURCE[0]}")
dockerfile=$path/Dockerfile

tag_long=$(sha256sum $dockerfile | awk '{ print $1 }')
tag=${tag_long::8}

name="jenkins_server"
if [[ -z "${BUILD_TAG}" ]]; then
  name="${name}-$('whoami')"
else
  name="${name}-${BUILD_TAG}"
fi
name="${name/\%2F/_}"

dockername="$name:$tag"
