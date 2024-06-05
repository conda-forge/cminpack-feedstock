#!/bin/bash

cmake ${CMAKE_ARGS} -G "Ninja" -LAH \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX:PATH=$PREFIX \
  -DCMINPACK_LIB_INSTALL_DIR="lib" \
  -DUSE_BLAS=OFF \
  -B build -S .

cmake --build build --target install --parallel ${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --output-on-failure --test-dir build --output-on-failure -j ${CPU_COUNT}
fi
