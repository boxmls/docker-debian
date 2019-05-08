#!/bin/sh

echo "Building [boxmls/debian] image."

docker build \
  --tag=boxmls/debian \
  $(readlink -f $(pwd))

