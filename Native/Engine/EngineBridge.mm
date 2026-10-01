#import "EngineBridge.h"
#include <atomic>
static std::atomic<bool> running{false};
void RPGEngineStart(void) { running.store(true); }
void RPGEngineTick(double) { (void)running.load(); }
