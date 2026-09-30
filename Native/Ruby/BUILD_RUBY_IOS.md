# Ruby 1.9.x arm64 iOS build

VX Ace RGSS3 targets Ruby 1.9.2-p0. citeturn0search4
mkxp-z's MRI binding architecture is the reference for embedding Ruby into the
engine; its current tree also maintains a Ruby source fork. citeturn0search1turn0search3
An Apple-mobile mkxp-z fork demonstrates a practical pattern of building Ruby
versions into object archives and selecting the active Ruby at runtime. citeturn0search8

This project intentionally pins a Ruby source revision rather than downloading
an arbitrary Ruby binary at runtime.

## Required output

```text
Vendor/Ruby/ios-arm64/
  include/
  lib/
    libruby19-ios-arm64.a
```

The archive must be built from the selected Ruby 1.9.x source with:
- iOS SDK
- arm64
- static library
- no executable launcher
- no dynamic runtime download

## Build model

```text
Ruby source
   |
configure / patch
   |
clang -arch arm64 -isysroot iphoneos
   |
libruby19-ios-arm64.a
   |
RubyCAPI
   |
RGSS3Runtime
```

## Important

Ruby 1.9.2 is obsolete. Modern Ruby build tooling does not guarantee a clean
arm64/iOS build for it; even current Ruby version managers report old 1.9
build limitations. citeturn0search13

Do not claim a successful v1.0 binary until the archive is actually produced
and the on-device smoke tests pass.
