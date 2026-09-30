#pragma once
#include <string>
namespace rpg {
class GameBootPipeline {
public:
 bool prepare(const std::string& projectPath);
 bool loadScripts();
 bool loadDatabase();
 bool loadMap(int mapId);
 bool startSceneMap();
 const std::string& error() const { return error_; }
private:
 std::string projectPath_, error_;
};
}