# RPGEngine-iOS v1.0.0

## Ruby 1.9.x arm64 Runtime + Ruby C API

v1.0 is the first release whose native architecture is prepared to link a
real, statically built Ruby 1.9.x arm64 library into the iOS engine.

VX Ace RGSS3 is documented as Ruby 1.9.2-p0, and its startup flow loads and
executes `Data/Scripts.rvdata2`. citeturn0search4

mkxp-z uses an MRI binding layer to glue Ruby to the engine and supports RGSS
bindings; its repository also maintains Ruby sources. citeturn0search1turn0search3
A mobile fork demonstrates shipping multiple Ruby generations as merged object
files with a runtime selector, which is useful for our eventual multi-runtime
design. citeturn0search8

### Architecture

```text
iOS App
  |
  +-- EngineHost
  |     +-- Metal
  |     +-- Audio
  |     +-- Input
  |
  +-- VXAceProvider
  |
  +-- RGSS3Runtime
  |     |
  |     +-- RubyCAPI
  |     |     |
  |     |     +-- libruby19-ios-arm64.a
  |     |
  |     +-- Ruby Marshal
  |     +-- RGSS3 Binding
  |
  +-- RuntimeManager
  |
  +-- Game Library
```

### What v1.0 actually provides

- arm64/iOS Ruby build recipe.
- Static-library integration boundary.
- Ruby C API adapter.
- RGSS3 native runtime lifecycle.
- Ruby smoke-test source.
- Explicit iOS 16 deployment target in the build recipe.
- No runtime executable code is downloaded.

### What is NOT falsely claimed

The repository does **not** include a prebuilt `libruby19-ios-arm64.a`.
A genuine Ruby 1.9.2 iOS build requires compiling the pinned source with the
Apple SDK. The build script is therefore included, but a successful device
build still has to be performed and tested.

This is important because Ruby 1.9.x is obsolete and current build tooling
has limitations around very old Ruby versions. citeturn0search13

### Next

After the archive successfully links:

1. wire `rb_eval_string_protect` / protected calls;
2. implement Ruby Marshal object decoding;
3. load `Scripts.rvdata2`;
4. expose RGSS3 classes;
5. execute `Main Process`;
6. decode `Map001.rvdata2`;
7. render the first VX Ace map through Metal.
