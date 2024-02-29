# Dockerfile - TENSORFLOW-FROM-SOURCE

FROM ubuntu:22.04

ENV PYTHONUNBUFFERED=1

RUN mkdir /tf_wheel

WORKDIR /tf_builder

COPY script_tf_from_source.sh /tf_builder/

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*
    
# Python-3
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    add-apt-repository ppa:deadsnakes/ppa

RUN apt-get install -y \
    git \
    wget \
    python-is-python3 \
    python3-pip \
    python3-dev \
    patchelf && rm -rf /var/lib/apt/lists/* && \
    echo 'export PATH="$PATH:/home/sysop/.local/bin"' >> ~/.bashrc

# Bazelisk
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64 && \
    chmod +x bazelisk-linux-amd64 && \
    mv bazelisk-linux-amd64 /usr/local/bin/bazel && \
    echo 'export PATH=/usr/local/bin/bazel:$PATH' >> ~/.bashrc

# Clang-16
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 16 && \
    rm llvm.sh

# Dependences
RUN pip install -U  pip numpy wheel packaging requests opt_einsum
RUN pip install -U  keras_preprocessing --no-deps


CMD ["./script_tf_from_source.sh"]

