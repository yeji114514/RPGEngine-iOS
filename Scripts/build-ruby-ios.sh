#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RUBY_SRC="${RUBY_SRC:-$ROOT/Vendor/ruby}"
SDKROOT="${SDKROOT:-$(xcrun --sdk iphoneos --show-sdk-path)}"
CC="${CC:-$(xcrun --sdk iphoneos -f clang)}"
AR="${AR:-$(xcrun --sdk iphoneos -f ar)}"
OUT="$ROOT/Vendor/Ruby/ios-arm64"

mkdir -p "$OUT/lib" "$OUT/include"

if [ ! -f "$RUBY_SRC/configure" ]; then
  echo "Ruby source not found at $RUBY_SRC"
  echo "Set RUBY_SRC to a pinned Ruby 1.9.x source tree."
  exit 2
fi

cd "$RUBY_SRC"
make distclean >/dev/null 2>&1 || true

./configure \
  --host=arm-apple-darwin \
  --target=arm-apple-darwin \
  --disable-shared \
  --disable-install-doc \
  --without-gmp \
  CC="$CC" \
  CFLAGS="-arch arm64 -isysroot $SDKROOT -miphoneos-version-min=16.0" \
  LDFLAGS="-arch arm64 -isysroot $SDKROOT -miphoneos-version-min=16.0"

make -j"${JOBS:-$(sysctl -n hw.ncpu 2>/dev/null || echo 4)}"

cp libruby-static.a "$OUT/lib/libruby19-ios-arm64.a"
find include -type f -maxdepth 2 -print0 | xargs -0 -I{} cp --parents "{}" "$OUT/" 2>/dev/null || true

echo "Built: $OUT/lib/libruby19-ios-arm64.a"
