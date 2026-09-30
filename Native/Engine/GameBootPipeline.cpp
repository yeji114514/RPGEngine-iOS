#include "GameBootPipeline.hpp"
#include "RubyRuntime.hpp"
#include "MapRuntime.hpp"
#include <filesystem>
namespace rpg {
static RubyRuntime ruby;
static MapRuntime mapRuntime;
bool GameBootPipeline::prepare(const std::string& p){ projectPath_=p; if(!std::filesystem::exists(p)){error_="project missing";return false;} return true; }
bool GameBootPipeline::loadScripts(){ if(!ruby.initialize(projectPath_)) {error_="Ruby runtime init failed";return false;} if(!ruby.loadScripts(projectPath_+"/Data/Scripts.rvdata2")){error_="Scripts.rvdata2 unavailable";return false;} return ruby.executeScripts(); }
bool GameBootPipeline::loadDatabase(){ return true; }
bool GameBootPipeline::loadMap(int id){ std::string f=projectPath_+"/Data/Map"+(id<10?"00":id<100?"0":"")+std::to_string(id)+".rvdata2"; if(!mapRuntime.load(f)){error_="Map data unavailable";return false;} return true; }
bool GameBootPipeline::startSceneMap(){ return true; }
}