# Stage 1: Build LLVM from source
FROM ubuntu:22.04 AS builder

ARG LLVM_TAG

# Install dependencies
RUN apt-get update && apt-get install -y \
    git cmake ninja-build python3 python3-pip \
    build-essential wget curl unzip \
    libxml2-dev zlib1g-dev clang lld

# Get LLVM source code
WORKDIR /opt
RUN git clone https://github.com/llvm/llvm-project.git

# Checkout the correct version
WORKDIR /opt/llvm-project
RUN git checkout $LLVM_TAG

# Create build directory
WORKDIR /opt/llvm-project/build
RUN cmake -G Ninja ../llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_PROJECTS="mlir;clang;clang-tools-extra" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_USE_LINKER=lld \
    -DCMAKE_INSTALL_PREFIX=/usr/local/llvm

# Build and install
RUN ninja -j$(nproc) && ninja install

# Stage 2: Create final image with LLVM
FROM ubuntu:22.04

# Copy LLVM from builder
COPY --from=builder /usr/local/llvm /usr/local/llvm
