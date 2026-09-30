#pragma once
#include <memory>
#include <string>
#include "RubyCAPI.hpp"

namespace rpg::ruby {

class RGSS3Runtime {
public:
    bool initialize(const std::string& gamePath);
    bool loadScripts(const std::string& scriptsPath);
    bool runMain();
    void update(double deltaTime);
    void shutdown();

    bool rubyReady() const { return ruby_.isReady(); }

private:
    std::string gamePath_;
    RubyCAPI ruby_;
};

}
