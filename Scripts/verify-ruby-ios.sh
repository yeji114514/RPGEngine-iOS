#!/bin/bash
set -euo pipefail
LIB="Vendor/Ruby/ios-arm64/lib/libruby19-ios-arm64.a"
test -f "$LIB"
xcrun lipo -info "$LIB"
echo "Ruby 1.9.x arm64 archive exists."
