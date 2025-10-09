source ../VERSIONS.env
docker build --push \
  -t ghcr.io/cmput415/gaz-utils:latest \
  --build-arg "LLVM_VERSION=$LLVM_VERSION" \
  --build-arg "ANTLR_VERSION=$ANTLR_VERSION" \
  --build-arg "DRAGON_RUNNER_VERSION=$DRAGON_RUNNER_VERSION" \
  .
