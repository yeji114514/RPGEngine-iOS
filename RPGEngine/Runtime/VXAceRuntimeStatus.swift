import Foundation
struct VXAceRuntimeStatus { var rubyVM=false; var marshal=false; var rgss3Binding=false; var scripts=false; var readyForRealVM: Bool { rubyVM && marshal && rgss3Binding && scripts } }
