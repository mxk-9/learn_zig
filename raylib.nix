{ pkgs, stdenv, lib, fetchTarball, ... }: let
  linux_deps = (with pkgs; [
    libxkbcommon
    wayland
    (with xorg; [
      libX11.dev
      libXi.dev
      libXcursor.dev
      libXrandr.dev
      libXinerama.dev
      libXxf86vm.dev
    ])
  ]) ++ (with pkgs; [
    libGL
  ]);
in stdenv.mkDerivation {
  name = "raylib-zig";
  version = "5.0";

  src = fetchTarball {
    url = "https://github.com/raysan5/raylib/archive/refs/tags/5.0.tar.gz";
    sha256 = "0327licmylwlh5iyzw35pq7ci2d15rp3jms5i9p0vfg1rlv2sjw0";
  };

  buildInputs = [
    pkgs.zig_0_11
  ] ++ linux_deps;

  preConfigure = ''
    export ZIG_LOCAL_CACHE_DIR=$TMPDIR/zig_local_cache
    export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig_global_cache
  '';

  buildPhase = ''
    zig build
  '';

  installPhase = ''
    mkdir $out
    cp -rf zig-out/* -t $out/
  '';

  meta = {
    description = "A simple and easy-to-use library to enjoy videogames programming ";
    homepage = "https://github.com/raysan5/raylib/";
    license = lib.licenses.zlib;
  };
}
