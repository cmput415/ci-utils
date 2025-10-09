# Stage 1: Build LLVM from source
ARG LLVM_VERSION
ARG ANTLR_VERSION
ARG DRAGON_RUNNER_VERSION

FROM ghcr.io/cmput415/llvm:${LLVM_VERSION} AS llvm
FROM ghcr.io/cmput415/antlr:${ANTLR_VERSION} AS antlr

# Stage 2: Create final image with LLVM and your Python tool
FROM ubuntu:22.04

# Install Python and other runtime dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip libtinfo6 zlib1g libxml2 lld

# Copy LLVM and ANTLR from respective images
COPY --from=llvm /usr/local/llvm /usr/local/llvm
COPY --from=antlr /usr/local/antlr /usr/local/antlr

# Install development tools
RUN apt-get update && apt-get install -y \
    build-essential git cmake \
    default-jre ninja-build

# Install the Dragon-Runner
WORKDIR /opt
RUN git clone https://github.com/cmput415/Dragon-Runner.git

# Checkout the specified version
WORKDIR /opt/Dragon-Runner
RUN git checkout $DRAGON_RUNNER_VERSION
RUN pip install colorama numpy flask flask_cors pytest
RUN pip install -t /usr/local/dragon-runner .

WORKDIR /

# Set environment variables
ENV PATH="/usr/local/llvm/bin:$PATH"
ENV PATH="/usr/local/dragon-runner/bin:$PATH"
ENV PYTHONPATH="/usr/local/dragon-runner:$PYTHONPATH"
ENV LD_LIBRARY_PATH="/usr/local/llvm/lib:$LD_LIBRARY_PATH"
ENV ANTLR_INS="/usr/local/antlr"
