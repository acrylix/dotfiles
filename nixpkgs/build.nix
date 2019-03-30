with import <nixpkgs> {};

# deps for bumblebee bar
python27.withPackages (ps: with ps; [ netifaces psutil power ])

# nix-env -if build.nix