#!/bin/sh

_BRANCH=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD);

echo "Building [boxmls/debian:$_BRANCH] image."

docker build \
  --no-cache=true \
  --tag=boxmls/debian:${_BRANCH} \
  $(readlink -f $(pwd))


