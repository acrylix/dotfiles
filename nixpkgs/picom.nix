{ pkgs, ... }: {
  enable = true;
  package = pkgs.callPackage ./picom-ibhagwan.nix { };

  backend = "glx";
  vSync = true;

  extraOptions = ''
    corner-radius = 20.0;

    # detect-client-opacity = true;
    detect-rounded-corners = true;

    rounded-corners-exclude = [
      "class_g = 'dwm'",
      "class_g = 'dwmsystray'",
      "class_g = 'Rofi'",
      "class_g = 'Dunst'"
    ];

    # glx-no-stencil = true;
    # glx-no-rebind-pixmap = true;
    # glx-swap-method = "-1";
  '';
}