let rustEnv =
{ stdenv, llvm, ncurses, binutils, cmake, which, libffi, rustPlatform }:
  let llvmShared = llvm.override { enableSharedLibraries = true; };
  in stdenv.mkDerivation {
    name = "myEnv";

    src = ./empty;

    buildInputs = [
      rustPlatform.rust
      cmake which libffi ncurses llvmShared
     ];
  };
  pkgs = import <nixpkgs> {
    overlays = [
      (import /etc/nixos/overlays/nixpkgs-mozilla/rust-overlay.nix)
    ];
  };
in pkgs.callPackage rustEnv { rustPlatform = pkgs.rustChannels.beta; }
