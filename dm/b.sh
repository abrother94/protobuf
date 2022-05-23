#!/bin/bash
export MY_INSTALL_DIR=$HOME/.local
mkdir -p $MY_INSTALL_DIR
export PATH="$PATH:$MY_INSTALL_DIR/bin"
export PATH=$PATH:$HOME/.local/bin
cd build
rm -rf *
cmake ../
make VERBOSE=1

