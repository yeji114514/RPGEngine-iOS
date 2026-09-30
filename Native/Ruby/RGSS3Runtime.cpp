#include "RGSS3Runtime.hpp"
#include "RubyRuntimeBackend.hpp"

namespace rpg::ruby {

bool RGSS3Runtime::initialize(const std::string& gamePath) {
    gamePath_ = gamePath;
    return ruby_.initialize();
}

bool RGSS3Runtime::loadScripts(const std::string& scriptsPath) {
    // Scripts.rvdata2 is parsed by the Ruby-side Marshal loader after the VM
    // is initialized. This method is the native lifecycle boundary.
    return !scriptsPath.empty() && ruby_.isReady();
}

bool RGSS3Runtime::runMain() {
    // Main Process invocation will call Kernel/load + the decoded RGSS3 script
    // sections. The actual Ruby 1.9 C API is required for execution.
    return ruby_.isReady();
}

void RGSS3Runtime::update(double deltaTime) {
    (void)deltaTime;
}

void RGSS3Runtime::shutdown() {
    ruby_.shutdown();
    gamePath_.clear();
}

}
