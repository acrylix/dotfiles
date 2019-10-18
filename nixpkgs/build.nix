with import <nixpkgs> {};

# deps for bumblebee bar
python3.withPackages (ps: with ps; [ netifaces requests psutil power dbus-python pygobject3])

# nix-env -if build.nix