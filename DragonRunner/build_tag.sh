#!/bin/bash
source ../VERSIONS.env
docker build --push \
  -t ghcr.io/cmput415/dragon-runner:$DRAGON_RUNNER_VERSION \
  --build-arg "DRAGON_RUNNER_VERSION=$DRAGON_RUNNER_VERSION" \
  .
