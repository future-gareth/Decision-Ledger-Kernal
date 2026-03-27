#!/usr/bin/env bash
# One-time: install Go on an app server (for building/running the kernel).
# Run on the server as root: bash install-dld-server-deps.sh
# Or: ssh root@HOST 'bash -s' < scripts/install-dld-server-deps.sh
set -e
echo "Installing Go 1.21..."
rm -rf /usr/local/go
ARCH=$(uname -m)
case "$ARCH" in
  x86_64)   GOARCH=amd64 ;;
  aarch64|arm64) GOARCH=arm64 ;;
  armv6l|armv7l) GOARCH=armv6l ;;
  i686|i386) GOARCH=386 ;;
  *) echo "Unsupported arch: $ARCH"; exit 1 ;;
esac
GO_TAR="go1.21.13.linux-${GOARCH}.tar.gz"
wget -q "https://go.dev/dl/${GO_TAR}" -O /tmp/go.tar.gz
tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile.d/go.sh
export PATH="$PATH:/usr/local/go/bin"
echo "Verifying..."
go version
echo "Done."
