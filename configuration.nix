{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "niXnx";
  networking.networkmanager.enable = true;

  # locales
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # X11 windowing system.
  services.xserver.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    permittedInsecurePackages = [
      "python-2.7.18.7"
      "electron-25.9.0"
    ];
  };

  # Window Manager
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  # Enable sound (finally works!!)
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (not sure if i need it)
  services.xserver.libinput.enable = true;

  # zsh (i don't know where to put this)
  programs.zsh.enable = true;

  # Define a user account
  users.users.liv = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    alacritty
    anki
    bitwarden
    discord
    dunst
    firefox-wayland
    git
    grim
    hyprland
    hyprpaper
    kitty
    lf
    lxqt.lxqt-policykit
    mpv
    neofetch
    neovim
    networkmanager
    ntfs3g
    obsidian
    pipewire
    python
    rofi-wayland
    sddm
    spotify
    unzip
    vscode
    waybar
    wget
    wireplumber
    xfce.thunar
    xdg-desktop-portal-hyprland
    xwayland
    zsh
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    google-fonts
  ];

  # OpenSSH daemon
  services.openssh.enable = true;


  # Do not touch
  system.stateVersion = "23.11";

}

