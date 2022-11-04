cmake_minimum_required(VERSION 3.19)
project(DV_Routing)

set(CMAKE_CXX_STANDARD 11)

add_executable(dvsim dvsim.cpp)


if(MINGW)
    target_link_libraries(dvsim ws2_32)
endif()
