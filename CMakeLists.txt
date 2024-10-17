cmake_minimum_required(VERSION 3.26...3.30)
project(example)

find_package(libB REQUIRED)

add_executable(test)
target_sources(test PRIVATE main.cpp)
target_link_libraries(test PRIVATE libB::B)
