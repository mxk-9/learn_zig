{
  description = "A very basic flake";
  # zig cc -target x86_64-linux-musl -static -O3 hello.c

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # zig-binaries.url = "github:mitchellh/zig-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      raylib-zig = import ./raylib.nix {
        pkgs = pkgs;
        stdenv = pkgs.stdenv;
        lib = pkgs.lib;
        fetchTarball = builtins.fetchTarball;
      };

      buildInputs = (with pkgs; [
        zig
        xorg.libX11
        libGLX
      ]) ++ [ raylib-zig ];
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        name = "rayzig";
        src = ./.;

        inherit buildInputs;

        preConfigure = ''
          export ZIG_LOCAL_CACHE_DIR=$TMPDIR/zig_local_cache
          export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig_global_cache
        '';

        buildPhase = ''
          zig build
        '';

        postFixup = ''
          patchelf \
            --add-needed ${pkgs.xorg.libX11}/lib/libX11.so \
            --add-needed ${pkgs.libGLX}/lib/libGLX.so \
            $out/bin/rayzig
        '';

        installPhase = ''
          mkdir -p $out/
          cp -r zig-out/* $out/
        '';

        meta = {
          mainProgram = "rayzig";
        };
      };

      package = self.packages.${system}.default;

      devShells.default = pkgs.mkShell {
        buildInputs = buildInputs ++ [ pkgs.zls ];
      };
      
      devShell = self.devShells.${system}.default;
    });
}
