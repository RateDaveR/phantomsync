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
    in {
      packages = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./nix/package.nix {
          zig = zig-overlay.packages.${system}."0.13.0";
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./nix/devShell.nix {
          zig = zig-overlay.packages.${system}."0.13.0";
        };
      });
    };
}
