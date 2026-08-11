{ pkgs }:
# flake.nix. e.g. this box has a GPU and does ML work:
# Or is AMD and needs some amd specific packages
with pkgs; [
  # cudaPackages.cudatoolkit
  # python311
]
