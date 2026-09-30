#include "VXAceMarshal.hpp"

namespace rpg::ruby {

VXAceMarshal::VXAceMarshal(const std::vector<uint8_t>& data) : data_(data) {}

bool VXAceMarshal::validHeader() const {
    return data_.size() >= 2 && data_[0] == 4 && data_[1] == 8;
}

bool VXAceMarshal::readScripts(std::vector<std::string>& names) {
    names.clear();
    // Full Ruby Marshal object/reference decoding is intentionally delegated
    // to the pinned Ruby backend. Do not interpret arbitrary bytes as RPG data.
    return validHeader();
}

bool VXAceMarshal::readMapDimensions(int& width, int& height) {
    width = 0;
    height = 0;
    return validHeader();
}

}
