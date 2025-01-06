{ pkgs, zig }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    gdb
    zig
  ];

  shellHook = ''
    echo "👻 Welcome to PhantomSync's development shell! 🌐"
  '';
}

