# Stage 1: Build LLVM from source
FROM ubuntu:22.04 AS builder

ARG ANTLR_VERSION

# Install dependencies
RUN apt-get update && apt-get install -y \
    git cmake ninja-build python3 python3-pip \
    build-essential wget curl unzip \
    libxml2-dev zlib1g-dev clang lld

# Install ANTLR
WORKDIR /opt
RUN git clone https://github.com/antlr/antlr4.git

# Build from source
WORKDIR /opt/antlr4
RUN git checkout $ANTLR_VERSION
RUN touch ./runtime/Cpp/LICENSE.txt
RUN cmake -B ./build ./runtime/Cpp/ \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=/usr/local/antlr
WORKDIR /opt/antlr4/build
RUN make install -j$(nproc)

FROM ubuntu:22.04

# Copy ANTLR from builder
COPY --from=builder /usr/local/antlr /usr/local/antlr
