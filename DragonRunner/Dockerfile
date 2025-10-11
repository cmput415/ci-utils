# Build the dragon runner
ARG LLVM_VERSION
ARG DRAGON_RUNNER_VERSION

FROM ghcr.io/cmput415/llvm:${LLVM_VERSION} AS llvm
FROM ubuntu:22.04

COPY --from=llvm /usr/local/llvm/bin/llc /usr/local/llvm/bin/llc
COPY --from=llvm /usr/local/llvm/bin/lli /usr/local/llvm/bin/lli
COPY --from=llvm /usr/local/llvm/bin/clang /usr/local/llvm/bin/clang


RUN apt-get update && apt-get install -y \
  git python3 python3-pip python3-venv clang

# Install the Dragon-Runner
WORKDIR /opt
RUN git clone https://github.com/cmput415/Dragon-Runner.git

# Checkout the specified version
WORKDIR /opt/Dragon-Runner
RUN git checkout $DRAGON_RUNNER_VERSION && \
    pip install --no-cache-dir --upgrade pip && \
    pip install .

RUN dragon-runner --help

WORKDIR /
