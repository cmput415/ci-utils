source ../VERSIONS.env
docker build --push \
  -t ghcr.io/cmput415/llvm:$LLVM_VERSION \
  --build-arg "LLVM_TAG=$LLVM_TAG" \
  .
