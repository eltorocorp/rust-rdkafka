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

RUN apt-key add llvm-snapshot.gpg.key

RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" >> /etc/apt/sources.list


RUN apt-get update
RUN apt-get install -y lldb-8 lld-8 clang-8


RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
ENV PATH /root/.cargo/bin/:$PATH

# # Create dummy project for rdkafka
# COPY Cargo.toml /rdkafka/
# RUN mkdir -p /rdkafka/src && echo "fn main() {}" > /rdkafka/src/main.rs
#
# # Create dummy project for rdkafka
# RUN mkdir /rdkafka/rdkafka-sys
# COPY rdkafka-sys/Cargo.toml /rdkafka/rdkafka-sys
# RUN mkdir -p /rdkafka/rdkafka-sys/src && touch /rdkafka/rdkafka-sys/src/lib.rs
# RUN echo "fn main() {}" > /rdkafka/rdkafka-sys/build.rs
#
# RUN cd /rdkafka && test --no-run
