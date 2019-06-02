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

    # rice
    lxappearance
    deepin.deepin-gtk-theme
    arc-icon-theme
    mojave-gtk-theme
    breeze-gtk
    capitaine-cursors
    powerline-fonts
    cool-retro-term
    pywal
    bibata-cursors
    oneko

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

    # image/audio/video
    scrot
    ffmpeg
    vlc
    cava
    simplescreenrecorder
    krita
    graphviz
    
    # applications
    gnome3.dconf-editor
    gnome3.gnome-screenshot	
    lxqt.screengrab
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
  ];

  programs.rofi = {
    enable = true;
    theme = "~/.config/rofii/theme.rasi";
  };

  services.blueman-applet ={
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

  programs.zsh = import ./zsh.nix pkgs;
  services.dunst = import ./dunst.nix pkgs;
  programs.autorandr = import ./autorandr.nix pkgs;

  programs.git = {
      enable = true;
      lfs.enable = true;
      userName = "Michael Yu";
      userEmail = "1619025+acrylix@users.noreply.github.com";
    };
}
