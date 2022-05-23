#!/bin/bash

#sudo apt-get install autoconf automake libtool curl make g++ unzip
git clone -b 3.6.x https://github.com/protocolbuffers/protobuf.git
cd protobuf
git submodule update --init --recursive
./autogen.sh
./configure
make
#make check
sudo make install
sudo ldconfig
export MY_INSTALL_DIR=$HOME/.local
mkdir -p $MY_INSTALL_DIR
export PATH="$PATH:$MY_INSTALL_DIR/bin"
export PATH=$PATH:$HOME/.local/bin
#sudo apt-get install cmake
#wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-Linux-x86_64.sh
#sh cmake-linux.sh -- --skip-license --prefix=$MY_INSTALL_DIR
#rm cmake-linux.sh
#
sudo apt-get install build-essential autoconf libtool pkg-config libssl-dev
#
git clone --recurse-submodules -b v1.18.0 https://github.com/grpc/grpc
cd grpc
cd third_party/cares/cares
git fetch origin
git checkout cares-1_13_0
mkdir -p cmake/build
cd cmake/build
cmake -DCMAKE_BUILD_TYPE=Release ../..
sudo make -j4 install
rm -rf third_party/cares/cares 
cd ../../../../
cd zlib
mkdir -p cmake/build
cd cmake/build
cmake -DCMAKE_BUILD_TYPE=Release ../..
sudo make -j4 install
rm -rf third_party/zlib
cd ../../../../
cd third_party/protobuf
mkdir -p cmake/build
cd cmake/build
cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release ..
sudo make -j4 install
rm -rf third_party/protobuf
cd ../../../../
mkdir -p cmake/build
cd cmake/build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DgRPC_INSTALL=ON \
  -DgRPC_BUILD_TESTS=OFF \
  -DgRPC_CARES_PROVIDER=package \
  -DgRPC_PROTOBUF_PROVIDER=package \
  -DgRPC_SSL_PROVIDER=package \
  -DgRPC_ZLIB_PROVIDER=package \
  -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
  ../..
# in Debian8 env. still use openssl 1.0.1t version that not suppport "TSI_OPENSSL_ALPN_SUPPORT"
sed -i 's/TSI_OPENSSL_ALPN_SUPPORT 1/TSI_OPENSSL_ALPN_SUPPORT 0/g' ../../src/core/tsi/ssl_transport_security.cc
make install
#cd ../../
#cd examples/cpp/helloworld
#mkdir -p cmake/build
#cd cmake/build
#cmake ../..
#make -j
#protoc \
#    --grpc_out=./ \
#    --cpp_out=./ \
#    --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` \
#    ./manager.proto
#
#
#

