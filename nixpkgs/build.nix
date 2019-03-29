with import <nixpkgs> {};

python27.withPackages (ps: with ps; [ netifaces psutil power])

# nix-env -if build.nix