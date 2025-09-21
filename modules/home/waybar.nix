{
  pkgs,
  lib,
  host,
  config,
  ...
}: let
  # A smoother, more standard transition for animations
  betterTransition = "all 0.3s ease-in-out";
  inherit (import ../../hosts/${host}/variables.nix) clock24h;
in
  with lib; {
    # Configure & Theme Waybar
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-center = [
            "hyprland/workspaces"
            "clock"
            "custom/notification"
          ];
          modules-left = [
            "custom/startmenu"
            "cpu"
            "memory"
            # Add "network" here if you want it on the left
          ];
          modules-right = [
            "custom/hyprbindings"
            "network" # <-- Moved network module here for better visibility
            "pulseaudio"
            "tray"
            "battery"
            "custom/exit"
          ];

          "hyprland/workspaces" = {
            format = "{name}";
            format-icons = {
              default = " ";
              active = " ";
              urgent = " ";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };
          "clock" = {
            format =
              if clock24h == true
              then '' {:L%H:%M}''
              else '' {:L%I:%M %p}'';
            tooltip = true;
            tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          };
          "hyprland/window" = {
            max-length = 22;
            separate-outputs = false;
            rewrite = {
              "" = " 🙈 No Windows? ";
            };
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };
          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
          };
          "disk" = {
            format = " {free}";
            tooltip = true;
          };
          # --- UPDATED NETWORK MODULE ---
          "network" = {
            interval = 1; # Update every second for real-time speed
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-wifi = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
            format-ethernet = "󰈀  {bandwidthUpBytes}  {bandwidthDownBytes}";
            format-disconnected = "󰤮 Disconnected";
            tooltip = false;
          };
          # ------------------------------
          "tray" = {
            spacing = 12;
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              "hands-free" = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "sleep 0.1 && pavucontrol";
          };
          "custom/exit" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = "Shubhash";
            # exec = "rofi -show drun";
            on-click = "sleep 0.1 && rofi-launcher";
          };
          "custom/hyprbindings" = {
            tooltip = false;
            format = "󱕴";
            on-click = "sleep 0.1 && list-keybinds";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            tooltip = "true";
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              "dnd-notification" = "<span foreground='red'><sup></sup></span>";
              "dnd-none" = "";
              "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
              "inhibited-none" = "";
              "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
              "dnd-inhibited-none" = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "sleep 0.1 && task-waybar";
            escape = true;
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            on-click = "";
            tooltip = false;
          };
        }
      ];
      style = concatStrings [
        ''
          /* --- Global Styles --- */
          * {
            font-family: JetBrainsMono Nerd Font Mono;
            font-size: 13px;
            border: none;
            border-radius: 0;
            min-height: 0;
          }

          /* --- Main Bar --- */
          window#waybar {
            background: #1E1E2E; /* Dark Blue Background */
            color: #CAD3F5;      /* Light Text */
          }

          /* --- Tooltips --- */
          tooltip {
            background: #181825;
            border: 1px solid #ED8796; /* Red Border */
            border-radius: 12px;
          }
          tooltip label {
            color: #CAD3F5;
          }

          /* --- Workspaces --- */
          #workspaces {
            background: #313244;
            border-radius: 16px;
            margin: 5px;
            padding: 2px 5px;
          }
          #workspaces button {
            color: #CAD3F5;
            background: transparent;
            font-weight: bold;
            padding: 0px 8px;
            margin: 3px 3px;
            border-radius: 12px;
            transition: ${betterTransition};
          }
          #workspaces button:hover {
            background: #8AADF4; /* Blue Hover */
            color: #1E1E2E;
          }
          #workspaces button.active {
            background: #ED8796; /* Red Active */
            color: #1E1E2E;
            min-width: 40px;
          }
          
          /* --- General Module Styles --- */
          #window, #cpu, #memory, #idle_inhibitor, #custom-name,
          #custom-hyprbindings, #network, #battery,
          #pulseaudio, #tray, #custom-exit, #clock, #custom-notification {
            font-weight: bold;
            background: #313244; /* Darker Module BG */
            color: #CAD3F5;
            margin: 5px 0px;
            padding: 0px 18px;
          }

          /* --- Left Modules --- */
          #custom-startmenu {
            color: #1E1E2E;
            background: #8AADF4; /* Blue BG */
            font-size: 18px;
            margin-down: 5px;
            margin-right: 8px;
            padding: 0px 30px 0px 15px;
            border-radius: 0px 0px 40px 0px;
          }
          #cpu, #memory {
            margin-left: 8px;
            border-radius: 24px 10px 24px 10px;
          }

          /* --- Center Modules --- */
          #clock, #custom-notification {
            padding: 5px 25px;
            margin: 5px 4px;
            border-radius: 16px;
          }

          /* --- Right Modules --- */
          #custom-hyprbindings, #network, #battery,
          #pulseaudio, #tray, #custom-exit {
            margin-right: 8px;
            border-radius: 10px 24px 10px 24px;
          }
          #custom-exit {
            color: #1E1E2E;
            background: #ED8796; /* Red BG */
          }

          /* --- Module-specific Colors & States --- */
          #clock { color: #8AADF4; }      /* Blue Clock */
          #cpu { color: #8AADF4; }        /* Blue CPU */
          #memory { color: #ED8796; }    /* Red Memory */
          #network { color: #A6DA95; }    /* Green Network */
          #battery.charging, #battery.plugged { color: #A6DA95; } /* Green Charging */
          #battery.critical:not(.charging) { color: #ED8796; }   /* Red Critical Battery */
        ''
      ];
    };
  }