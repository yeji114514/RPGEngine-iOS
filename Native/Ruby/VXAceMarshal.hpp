#pragma once
#include <cstdint>
#include <string>
#include <vector>

namespace rpg::ruby {

class VXAceMarshal {
public:
    explicit VXAceMarshal(const std::vector<uint8_t>& data);
    bool validHeader() const;
    bool readScripts(std::vector<std::string>& names);
    bool readMapDimensions(int& width, int& height);

private:
    const std::vector<uint8_t>& data_;
};

}
