FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    cmake \
    build-essential \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings && \
    wget -O- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/keyrings/llvm.asc | gpg --dearmor -o /etc/apt/keyrings/llvm.gpg

RUN echo "deb [signed-by=/etc/apt/keyrings/llvm.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main" \
    > /etc/apt/sources.list.d/llvm.list

RUN apt-get update && apt-get install -y \
		clang-18 \
    libclang-18-dev \
    llvm-18 \
    llvm-18-dev \
    llvm-18-tools \
    libzstd-dev \
    zlib1g-dev \
    libedit-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app
