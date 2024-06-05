cmake -G "Ninja" -LAH ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DBUILD_SHARED_LIBS:BOOL=ON ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
  -DUSE_BLAS:BOOL=OFF ^
  -B build -S . || goto :eof

cmake --build build --config Release --target install || goto :eof

unix2dos ./examples/ref/*.ref || goto :eof
ctest --output-on-failure --test-dir build
