{
  description = "👻🌐 PhantomSync";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    zig-overlay.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, zig-overlay }:
    let
      # Helper function to create package for each system
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "riscv64-linux"
      ];

      # Package builder for each system
      packageFor = system: 
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in pkgs.callPackage ./nix/package.nix {
          zig = zig-overlay.packages.${system}."0.13.0";
        };
    in {
      # Packages for each system
      packages = forAllSystems (system: {
        default = packageFor system;
        phantomsync = packageFor system;  # Named package
      });

      # Development shell for each system
      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./nix/devShell.nix {
          zig = zig-overlay.packages.${system}."0.13.0";
        };
      });
    };
}
