#!/bin/bash
set -e

if [ ! -d "$HOME/.nix" ]; then
  echo "Setting up nix-user-chroot..."
  mkdir -m 0755 "$HOME/.nix"

  if ! command -v nix-user-chroot >/dev/null; then
    echo "Install nix-user-chroot first (grab a release binary from"
    echo "https://github.com/nix-community/nix-user-chroot/releases,"
    echo "or 'cargo install' it) and put it on your PATH."
    exit 1
  fi

  nix-user-chroot "$HOME/.nix" bash -c "curl -L https://nixos.org/nix/install | sh -s -- --no-daemon"
fi

echo "Installing packages from flake..."
nix-user-chroot "$HOME/.nix" bash -c 'nix profile add ~/.config/nix#personalLaptop'

echo "Done. Open a new shell to auto-enter the chroot."
echo "To update later, run: nix-user-chroot ~/.nix bash -c \"nix profile upgrade '.*'\""
