{ config, pkgs, lib, ... }:

let
  srandrd = import ./srandrd;
in
{
  programs.home-manager = {
    enable = true;
    path = "/home/michael/.home-manager";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # system
    gcc8
    acpi
    protobuf

    dunst    
    # (dunst.override {
    #   dunstify = true;
    # })

    (yarn.override {
      nodejs = null; # nodejs_13-x
    })

    python
    python3
    libudev
    
    rustup
    libnotify
    libusb
    libwebcam

    lm_sensors
    i3lock-color
    i3lock-pixeled
    xorg.xbacklight
    fcitx
    fcitx-configtool
    srandrd
    powertop
    lsof
    gparted
    alacritty
    kitty
    tmux
    ncat
    websocat
    xorg.xdpyinfo
    xorg.xhost
    xidlehook
    dmidecode
    fd
    jq
    bc
    ripgrep
    tree
    xclip
    emacs

    # rice
    lxappearance

    maia-icon-theme
    matcha-gtk-theme
    equilux-theme
    faba-icon-theme
    flat-remix-icon-theme
    hicolor-icon-theme
    lounge-gtk-theme
    arc-icon-theme
    adapta-gtk-theme
    adementary-theme
    amber-theme
    arc-icon-theme
    canta-theme
    clearlooks-phenix
    e17gtk

    mojave-gtk-theme
    breeze-gtk
    capitaine-cursors
    numix-cursor-theme
    powerline-fonts
    cool-retro-term
    bibata-cursors
    vanilla-dmz
    pywal
    xwinwrap
    mpv
    sxiv
    siji
    jgmenu
    hardinfo
    exa

    # tools
    (appimage-run.override {
      extraPkgs = pkgs: [ pkgs.xorg.libxshmfence ];
    })
    psmisc
    neofetch
    git-lfs
    gotop
    htop
    fzf
    feh
    wirelesstools
    pavucontrol
    thefuck
    ddgr
    baobab
    imagemagick
    ranger
    docker
    xcwd
    bat
    docker-compose
    kubernetes
    minikube
    cloc
    unzip
    heroku
    clipit
    ctodo
    usbutils
    trickle
    darling-dmg
    parallel

    # image/audio/video
    scrot
    ffmpeg
    vlc
    cava
    simplescreenrecorder
    
    # applications
    gnome3.dconf-editor
    gnome3.gnome-screenshot	
    gnome3.gnome-font-viewer
    # lxqt.screengrab
    # qscreenshot

    xdotool
    libreoffice
    tdesktop
    screenkey
    arandr
    speedtest-cli
    insomnia
    spotify
    brave
    playerctl
    filezilla
    openvpn
    iptables
    conky
    electron
    redis
    drone-cli
    bats
    steam-run
    hueadm
    ngrok

    dfilemanager
    mate.caja
    xfce.thunar

    pinta
    tmate

    mattermost-desktop

    nodePackages.lerna
    nodePackages.live-server
    nodePackages.node-gyp

    usb_modeswitch

    toxiproxy
    gnome3.pomodoro
    anki
    # dwm

    s-tui
    thinkfan
    xbindkeys
    gnome3.sushi
    asciinema
    pscircle
    peco
    qutebrowser
    speedcrunch

    lazygit
    lazydocker

    cmake
    binutils
    slop

    lguf-brightness
    rdesktop
  ];

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.rofi = {
    enable = true;
    theme = "~/.config/rofii/theme.rasi";
  };

  services.flameshot = {
    enable = true;
  };

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  services.redshift = {
    enable = true;
    tray = true;
    latitude = "43.653225";
    longitude = "-79.383186";
    provider = "manual";
    temperature = {
      day = 5500;
      night = 3000;
    };
  };

  services.network-manager-applet = {
    enable = true;
  };

  # programs.firefox = {
  #   enable = true;
  # };
  
  programs.fzf = {
    enable = true; 
    enableZshIntegration = true;
  };

  programs.broot = {
    enable = true;
  };

  programs.vim = {
    enable = true;
    plugins = [ pkgs.vimPlugins.lightline-vim ];
    extraConfig = ''
      set nocompatible

      syntax on
      set number
      set relativenumber
      set cursorline
      set hls
      set noshowmode

      inoremap jk <esc>

      set tabstop=4
      set expandtab

      let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      character = {
        success_symbol = "⇶(bold green)";
        error_symbol = "⇶(bold red)";
      };

      directory = {
        truncation_length = 8;
        truncation_symbol = "…/";
      };

      git_branch = {
        format = "@ [$symbol$branch]($style) ";
      };

      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$line_break"
        "$character"
      ];
    };
  };

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master"}/modules/vsliveshare/home.nix"
  ];

  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode-oss/extensions";
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/61cc1f0dc07c2f786e0acfd07444548486f4153b";
  };

  programs.zsh = import ./zsh.nix pkgs;
  services.dunst = import ./dunst.nix pkgs;
  programs.autorandr = import ./autorandr.nix pkgs;
  services.picom = import ./picom.nix { inherit pkgs; };

  programs.git = {
      enable = true;
      lfs.enable = true;
      userName = "Michael Yu";
      userEmail = "1619025+acrylix@users.noreply.github.com";
      extraConfig = {
        "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
      };
    };
}
