{
  pkgs,
  lib,
  host,
  config,
  ...
}: let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
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
          ];
          modules-right = [
            "custom/hyprbindings"
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
          "network" = {
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-ethernet = " {bandwidthDownOctets}";
            format-wifi = "{icon} {signalStrength}%";
            format-disconnected = "󰤮";
            tooltip = false;
          };
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
              hands-free = "";
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
            format = "ॐ";
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
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
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
          * {
              font-family: JetBrainsMono Nerd Font Mono;
              font-size: 12px;
              border-radius: 0px;
              border: none;
              min-height: 0px;
              color: #ffffff;
            }

            window#waybar {
              background:rgba(0, 0, 0, 0);
            }

            #workspaces {
              color: #ffffff;
              background: #0a0a40;
              margin: 4px 4px;
              padding: 5px 5px;
              border-radius: 16px;
            }

            #workspaces button {
              font-weight: bold;
              padding: 0px 5px;
              margin: 0px 3px;
              border-radius: 16px;
              color: #ffffff;
              background: linear-gradient(45deg, #001e44, #0b003b);
              opacity: 0.5;
              transition: ${betterTransition};
            }

            #workspaces button.active {
              font-weight: bold;
              padding: 0px 5px;
              margin: 0px 3px;
              border-radius: 16px;
              color: #ffffff;
              background: linear-gradient(45deg, #001a66, #002080);
              transition: ${betterTransition};
              opacity: 1.0;
              min-width: 40px;
            }

            #workspaces button:hover {
              font-weight: bold;
              border-radius: 16px;
              color: #ffffff;
              background: linear-gradient(45deg, #001a66, #002080);
              opacity: 0.8;
              transition: ${betterTransition};
            }

            tooltip {
              background: #0a0a40;
              border: 1px solid #001a66;
              border-radius: 12px;
            }

            tooltip label {
              color: #ffffff;
            }

            #window, #cpu, #memory, #idle_inhibitor, #custom-name {
              font-weight: bold;
              margin: 4px 0px;
              margin-left: 7px;
              padding: 0px 18px;
              background: #0b003b;
              color: #ffffff;
              border-radius: 24px 10px 24px 10px;
            }

            #custom-startmenu {
              color: #ffffff;
              background: #000050;
              font-size: 28px;
              margin: 0px;
              padding: 0px 30px 0px 15px;
              border-radius: 0px 0px 40px 0px;
            }

            #custom-hyprbindings, #network, #battery,
            #pulseaudio, #tray, #custom-exit {
              font-weight: bold;
              background:#000050;
              color: #ffffff;
              margin: 4px 0px;
              margin-right: 7px;
              border-radius: 10px 24px 10px 24px;
              padding: 0px 18px;
            }

            #clock, #custom-notification {
              font-weight: bold;
              color: #ffffff;
              background: linear-gradient(90deg, #00001b, #000063);
              margin: 4px 3px;

              padding: 5px 30px;
              border-radius: 30px 30px 30px 30px;
            }
        ''
      ];
    };
  }
