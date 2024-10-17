FROM fedora:latest

RUN dnf install -y \
    cmake gcc-c++ ninja-build

COPY . /example

WORKDIR /example

# Try to build and install libA as static
RUN <<EOF
cmake -G Ninja -S libA -B build-libA-static -DLIBA_SHARED_LIBS=OFF
cmake --build build-libA-static
cmake --install build-libA-static --prefix install-libA-static
EOF

# Try to build and install libA as shared
RUN <<EOF
cmake -G Ninja -S libA -B build-libA-shared -DLIBA_SHARED_LIBS=ON
cmake --build build-libA-shared
cmake --install build-libA-shared --prefix install-libA-shared
EOF

# Try to build and install libB as shared (linked statically to libA)
RUN <<EOF
cmake -G Ninja -S libB -B build-libB-shared -DLIBA_SHARED_LIBS=OFF -DLIBB_SHARED_LIBS=ON
cmake --build build-libB-shared
cmake --install build-libB-shared --prefix install-libB-shared
EOF

# Try to use the shared library
RUN <<EOF
cmake -G Ninja -S . -B build-use-libB-shared -DLIBB_ROOT=$(pwd)/install-libB-shared
cmake --build build-use-libB-shared
./build-use-libB-shared/test
EOF

# Try to build and install libB as static (linked statically to libA)
RUN <<EOF
cmake -G Ninja -S libB -B build-libB-static -DLIBA_SHARED_LIBS=OFF -DLIBB_SHARED_LIBS=OFF
cmake --build build-libB-static
cmake --install build-libB-static --prefix install-libB-static
EOF

# Try to use the static library
RUN <<EOF
cmake -G Ninja -S . -B build-use-libB-static -DLIBB_ROOT=$(pwd)/install-libB-static
cmake --build build-use-libB-static
./build-use-libB-static/test
EOF
