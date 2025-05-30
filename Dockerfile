# Stage 1: Build LLVM from source
FROM ubuntu:22.04 AS builder

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
RUN git checkout llvmorg-20.1.0

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

# Install ANTLR
WORKDIR /opt
RUN git clone https://github.com/antlr/antlr4.git

# Build from source
WORKDIR /opt/antlr4
RUN git checkout 4.13.2
RUN touch ./runtime/Cpp/LICENSE.txt
RUN cmake -B ./build ./runtime/Cpp/ \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=/usr/local/antlr
WORKDIR /opt/antlr4/build
RUN make install -j$(nproc)

# Stage 2: Create final image with LLVM and your Python tool
FROM ubuntu:22.04

# Install Python and other runtime dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip libtinfo6 zlib1g libxml2 lld

# Copy LLVM from builder
COPY --from=builder /usr/local/llvm /usr/local/llvm
COPY --from=builder /usr/local/antlr /usr/local/antlr

# Install development tools
RUN apt-get update && apt-get install -y \
    build-essential git cmake \
    default-jre ninja-build

# Install the Dragon-Runner
WORKDIR /opt
RUN git clone --depth=1 https://github.com/cmput415/Dragon-Runner.git

# We already use latest, so we should be alright
WORKDIR /opt/Dragon-Runner
RUN pip install colorama numpy flask flask_cors pytest
RUN pip install -t /usr/local/dragon-runner .

WORKDIR /

# Set environment variables
ENV PATH="/usr/local/llvm/bin:$PATH"
ENV PATH="/usr/local/dragon-runner/bin:$PATH"
ENV PYTHONPATH="/usr/local/dragon-runner:$PYTHONPATH"
ENV LD_LIBRARY_PATH="/usr/local/llvm/lib:$LD_LIBRARY_PATH"
ENV ANTLR_INS="/usr/local/antlr"
