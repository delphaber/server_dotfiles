#!/usr/bin/env bash

set -e

rm -rf backup/* bundle/*

docker build -t devcontainers-dotfiles-test .
docker run --rm -it --name "dotfiles-test" \
  --mount type=bind,source="$(pwd)",target=/root/.dotfiles \
  devcontainers-dotfiles-test

# and then run the following commands in the container:
# bash install.sh
