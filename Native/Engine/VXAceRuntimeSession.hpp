#pragma once
#include <string>
#include "VXAceProvider.hpp"

namespace rpg {

class VXAceRuntimeSession {
public:
    bool start(const VXAceLaunchRequest& request);
    bool tick(double deltaTime);
    bool render();
    void stop();

    bool scriptsLoaded() const { return scriptsLoaded_; }
    bool mapLoaded() const { return mapLoaded_; }

private:
    std::string gamePath_;
    bool started_ = false;
    bool scriptsLoaded_ = false;
    bool mapLoaded_ = false;
};

}
