#pragma once
#include <string>
namespace rpg {
class VXAceProvider {
public:
 bool canLaunch(const std::string& projectPath) const;
 bool launch(const std::string& projectPath);
 const std::string& error() const { return error_; }
private: std::string error_;
};
}