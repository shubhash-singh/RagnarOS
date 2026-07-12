{ pkgs, ... }:
{
  programs = {
    firefox.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
    mtr.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config = {
    android_sdk.accept_license = true;
  };

  environment.systemPackages = with pkgs; [
    android-tools # Provides adb command (replaces deprecated programs.adb)
    appimage-run # Needed For AppImage Support
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    duf # Utility For Viewing Disk Usage In Terminal
    eza # Beautiful ls Replacement
    file-roller # Archive Manager

    gedit # Simple Graphical Text Editor
    tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    hyprpicker # Color Picker
    eog # For Image Viewing
    inxi # CLI System Information Tool
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    libvirt # Needed For Virtualisation Support
    lm_sensors # Used For Getting Hardware Temps
    lshw # Detailed Hardware Information
    lxqt.lxqt-policykit # The Chosen Policy Kit / Polkit
    ncdu # Disk Usage Analyzer With Ncurses Interface
    #nixfmt # Nix Formatter
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    ripgrep # Improved Grep
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    #virt-viewer # View Virtual Machines
    wget # Tool For Fetching Files With Links
    yazi
    #zstd # used by python PyQt6 for GUI interface


    # System apps
    btop
    fastfetch

    # Custom Applications
    github-desktop
    firefox # browser
    jetbrains-toolbox # intellijIDEA
    prismlauncher # minecraft
    vlc
    libreoffice-qt6-fresh #for office tools
    chromium # chromium as browser
    postman # used to test and debug API
    dbgate # for MySQL connectivity
    droidcam # to connect phone camera with system
    qalculate-qt # Calculator
    docker_29 #docker container
    antigravity-fhs # google AI IDE
    codex
    obsidian
    #code-cursor
    neovim
  ];
}
