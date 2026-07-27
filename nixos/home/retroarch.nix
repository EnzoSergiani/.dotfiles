{ pkgs, ... }:

{
  home.packages = [
    (pkgs.retroarch.withCores (cores: with cores; [
      gambatte
      mgba
      genesis-plus-gx
      parallel-n64
      fceumm
      beetle-psx-hw
      snes9x
    ]))
  ];
}
