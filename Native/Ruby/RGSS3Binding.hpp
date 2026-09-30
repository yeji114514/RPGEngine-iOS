#pragma once
#include "RubyVMAdapter.hpp"
namespace rpg::rgss3 { class RGSS3Binding { RubyVMAdapter* vm_=nullptr; public: bool initialize(RubyVMAdapter&); bool installGraphics(); bool installInput(); bool installAudio(); bool installBitmap(); bool installSprite(); bool installViewport(); bool installWindow(); }; }
