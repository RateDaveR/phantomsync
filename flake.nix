{
  description = "👻🌐";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, nixpkgs-stable, zig, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
      pkgsFor = system: import nixpkgs-stable {
        system = system;
      };
    in {
      packages = builtins.listToAttrs (map (system: {
        name = system;
        value = (pkgsFor system).callPackage ./nix/package.nix {
          zig = zig.packages.${system}."0.13.0";
        };
      }) systems);

      devShells = builtins.listToAttrs (map (system: {
        name = system;
        value = (pkgsFor system).mkShell {
          buildInputs = [ zig.packages.${system}."0.13.0" ];
        };
      }) systems);
    };
}

