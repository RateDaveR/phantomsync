{ stdenv, zig, ... }:

stdenv.mkDerivation {
  name = "phantomsync";
  src = ./.;

  buildInputs = [ zig ];

  buildPhase = ''
    zig build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp zig-out/bin/phantomsync $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "PhantomSync: A platform for managing terminal activity.";
    license = licenses.mit;
    maintainers = [ "RateDaveR" ];
  };
}

