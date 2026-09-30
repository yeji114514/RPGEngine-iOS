#include "RubyVMAdapter.hpp"
namespace rpg::ruby {
bool RubyVMStub::initialize(){initialized_=true;return true;}
bool RubyVMStub::evaluate(const std::string& s,RubyValue* r){if(!initialized_||s.empty())return false;if(r)r->type=RubyValue::Type::Nil;return false;}
bool RubyVMStub::call(const std::string& a,const std::string& b,const std::vector<RubyValue>&,RubyValue* r){if(!initialized_||a.empty()||b.empty())return false;if(r)r->type=RubyValue::Type::Nil;return false;}
void RubyVMStub::shutdown(){initialized_=false;}
}
