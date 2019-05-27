# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot = {
    blacklistedKernelModules = [ "mei_me" ];
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  
  # hardware?
  hardware.enableAllFirmware = true;  
  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = "
    [General]
    Enable=Source,Sink,Media,Socket
  ";
  
  # battery saver auto tune
  # powerManagement.powertop.enable = true;

  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
  '';

  # Define your hostname.
  networking.hostName = "mx1"; 
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
     # chinese input
     inputMethod.enabled = "fcitx";
   };

  # the 6ix.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    gnumake
    kitty
    blueman

    gnome3.nautilus
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.light.enable = true;

  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 4001 3000 3001 8000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf pkgs.blueman ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
  };
  
  virtualisation.docker.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  fonts.fontconfig.dpi = 140;

  services.xserver = {
    enable = true;
    dpi = 140;
    libinput = {
      enable = true;
      disableWhileTyping = true;
    };
    # CapsLock = Ctrl
    # swap left Alt <--> left Super
    # xkbOptions = "ctrl:nocaps, altwin:swap_lalt_lwin";

    # CapsLock = Ctrl
    # [Super] [Alt] [Ctrl]
    xkbOptions = "ctrl:swap_lalt_lctl_lwin, ctrl:nocaps";

    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
    
    displayManager.gdm = {
      enable = true;
    };

    desktopManager = {
      default = "none";
      xterm.enable = false;
      gnome3.enable = true;
    };

    windowManager.default = "i3";
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    wqy_microhei
    wqy_zenhei
    fira-code
    siji
    font-awesome_5
    unifont
  ];

  environment.variables = {
    EDITOR="vim";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    home = "/home/michael";
    description = "Michael Yu";
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "sudoers" "disk" "video" "docker"];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
