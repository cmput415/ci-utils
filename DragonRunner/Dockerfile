# Build the dragon runner
ARG LLVM_VERSION
ARG DRAGON_RUNNER_VERSION

FROM ghcr.io/cmput415/llvm:${LLVM_VERSION} AS llvm
FROM ubuntu:22.04

COPY --from=llvm /usr/local/llvm/bin /usr/local/llvm/bin


RUN apt-get update && apt-get install -y \
  git python3 python3-pip clang

# Install the Dragon-Runner
WORKDIR /opt
RUN git clone https://github.com/cmput415/Dragon-Runner.git

# Checkout the specified version
WORKDIR /opt/Dragon-Runner
RUN git checkout $DRAGON_RUNNER_VERSION
RUN pip install colorama numpy flask flask_cors pytest
RUN pip install -t /usr/local/dragon-runner .

WORKDIR /

ENV PATH="/usr/local/dragon-runner/bin:$PATH"
ENV PYTHONPATH="/usr/local/dragon-runner:$PYTHONPATH"
