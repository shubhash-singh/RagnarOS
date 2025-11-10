{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    swww
    ffmpeg
  ];

  home.file.".config/hypr/autostart_wallpaper.sh".text = ''
    #!/usr/bin/env bash
    pkill swww-daemon 2>/dev/null
    swww-daemon &
    sleep 1
    swww img ~/Pictures/Wallpapers/batman_live.mp4 --transition-type grow --transition-fps 60
  '';

  home.file.".config/hypr/autostart_wallpaper.sh".executable = true;


  xdg.configFile."hypr/hyprland.conf".text = ''
    exec-once = ~/.config/hypr/autostart_wallpaper.sh
  '';
}


