{ pkgs, zig }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    gdb
    zig
  ];

  shellHook = ''
    echo "👻 bingbong 🌐"
  '';
}

