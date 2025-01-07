{ lib
, stdenv
, zig
}:

stdenv.mkDerivation {
  pname = "phantomsync";
  version = "0.0.1";
  src = ../.;

  nativeBuildInputs = [ zig ];

  dontConfigure = true;

  # Let's simplify the build to just use basic options
  buildPhase = ''
    # Set basic environment
    export HOME=$TMPDIR

    # Run zig build
    zig build \
      -Doptimize=ReleaseSafe \
      -Dtarget=native-native-gnu
  '';

  installPhase = ''
    mkdir -p $out/bin
    # Debug: Show us where the binary might be
    find . -type f -name "phantomsync"
    # Try both possible locations
    if [ -f "zig-out/bin/phantomsync" ]; then
      cp zig-out/bin/phantomsync $out/bin/
    elif [ -f "bin/phantomsync" ]; then
      cp bin/phantomsync $out/bin/
    else
      echo "Contents of current directory:"
      ls -R
      echo "Failed to find phantomsync binary"
      exit 1
    fi
  '';

  meta = with lib; {
    description = "👻🌐 PhantomSync CLI";
    homepage = "https://github.com/your-username/phantomsync";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "phantomsync";
  };
}
