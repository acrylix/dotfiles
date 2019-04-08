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
    go
    gcc
    acpi
    rofi
    dunst
    libnotify
    lm_sensors
    i3lock-color
    xorg.xbacklight
    fcitx
    fcitx-configtool
    srandrd
    powertop
    lsof
    
    # rice
    lxappearance
    deepin.deepin-gtk-theme
    capitaine-cursors
    powerline-fonts
    cool-retro-term
    pywal

    # tools
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
    imagemagick

    # image/video
    scrot
    ffmpeg
    vlc

    # applications
    gnome3.dconf-editor
    gnome3.gnome-screenshot	
    libreoffice
    tdesktop
    discord
    screenkey
    arandr
  ];

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
