# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x1-extreme>
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    dwm = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        buildInputs = with pkgs; [x11 xorg.libX11 xorg.libXinerama];
        src = pkgs.fetchgit {
          url = "https://github.com/acrylix/dwm";
          rev = "c3f7729dde77e94a300f77408d27442220175971";
          sha256 = "0gza45zap2zgxrp6ifnhlwv53g7krxgm31psmkcq4907i2v7n4s3";
        };
      });
  };
  
 boot = {
   loader = {
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
    };
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;  
  };

  kernelParams = [
    "i915.enable_dpcd_backlight=1"
  ];
  
  kernelPackages = pkgs.linuxPackages_latest;
  
  extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };

  networking.hostName = "kyx1e"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
  defaultLocale = "en_US.UTF-8";
  inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ libpinyin cloudpinyin ];
  };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    gnumake
  
    alacritty
    blueman
  
    xorg.xmodmap
    xorg.xev
  
    gnome3.nautilus
    google-chrome
    st
    dmenu

    xorg.xinit

    xorg.libXext
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.bluetooth.config = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # https://wiki.archlinux.org/index.php/Bluetooth_headset#Apple_Airpods_have_low_volume
  systemd.user.services.bluetooth.serviceConfig."ExecStart" = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=avrcp"
  ];


  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf pkgs.blueman ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  programs.light.enable = true;  

  # This is Xft.dpi in .Xresources, 140 = 210 / 1.5
  fonts.fontconfig.dpi = 150;

  services.xserver = {
    enable = true;
    dpi = 200;
    libinput = {
      enable = true;
    };
    xkbOptions = "ctrl:swap_lalt_lctl_lwin, ctrl:nocaps";
    videoDrivers = ["nvidia"];
    
    autoRepeatDelay = 230;
    autoRepeatInterval = 30;

    displayManager = {
      defaultSession = "none+dwm";
      gdm.enable = true;
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset s off
        ${pkgs.xorg.xset}/bin/xset -dpms
      '';
    };

    desktopManager = {
      xterm.enable = false;
    };

    # windowManager.i3 = {
    #  	enable = true;
    #  	package = pkgs.i3-gaps;
    # };

     windowManager.dwm = {
       enable = true;
     };
  };

  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  # };

  # services.dwm-status = {
  #   enable = true;
  #   order = ["network" "cpu_load" "battery" "time"];
  # };

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
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };
  users.users.michael = {
  isNormalUser = true;
  home = "/home/michael";
  uid = 1000;
  description = "Michael Yu";
  shell = pkgs.zsh;
  extraGroups = ["sudoers" "wheel" "disk" "networkmanager" "video" "audio" "docker" "udev"];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

