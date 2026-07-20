{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];



  # Nix Features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  


  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;



  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];




  # Battery Charge Limit
  systemd.services.battery-charge-limit = {
    description = "Set battery charge limit";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold'";
    };
  };



  # Networking
  networking.hostName = "CrescentLibrary";
  networking.networkmanager.enable = true;



  # Timezone
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };



  # X11
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];


 
  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };



  # Touchpad
  services.libinput.enable = true;



  # Users
  users.users.adeline = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };



  # Virtualisation
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" ];



  # Packages
  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  services.syncthing.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git 
    openssh
    curl
    wget
    fastfetch
    fish
    neovim
    librewolf
    virt-manager
    baobab
    krita
    loupe
    foliate
    libreoffice
    qt6Packages.qt6ct
    adw-gtk3
    adwaita-icon-theme
    hicolor-icon-theme
    gnome-icon-theme
    pop-icon-theme
    tela-circle-icon-theme
    kdePackages.breeze-icons
    qt5.qtwayland
    qt6.qtwayland
  ];



  # Desktop Environment
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  hardware.graphics.enable = true;



  system.stateVersion = "26.05";

}

