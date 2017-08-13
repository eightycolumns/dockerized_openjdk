#!/bin/bash

docker run \
  --interactive \
  --tty \
  --rm \
  --user openjdk \
  --volume "${PWD}:/home/openjdk/project" \
  --workdir /home/openjdk/project \
  eightycolumns/openjdk:8 \
  java "$@"
