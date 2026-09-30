#pragma once
#include <string>
#include <cstdint>

extern "C" {
struct ruby_state;
typedef uintptr_t VALUE;
}

namespace rpg::ruby {

class RubyCAPI {
public:
    bool initialize();
    bool eval(const std::string& source);
    bool call(const std::string& receiver, const std::string& method);
    void shutdown();
    bool isReady() const { return ready_; }

private:
    ruby_state* state_ = nullptr;
    bool ready_ = false;
};

}
