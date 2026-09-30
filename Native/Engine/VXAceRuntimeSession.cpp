#include "VXAceRuntimeSession.hpp"
#include <fstream>

namespace rpg {

bool VXAceRuntimeSession::start(const VXAceLaunchRequest& request) {
    gamePath_ = request.gamePath;
    std::ifstream scripts(gamePath_ + "/Data/Scripts.rvdata2", std::ios::binary);
    std::ifstream map(gamePath_ + "/Data/Map001.rvdata2", std::ios::binary);
    scriptsLoaded_ = static_cast<bool>(scripts);
    mapLoaded_ = static_cast<bool>(map);
    started_ = scriptsLoaded_ && mapLoaded_;
    return started_;
}

bool VXAceRuntimeSession::tick(double) { return started_; }
bool VXAceRuntimeSession::render() { return started_; }

void VXAceRuntimeSession::stop() {
    started_ = false;
    scriptsLoaded_ = false;
    mapLoaded_ = false;
    gamePath_.clear();
}

}
