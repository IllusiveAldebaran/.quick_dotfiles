#!/bin/bash
set -e

echo "Setting up nix-user-chroot..."
if [ ! -d "$HOME/.nix" ]; then
  mkdir -m 0755 "$HOME/.nix"
fi

if ! command -v nix-user-chroot >/dev/null; then
  echo "Downloading latest nix-user-chroot (assuming x86)..."
  mkdir -p "$HOME/.local/bin"

  latest_tag="$(curl -sI -o /dev/null -w '%{redirect_url}' \
    "https://github.com/nix-community/nix-user-chroot/releases/latest" \
    | sed -E 's#.*/tag/##')"

  curl -fL \
    "https://github.com/nix-community/nix-user-chroot/releases/download/${latest_tag}/nix-user-chroot-bin-${latest_tag}-x86_64-unknown-linux-musl" \
    -o "$HOME/.local/bin/nix-user-chroot"
  # Assumed to be in PATH. This is by preference for me anyways.
  chmod +x "$HOME/.local/bin/nix-user-chroot"


fi

nix-user-chroot "$HOME/.nix" bash -c "curl -L https://nixos.org/nix/install | sh -s -- --no-daemon"

echo "Done. Open a new shell to auto-enter the chroot."
echo "Reopen again and run: nix profile add ~/.config/nix#<hosts> where <hosts> are choices of more flake configs. Choose 'common' for a basic setup"
echo "To update later, run: nix-user-chroot ~/.nix bash -c \"nix profile upgrade '.*'\""
