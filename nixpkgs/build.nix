with import <nixpkgs> {};

python27.withPackages (ps: with ps; [ netifaces psutil])


    # nix-env -if build.nix