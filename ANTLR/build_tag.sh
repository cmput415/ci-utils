source ../VERSIONS.env
docker build --push -t ghcr.io/cmput415/antlr:$ANTLR_VERSION .
