{ pkgs, ... }:
{
  programs = {
    firefox.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
    mtr.enable = true;
    adb.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
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
    appimage-run # Needed For AppImage Support
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    duf # Utility For Viewing Disk Usage In Terminal
    eza # Beautiful ls Replacement
    file-roller # Archive Manager

    gedit # Simple Graphical Text Editor
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
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
    nixfmt-rfc-style # Nix Formatter
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
    virt-viewer # View Virtual Machines
    wget # Tool For Fetching Files With Links
    yazi
    clipman # for clipboard
    wl-clipboard # for clipboard list
    
    #manage widget
    eww
    # System apps
    btop
    neofetch

    # Custom Applications
    github-desktop
    firefox # browser
    jetbrains-toolbox # intellijIDEA
    prismlauncher # minecraft
    vlc
    wpsoffice # WPS for office tools
    chromium # chromium as browser
    code-cursor
    obsidian
    android-studio
    postman # used to test and debug API
    dbgate # for MySQL connectivity
    vscode-fhs # Visual Studio Code
    claude-code
    droidcam # to connect phone camera with system
  ];
}
