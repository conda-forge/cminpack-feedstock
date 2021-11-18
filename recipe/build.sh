#!/bin/bash
mkdir build
cd build

USE_BLAS=OFF
if [ ! -z "$blas_impl" ] && [ "$blas_impl" != "noblas" ]; then
  USE_BLAS=ON
fi

cmake ${CMAKE_ARGS} -G "Ninja" \
  -D CMAKE_BUILD_TYPE=RelWithDebInfo \
  -D BUILD_SHARED_LIBS:BOOL=ON \
  -D CMAKE_PREFIX_PATH=$PREFIX \
  -D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
  -D CMINPACK_LIB_INSTALL_DIR="lib" \
  -D USE_BLAS:BOOL=$USE_BLAS \
  ..

ninja
ninja install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --output-on-failure
fi
