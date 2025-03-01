###############################################################################

ln -s $PWD/sycl/CMakePresets.json $PWD/llvm/CMakePresets.json

###############################################################################

cmake --preset linux -S$PWD/llvm -B$PWD/build

cmake --build $PWD/build --target all
cmake --build $PWD/build --target install
# cmake --build $PWD/build --target distribution
# cmake --build $PWD/build --target install-distribution

cmake --build $PWD/build --target help >_demos/cmake.target.help.log

###############################################################################

cmake --preset sycl -S$PWD/llvm -B$PWD/build-sycl
# or
cmake --preset sycl -S$PWD/llvm -B$PWD/build-sycl -DCMAKE_BUILD_TYPE=Debug

# cmake --build $PWD/build-sycl --target all
cmake --build $PWD/build-sycl --target libsycldevice
cmake --build $PWD/build-sycl --target libsycl.so
cmake --build $PWD/build-sycl --target libsycl-preview.so
cmake --build $PWD/build-sycl --target sycl-ls

cmake --build $PWD/build-sycl --target help >_demos/cmake.sycl.target.help.log

###############################################################################

# TODO: can we use `-sycl-device-library-location` in CMD ?

# find build-sycl/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} echo {}
find build-sycl/bin -name "sycl*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/bin/{} $PWD/build/bin/
find build-sycl/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
find build-sycl/lib -name "libsycl*.so*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
find build-sycl/lib -name "libsycl*.a*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
find build-sycl/lib -name "libOpenCL*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
ln -s $PWD/build-sycl/include/CL $PWD/build/include/
ln -s $PWD/build-sycl/include/sycl* $PWD/build/include/
ln -s $PWD/build-sycl/include/ur* $PWD/build/include/

# TODO: add libs into $PWD/build/install
# OR
# -isystem $PPWD/build-sycl/include -L$PPWD/build-sycl/lib

###############################################################################
