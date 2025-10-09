source ../VERSIONS.env
docker build --push \
  -t ghcr.io/cmput415/antlr:$ANTLR_VERSION \
  --build-arg "ANTLR_VERSION=$ANTLR_VERSION" \
  .
