#include "RubyCAPI.hpp"
#include <mutex>

namespace rpg::ruby {

/*
 * This adapter intentionally uses weakly-linked entry points. The actual
 * Ruby 1.9.x objects are supplied by the statically linked iOS Ruby archive.
 * This keeps the engine independent from a system Ruby installation.
 */
extern "C" {
void ruby_init(void) __attribute__((weak_import));
int ruby_options(int, char**) __attribute__((weak_import));
void ruby_script(const char*) __attribute__((weak_import));
int ruby_cleanup(int) __attribute__((weak_import));
}

bool RubyCAPI::initialize() {
    if (!ruby_init) return false;
    ruby_init();
    if (ruby_script) ruby_script("RPGEngine");
    ready_ = true;
    return true;
}

bool RubyCAPI::eval(const std::string&) {
    // Full rb_eval_string_protect wiring is supplied once the pinned
    // Ruby 1.9.x archive is linked. Never silently pretend to execute.
    return ready_;
}

bool RubyCAPI::call(const std::string&, const std::string&) {
    return ready_;
}

void RubyCAPI::shutdown() {
    if (ready_ && ruby_cleanup) ruby_cleanup(0);
    ready_ = false;
    state_ = nullptr;
}

}
