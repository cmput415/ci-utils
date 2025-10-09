source ../VERSIONS.env
docker build --push -t ghcr.io/cmput415/llvm:$LLVM_VERSION .
