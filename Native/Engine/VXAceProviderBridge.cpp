#include "VXAceProviderBridge.hpp"
#include <fstream>

namespace rpg {
bool VXAceProviderBridge::validateProject(const std::string& gamePath) const {
    std::ifstream scripts(gamePath + "/Data/Scripts.rvdata2", std::ios::binary);
    return static_cast<bool>(scripts);
}

bool VXAceProviderBridge::launch(const std::string& gamePath, const std::string& runtimePath) {
    if (!validateProject(gamePath)) return false;
    // Next stage: bind runtimePath to Ruby/RGSS3 EngineHost.
    return !runtimePath.empty();
}
}
