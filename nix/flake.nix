{
  description = "Set of programs/dependencies for different servers. Not for root but instead for nix-user-chroot";

  inputs = {
    # Pin added to have the same pacakge
    # Version is too old for some stuff. Like NVIM 0.9.5
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    # Could cherry pick out of date packages and stay on stable,
    # but willing to risk breaking with unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # TODO: test "aarch64-linux"
      pkgs = import nixpkgs {
        inherit system;
        # claude-code necessary
        config.allowUnfree = true;
      };

      common = with pkgs; [
        ripgrep
        fd
        fzf
        htop
        apptainer
        cargo
        rustc
        rust-analyzer
        neovim
        git
        delta
        ncdu
        tmux
        jq
        htmlq
        tree
        openssh
        mosh
        wget
        curl
        rsync
        conda # just uses conda install script btw
        shellcheck
        fastfetch
        cmatrix
        nodejs
        tree-sitter
        claude-code # now we're vibing (im kms)
      ];

      # Tag on server specific packages... just use #common if you can
      mkHostEnv = name: pkgs.buildEnv {
        name = "${name}-tools";
        paths = common ++ (import ./hosts/${name}.nix { inherit pkgs; });
      };
    in {
      packages.${system} = {
        common = pkgs.buildEnv {
          name = "common-tools";
          paths = common;
        };
        personalLaptop = mkHostEnv "personalLaptop";
      };
    }; 
}
