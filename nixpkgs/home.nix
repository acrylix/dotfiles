{ config, pkgs, ... }:

let
  srandrd = import ./srandrd;
  web2nix = import (builtins.fetchTarball https://github.com/gcoakes/web2nix/archive/master.tar.gz);
in
{
  programs.home-manager = {
    enable = true;
    path = "/home/michael/.home-manager";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # system
    gcc
    acpi

    (web2nix { name = "cryptowatch"; url = "https://cryptowat.ch"; })
    (web2nix { name = "skyweaver"; url = "https://beta.skyweaver.net"; })
    
    (dunst.override {
      dunstify = true;
    })

    (yarn.override {
      nodejs = nodejs_latest;
    })
    
    libnotify
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
    tmux
    ncat
    websocat
    xorg.xdpyinfo
    xidlehook
    dmidecode
    fd

    # rice
    lxappearance
    deepin.deepin-gtk-theme
    arc-icon-theme
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

    # tools
    appimage-run
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
    xzoom
    docker-compose
    cloc
    unzip
    heroku
    clipit
    ctodo
    usbutils
    trickle
    darling-dmg

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
    awscli
    filezilla
    openvpn
    iptables
    conky
    electron
    redis
    drone-cli
    zoom-us
    bats
    steam-run
    hueadm
    ngrok

    dfilemanager
    mate.caja
    xfce.thunar

    pinta
    tmate
  ];

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

  services.compton = {
    enable = false;
  };

  programs.firefox = {
    enable = true;
  };
  
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
        symbol = "⇶";
      };

      git_status = {
        prefix = "";
        suffix = "";
        modified_count.enabled = true;
        modified_count.style = "bold dimmed purple";
      };
      
      prompt_order = [
        "directory"
        "git_branch"
        "git_commit"
        "git_state"
        "git_status"
        "line_break"
        "character"
      ];
    };
  };

  programs.zsh = import ./zsh.nix pkgs;
  services.dunst = import ./dunst.nix pkgs;
  programs.autorandr = import ./autorandr.nix pkgs;

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
