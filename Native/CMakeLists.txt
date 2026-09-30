cmake_minimum_required(VERSION 3.20)
project(RPGEngineCore LANGUAGES CXX OBJCXX)
add_library(rpgenginecore STATIC
 Engine/EngineHost.cpp Engine/GraphicsBackend.cpp Engine/AudioBackend.cpp Engine/InputBackend.cpp Engine/RubyRuntime.cpp Engine/RGSSBridge.cpp Engine/MapRuntime.cpp
 Ruby/RubyRuntimeBackend.cpp Ruby/RubyMarshal.cpp Ruby/RubyVMAdapter.cpp Ruby/RubyMarshalDecoder.cpp Ruby/RGSS3Binding.cpp Ruby/RGSS3Runtime.cpp
 Platform/iOS/MetalGraphicsBackend.mm)
target_include_directories(rpgenginecore PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_features(rpgenginecore PRIVATE cxx_std_17)
