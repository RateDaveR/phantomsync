PhantomSync 👻🌐

## Usage
You can run PhantomSync directly using Nix:

```bash
# Note: while we don't have a tag you need to use
# the revison, currently in development so no tag.
nix run github:RateDaveR/phantomsync
```

Or add it to your home-manager configuration:

```nix
{
  inputs.phantomsync.url = "github:RateDaveR/phantomsync";
  
  home.packages = [
    inputs.phantomsync.packages.${pkgs.system}.default
  ];
}
```

## Development

### Prerequisites

- [x] Nix with flakes enabled

To get started:
```bash
# Clone the repository
git clone https://github.com/RateDaveR/phantomsync
cd phantomsync

# Enter development shell
nix develop
```

This will set you up with all necessary development tools including Zig 0.13.0.
