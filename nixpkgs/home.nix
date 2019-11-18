{ config, pkgs, ... }:

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
    gcc
    acpi
    
    (dunst.override {
      dunstify = true;
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
    pywal
    xwinwrap
    mpv
    sxiv

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
    zoom-us

    # image/audio/video
    scrot
    ffmpeg
    vlc
    cava
    simplescreenrecorder
    krita
    
    # applications
    gnome3.dconf-editor
    gnome3.gnome-screenshot	
    # lxqt.screengrab
    # qscreenshot

    libreoffice
    tdesktop
    discord
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
  ];

  programs.rofi = {
    enable = true;
    theme = "~/.config/rofii/theme.rasi";
  };

  services.flameshot = {
    enable = true;
  };

  services.blueman-applet = {
    enable = true;
  };

  services.network-manager-applet = {
    enable = true;
  };

  services.compton = {
    enable = false;
  };

  programs.firefox = {
    enable = true;
    enableIcedTea = true;
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
