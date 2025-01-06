{ stdenv, zig }:
stdenv.mkDerivation {
  name = "phantomsync";
  src = ./src;

  buildInputs = [ zig ];

  buildPhase = ''
    zig build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp zig-out/bin/phantomsync $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "PhantomSync: Terminal Screenshot Tool";
    license = licenses.mit;
    maintainers = [ "your-github-handle" ];
  };
}

