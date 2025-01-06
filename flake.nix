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
      systems = builtins.attrNames zig.packages;
    in builtins.foldl' nixpkgs-stable.lib.recursiveUpdate {} (map (system: let
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    in {
      devShell.${system} = pkgs-stable.callPackage ./nix/devShell.nix {
        zig = zig.packages.${system}."0.13.0";
      };

      packages.${system} = pkgs-stable.callPackage ./nix/package.nix {};

      formatter.${system} = pkgs-stable.alejandra;
    }) systems);
}

