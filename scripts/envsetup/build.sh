#!/usr/bin/env bash
#
# Cross-compile the envsetup TUI into committed, LFS-tracked binaries.
#
# Run this whenever main.go or go.mod changes, then commit scripts/envsetup/bin/.
# install.sh selects the binary matching the host's OS/arch at install time.
#
# Output: bin/envsetup-{darwin,linux}-{amd64,arm64}
set -euo pipefail

# Pin the toolchain so every maintainer produces identical builds. Go's
# toolchain mechanism auto-downloads this if it isn't already present.
export GOTOOLCHAIN="go1.25.11"

# Pure-Go (no cgo) -> trivial, fully static cross-compilation.
export CGO_ENABLED=0

SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$SCRIPT_DIR"

OUT_DIR="bin"
mkdir -p "$OUT_DIR"

# -trimpath: reproducible paths. -s -w: strip symbol/debug info to shrink size.
LDFLAGS="-s -w"

targets=(
    "darwin/amd64"
    "darwin/arm64"
    "linux/amd64"
    "linux/arm64"
)

echo "Building envsetup with $(go version)"
for target in "${targets[@]}"; do
    os="${target%%/*}"
    arch="${target##*/}"
    out="$OUT_DIR/envsetup-$os-$arch"
    echo "  -> $out"
    GOOS="$os" GOARCH="$arch" go build -trimpath -ldflags="$LDFLAGS" -o "$out" .
done

echo "Done. Binaries in $SCRIPT_DIR/$OUT_DIR:"
ls -lh "$OUT_DIR"
