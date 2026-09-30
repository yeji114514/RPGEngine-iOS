#pragma once
#include <string>

namespace rpg {
class VXAceProviderBridge {
public:
    bool validateProject(const std::string& gamePath) const;
    bool launch(const std::string& gamePath, const std::string& runtimePath);
};
}
