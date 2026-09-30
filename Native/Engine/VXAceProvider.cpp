#include "VXAceProvider.hpp"
#include "GameBootPipeline.hpp"
#include <filesystem>
namespace rpg {
bool VXAceProvider::canLaunch(const std::string& p) const {
 return std::filesystem::exists(p+"/Game.ini") &&
        std::filesystem::exists(p+"/Data/Scripts.rvdata2");
}
bool VXAceProvider::launch(const std::string& p){
 GameBootPipeline boot;
 if(!boot.prepare(p)||!boot.loadScripts()||!boot.loadDatabase()||!boot.loadMap(1)||!boot.startSceneMap()){error_=boot.error();return false;}
 return true;
}}
