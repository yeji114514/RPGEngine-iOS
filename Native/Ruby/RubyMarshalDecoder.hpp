#pragma once
#include <cstdint>
#include <vector>
namespace rpg::ruby { class RubyMarshalDecoder { std::vector<uint8_t> data_; size_t cursor_=0; size_t objectCount_=0; bool header(); bool readByte(uint8_t&); public: bool decode(const std::vector<uint8_t>&); bool decodeScripts(const std::vector<uint8_t>&); size_t objectCount() const{return objectCount_;} }; }
