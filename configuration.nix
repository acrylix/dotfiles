# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    # blacklistedKernelModules = [ "mei_me" ];
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
    # plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Fix instant wakeup after suspend due to XHC events 
  systemd.services.disable-xhci-wakeup = {
    description = "Disables XHCI wakeup for S3 sleep support.";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig.type = "oneshot";
    script = ''
      if ${pkgs.gnugrep}/bin/grep -q 'XHC.*enabled' /proc/acpi/wakeup; then
        echo XHC > /proc/acpi/wakeup
      fi
    '';
  };

  # https://wiki.archlinux.org/index.php/Bluetooth_headset#Apple_Airpods_have_low_volume
  systemd.user.services.bluetooth.serviceConfig."ExecStart" = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=avrcp"
  ];
  
  # hardware
  # hardware.enableAllFirmware = true;  # pulls in mac stuff .. no good
  # hardware.enableRedistributableFirmware = true; # Might help wifi?
  hardware.bluetooth.enable = true;

  # hardware.bluetooth.extraConfig = "
  #  [General]
  #  Enable=Source,Sink,Media,Socket
  # ";

  hardware.bluetooth.config = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  services.blueman.enable = true;
  
  # battery saver auto tune
  # powerManagement.powertop.enable = true;

  services.tlp.enable = true;
  # services.tlp.extraConfig = ''
  #   CPU_SCALING_GOVERNOR_ON_AC=powersave
  #   CPU_SCALING_GOVERNOR_ON_BAT=powersave
  # '';

  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    CPU_HWP_ON_AC=balance_performance
    CPU_HWP_ON_BAT=balance_power
    SCHED_POWERSAVE_ON_AC=1
    SCHED_POWERSAVE_ON_BAT=1
    ENERGY_PERF_POLICY_ON_AC=balance-performance
    ENERGY_PERF_POLICY_ON_BAT=balance-power
  '';
  
  # Disable the "throttling bug fix" -_- https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/cpu-throttling-bug.nix
  systemd.timers.cpu-throttling.enable = lib.mkForce false;
  systemd.services.cpu-throttling.enable = lib.mkForce false;

  # Define your hostname.
  networking.hostName = "mx1"; 
  networking.networkmanager.enable = true;
  # programs.nm-applet.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };
  # Select internationalisation properties.
  i18n = {
    #  consoleFont = "Lat2-Terminus16";
    #  consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
     # chinese input
     inputMethod = {
       enabled = "fcitx";
       fcitx.engines = with pkgs.fcitx-engines; [ libpinyin cloudpinyin ];
     };
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

    xorg.xmodmap
    xorg.xev

    gnome3.nautilus
  ];

  services.fwupd.enable = true;

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

  # This is Xft.dpi in .Xresources, 140 = 210 / 1.5
  fonts.fontconfig.dpi = 140;

  services.xserver = {
    enable = true;
    # 210 is the native DPI of the HDR screen
    dpi = 210;
    libinput = {
      enable = true;
      disableWhileTyping = true;
    };

    # key layout:
    #
    # [CapsLock] = [Ctrl]
    #
    # [Super] [Alt] [Ctrl]
    #
    # R_ALT + i j k l = arrow keys
    xkbOptions = "ctrl:swap_lalt_lctl_lwin, ctrl:nocaps";

    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';

    displayManager = {
      defaultSession = "none+i3";
      gdm = {
        enable = true;
      };
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 230 30
        ${pkgs.xorg.xset}/bin/xset s off
        ${pkgs.xorg.xset}/bin/xset -dpms
      '';
    };

    desktopManager = {
      xterm.enable = false;
      # gnome3.enable = true;
    };

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
    extraGroups = [ "wheel" "networkmanager" "sudoers" "disk" "video" "audio" "docker" "udev"];
  };

  services.udev.packages = [ pkgs.ledger-udev-rules ];

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
