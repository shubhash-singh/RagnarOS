{ config, pkgs, lib, ... }:

{

  # Create autostart script in ~/.local/bin
  home.file.".local/bin/start_video_wallpaper.sh" = {
    text = ''
      #!/usr/bin/env bash
      pkill mpvpaper 2>/dev/null
      sleep 2
      mpvpaper -o "loop mute" "*" "/home/ragnar/Pictures/Wallpapers/live_batman.webm"
    '';
    executable = true;
  };

  # Ensure ~/.local/bin is in PATH
  home.sessionPath = [ "$HOME/.local/bin" ];

  # Autostart mpvpaper when Hyprland starts
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once = ~/.local/bin/start_video_wallpaper.sh
    '';
  };
}

