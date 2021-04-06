{ pkgs, ... }: {
  enable = true;
  package = pkgs.callPackage ./picom-ibhagwan.nix { };

  backend = "glx";
  vSync = true;

  opacityRule = [
    "80:class_i ?= 'dwm' && !focused"
    "80:class_i ?= 'dwmsystray' && !focused"
    "90:class_i ?= 'Org.gnome.Nautilus'"    
  ];

  extraOptions = ''
    corner-radius = 20.0;

    # detect-client-opacity = true;
    detect-rounded-corners = true;

    rounded-corners-exclude = [
      "class_g = 'dwm'",
      "class_g = 'dwmsystray'",
      "class_g = 'Rofi'",
      "class_g = 'Dunst'",
      "class_g = 'qutebrowser'",
      "class_g = 'SpeedCrunch'"
    ];

    # glx-no-stencil = true;
    # glx-no-rebind-pixmap = true;
    # glx-swap-method = "-1";
  '';
}