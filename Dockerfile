FROM ubuntu:latest

COPY . /rdkafka

WORKDIR /rdkafka

RUN apt-get update
RUN apt-get install -y build-essential gnupg
RUN apt-get install -y curl
RUN apt-get install -y openssl libssl-dev
RUN apt-get install -y pkg-config
RUN apt-get install -y valgrind
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y python

RUN echo "$(curl https://apt.llvm.org/llvm-snapshot.gpg.key)" | apt-key add -t

RUN echo "\ndeb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" | tee -a /etc/apt/sources.list
RUN echo "\ndeb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" | tee -a /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y lldb-8 lld-8 clang-8 llvm-8-dev libclang-8-dev

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
ENV PATH /root/.cargo/bin/:$PATH

COPY docker/run_tests.sh /rdkafka/

ENV KAFKA_HOST kafka:9092

WORKDIR /rdkafka