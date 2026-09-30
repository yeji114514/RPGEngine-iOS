#pragma once
#include <string>
#include <vector>
namespace rpg::ruby {
struct RubyValue { enum class Type { Nil, Boolean, Integer, Float, String, Object }; Type type=Type::Nil; long long integer=0; double floating=0; bool boolean=false; std::string string; };
class RubyVMAdapter { public: virtual ~RubyVMAdapter()=default; virtual bool initialize()=0; virtual bool evaluate(const std::string&,RubyValue*)=0; virtual bool call(const std::string&,const std::string&,const std::vector<RubyValue>&,RubyValue*)=0; virtual void shutdown()=0; };
class RubyVMStub final: public RubyVMAdapter { bool initialized_=false; public: bool initialize() override; bool evaluate(const std::string&,RubyValue*) override; bool call(const std::string&,const std::string&,const std::vector<RubyValue>&,RubyValue*) override; void shutdown() override; };
}
