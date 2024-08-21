{ inputs, config, lib, pkgs, userSettings, ... }:

{
  imports = [
    ../../app/terminal/kitty.nix
    ../../app/terminal/alacritty.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment --systemd DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_SESSION_DESKTOP=Hyprland XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_TYPE=wayland

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = GDK_BACKEND,wayland,x11,*
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = CLUTTER_BACKEND,wayland
      #env = AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1
      #env = GDK_PIXBUF_MODULE_FILE,${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache

      exec-once = nm-applet
      exec-once = pypr
      #exec-once = blueman-applet
      #exec-once = dunst

      bezier = wind, 0.05, 0.9, 0.1, 1.05
      bezier = winIn, 0.1, 1.1, 0.1, 1.0
      bezier = winOut, 0.3, -0.3, 0, 1
      bezier = liner, 1, 1, 1, 1
      bezier = linear, 0.0, 0.0, 1.0, 1.0

      animations {
           enabled = yes
           animation = windowsIn, 1, 6, winIn, popin
           animation = windowsOut, 1, 5, winOut, popin
           animation = windowsMove, 1, 5, wind, slide
           animation = border, 1, 10, default
           animation = borderangle, 1, 100, linear, loop
           animation = fade, 1, 10, default
           animation = workspaces, 1, 5, wind
           animation = windows, 1, 6, wind, slide
      }

      general {
        layout = master
        border_size = 2
        col.active_border = 0xff'' + config.lib.stylix.colors.base08 + " " + ''0xff'' + config.lib.stylix.colors.base09 + " " + ''0xff'' + config.lib.stylix.colors.base0A + " " + ''0xff'' + config.lib.stylix.colors.base0B + " " + ''0xff'' + config.lib.stylix.colors.base0C + " " + ''0xff'' + config.lib.stylix.colors.base0D + " " + ''0xff'' + config.lib.stylix.colors.base0E + " " + ''0xff'' + config.lib.stylix.colors.base0F + " " + ''270deg

        col.inactive_border = 0xaa'' + config.lib.stylix.colors.base02 + ''

            resize_on_border = false
            gaps_in = 7
            gaps_out = 7
       }

      cursor {
        no_warps = false
        inactive_timeout = 30
      }

       bind=SUPER,SPACE,fullscreen,1
       bind=SUPERSHIFT,F,fullscreen,0
       bind=SUPER,Y,workspaceopt,allfloat
       bind=ALT,TAB,cyclenext
       bind=ALT,TAB,bringactivetotop
       bind=ALTSHIFT,TAB,cyclenext,prev
       bind=ALTSHIFT,TAB,bringactivetotop

       bind=SUPERSHIFT,V,exec,wl-copy $(wl-paste | tr '\n' ' ')
       bind=SUPERSHIFT,T,exec,screenshot-ocr
       bind=CTRLALT,Delete,exec,hyprctl kill
       bind=SUPERSHIFT,K,exec,hyprctl kill

       bind=SUPER,RETURN,exec,'' + userSettings.term + ''

       bind=SUPER,A,exec,wofi --show drun
       bind=SUPER,Q,killactive
       bind=SUPERSHIFT,Q,exit
       bindm=SUPER,mouse:272,movewindow
       bindm=SUPER,mouse:273,resizewindow
       bind=SUPER,T,togglefloating

       ## App launchers
       bind=SUPER,B,exec,'' + userSettings.browser + ''

       bind=SUPER,E,exec,nautilus
       #bind=SHIFT,P,exec,grim -g "$(slurp -o)"
       bind=SUPER,P,exec,grim
       bind=CTRL,P,exec,grim -g "$(slurp)" - | wl-copy
       bind=SHIFTCTRL,P,exec,grim -g "$(slurp -o)" - | wl-copy
       bind=SUPERCTRL,P,exec,grim - | wl-copy

       bind=SUPERCTRL,S,exec,systemctl suspend
       bind=SUPERCTRL,L,exec,loginctl lock-session

       bind=SUPER,H,movefocus,l
       bind=SUPER,J,movefocus,d
       bind=SUPER,K,movefocus,u
       bind=SUPER,L,movefocus,r

       bind=SUPERSHIFT,H,movewindow,l
       bind=SUPERSHIFT,J,movewindow,d
       bind=SUPERSHIFT,K,movewindow,u
       bind=SUPERSHIFT,L,movewindow,r

       bind=SUPER,1,focusworkspaceoncurrentmonitor,1
       bind=SUPER,2,focusworkspaceoncurrentmonitor,2
       bind=SUPER,3,focusworkspaceoncurrentmonitor,3
       bind=SUPER,4,focusworkspaceoncurrentmonitor,4
       bind=SUPER,5,focusworkspaceoncurrentmonitor,5
       bind=SUPER,6,focusworkspaceoncurrentmonitor,6
       bind=SUPER,7,focusworkspaceoncurrentmonitor,7
       bind=SUPER,8,focusworkspaceoncurrentmonitor,8
       bind=SUPER,9,focusworkspaceoncurrentmonitor,9

       bind=SUPERCTRL,right,exec,hyprnome
       bind=SUPERCTRL,left,exec,hyprnome --previous
       bind=SUPERSHIFT,right,exec,hyprnome --move
       bind=SUPERSHIFT,left,exec,hyprnome --previous --move

       bind=SUPERSHIFT,1,movetoworkspace,1
       bind=SUPERSHIFT,2,movetoworkspace,2
       bind=SUPERSHIFT,3,movetoworkspace,3
       bind=SUPERSHIFT,4,movetoworkspace,4
       bind=SUPERSHIFT,5,movetoworkspace,5
       bind=SUPERSHIFT,6,movetoworkspace,6
       bind=SUPERSHIFT,7,movetoworkspace,7
       bind=SUPERSHIFT,8,movetoworkspace,8
       bind=SUPERSHIFT,9,movetoworkspace,9

       bind = SUPER, X, togglesplit, # dwindle
       bind = SUPER, O, pseudo

       # Example special workspace (scratchpad)
       #bind = SUPER, S, togglespecialworkspace, magic
       #bind = SUPERSHIFT, S, movetoworkspace, special:magic

       # Scroll through existing workspaces with mainMod + scroll
       bind = SUPER, mouse_down, workspace, e+1
       bind = SUPER, mouse_up, workspace, e-1


       # Brightness control
       #bind=,XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl s 1%-
       #bind=,XF86MonBrightnessUP,exec,${pkgs.brightnessctl}/bin/brightnessctl s 1%+

      # Media control
       bind=,XF86AudioPlay,exec,playerctl play-pause # toggle between media play and pause
       bind=,XF86AudioPause,exec,playerctl play-pause # toggle between media play and pause
       bind=,XF86AudioNext,exec,playerctl next # media next
       bind=,XF86AudioPrev,exec,playerctl previous # media previous
       bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10
       bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10
       bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
       bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t


       bind=SUPER,Z,exec,pypr toggle term
       bind=SUPER,F,exec,pypr toggle ranger
       bind=SUPER,N,exec,pypr toggle bitwarden
       bind=SUPER,M,exec,pypr toggle music
       bind=SUPER,S,exec,pypr toggle btm
       bind=SUPER,V,exec,pypr toggle pavucontrol

       #$savetodisk = title:^(Save to Disk)$
       #windowrulev2 = float,$savetodisk
       #windowrulev2 = size 70% 75%,$savetodisk
       #windowrulev2 = center,$savetodisk

       $pavucontrol = class:^(pavucontrol)$
       windowrulev2 = float,$pavucontrol
       windowrulev2 = size 86% 40%,$pavucontrol
       #windowrulev2 = move 50% 6%,$pavucontrol
       #windowrulev2 = workspace special silent,$pavucontrol
       windowrulev2 = opacity 0.80,$pavucontrol

       $Bitwarden = class:^(Bitwarden)$
       windowrulev2 = float,$Bitwarden
       #windowrulev2 = opacity 0.80,$Bitwarden
       #windowrulev2 = center,$Bitwarden

       #windowrulev2 = opacity 1.0,class:^(org.qutebrowser.qutebrowser),fullscreen:1
       windowrulev2 = opacity 1.0,class:^(Brave-browser),fullscreen:1
       windowrulev2 = opacity 1.0,class:^(librewolf),fullscreen:1
       windowrulev2 = opacity 1.0,class:^(firefox),fullscreen:1
       windowrulev2 = opacity 0.85,class:^(org.gnome.Nautilus)$

       layerrule = blur,waybar
       layerrule = xray,waybar
       blurls = waybar
       #layerrule = blur,launcher # fuzzel
       #blurls = launcher # fuzzel
       layerrule = blur,gtk-layer-shell
       layerrule = xray,gtk-layer-shell
       blurls = gtk-layer-shell
       #layerrule = blur,~nwggrid
       #layerrule = xray 1,~nwggrid
       #layerrule = animation fade,~nwggrid
       #blurls = ~nwggrid

       #bind=SUPER,code:21,exec,pypr zoom
       #bind=SUPER,code:21,exec,hyprctl reload

       bind=SUPER,I,exec,networkmanager_dmenu
       #bind=SUPER,P,exec,keepmenu
       #bind=SUPERSHIFT,P,exec,hyprprofile-dmenu

       # monitor setup
       #monitor=HDMI-A-1,3440x1440@100,0x0,1
       monitor=DP-3,3440x1440@100,0x0,1
	     #monitor=,preferred,auto,auto

       # hdmi tv
       #monitor=eDP-1,1920x1080,1920x0,1
       #monitor=HDMI-A-1,1920x1080,0x0,1

       # hdmi work projector
       #monitor=eDP-1,1920x1080,1920x0,1
       #monitor=HDMI-A-1,1920x1200,0x0,1

       xwayland {
         force_zero_scaling = true
       }

       binds {
         movefocus_cycles_fullscreen = false
       }

       input {
         kb_layout = de
         kb_options =
         repeat_delay = 350
         repeat_rate = 50
         accel_profile = adaptive
         follow_mouse = 1
         float_switch_override_focus = 0
       }

       misc {
         disable_hyprland_logo = true
         mouse_move_enables_dpms = true
         font_family = '' + userSettings.font + ''

       }

       decoration {
         rounding = 8
         blur {
           enabled = true
           size = 5
           passes = 2
           ignore_opacity = true
           contrast = 1.17
           xray = true
         }
       }
    '';
    xwayland = { enable = true; };
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    feh
    polkit_gnome
    nwg-launchers
    papirus-icon-theme
    gsettings-desktop-schemas
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
    noto-fonts-monochrome-emoji
    intel-one-mono
    noto-fonts
    noto-fonts-extra
    wlr-randr
    wtype
    ydotool
    wl-clipboard
    hyprland-protocols
    hyprpicker
    hyprpaper
    hyprlock
    hypridle
    pyprland
    fnott
    playerctl
    keepmenu
    pinentry-gnome3
    wev
    grim
    slurp
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    wlsunset
    pavucontrol
    pamixer
    wofi
    networkmanagerapplet
    transmission_4-gtk
    ];


  # waybar

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "7 7 3 7";
        spacing = 2;

        modules-left = [ "group/power" "group/cpu" "group/memory" "group/pulseaudio" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "group/time" "keyboard-state" "idle_inhibitor" ];

        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo "" '';
          "interval" = "once";
          "on-click" = "nwggrid-wrapper";
          "tooltip" = false;
        };
        "group/power" = {
            "orientation" = "horizontal";
            "drawer" = {
                "transition-duration" = 500;
                "children-class" = "not-power";
                "transition-left-to-right" = true;
            };
            "modules" = [
                "custom/os"
                "custom/lock"
                "custom/quit"
                "custom/power"
                "custom/reboot"
            ];
        };
        "custom/quit" = {
            "format" = "󰍃";
            "tooltip" = false;
            "on-click" = "hyprctl dispatch exit";
        };
        "custom/lock" = {
            "format" = "󰍁";
            "tooltip" = false;
            "on-click" = "hyprlock";
        };
        "custom/reboot" = {
            "format" = "󰜉";
            "tooltip" = false;
            "on-click" = "reboot";
        };
        "custom/power" = {
            "format" = "󰐥";
            "tooltip" = false;
            "on-click" = "shutdown now";
        };
        "keyboard-state" = {
          "numlock" = true;
          "format" = "{icon}";
          "format-icons" = {
            "locked" = "󰎠 ";
            "unlocked" = "󱧓 ";
          };
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "󱚌";
            "2" = "󰖟";
            "3" = "";
            "4" = "󰎄";
            "5" = "󰋩";
            "6" = "";
            "7" = "󰄖";
            "8" = "󰑴";
            "9" = "󱎓";
          };
          "on-click" = "activate";
          "all-outputs" = false;
          "active-only" = false;
          "ignore-workspaces" = ["scratch" "-"];
          "show-special" = false;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
        tray = {
          #"icon-size" = 21;
          "spacing" = 10;
        };
        "clock#time" = {
          "interval" = 1;
          "format" = "{:%I:%M:%S %p}";
          "timezone" = "Europe/Berlin";
          "tooltip" = false;
        };
        "clock#date" = {
          "interval" = 1;
          "format" = "{:%a %d-%m-%Y}";
          "timezone" = "Europe/Berlin";
          "tooltip" = false;
        };
        "group/time" = {
          "orientation" = "horizontal";
          "modules" = [ "clock#time" "clock#date" ];
        };

        cpu = { "format" = "󰍛"; };
        "cpu#text" = { "format" = "{usage}%"; };
        "group/cpu" = {
          "orientation" = "horizontal";
          "modules" = [ "cpu" "cpu#text" ];
        };

        memory = { "format" = ""; };
        "memory#text" = { "format" = "{}%"; };
        "group/memory" = {
          "orientation" = "horizontal";

          "modules" = [ "memory" "memory#text" ];
        };

        backlight = {
          "format" = "{icon}";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        };
        "backlight#text" = { "format" = "{percent}%"; };
        "group/backlight" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "backlight" "backlight#text" ];
        };

        battery = {
          "states" = {
            "good" = 75;
            "warning" = 30;
            "critical" = 15;
          };
          "fullat" = 80;
          "format" = "{icon}";
          "format-charging" = "󰂄";
          "format-plugged" = "󰂄";
          "format-full" = "󰁹";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "interval" = 10;
        };
        "battery#text" = {
          "states" = {
            "good" = 75;
            "warning" = 30;
            "critical" = 15;
          };
          "fullat" = 80;
          "format" = "{capacity}%";
        };
        "group/battery" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "battery" "battery#text" ];
        };
        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{icon}";
          "format-bluetooth" = "{icon}";
          "format-bluetooth-muted" = "󰸈";
          "format-muted" = "󰸈";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" = "pavucontrol && hyprctl dispatch bringactivetotop";
        };
        "pulseaudio#text" = {
          "scroll-step" = 1;
          "format" = "{volume}%";
          "format-bluetooth" = "{volume}%";
          "format-bluetooth-muted" = "";
          "format-muted" = "";
          "format-source" = "{volume}%";
          "format-source-muted" = "";
          "on-click" = "pavucontrol && hyprctl dispatch bringactivetotop";
        };
        "group/pulseaudio" = {
          "orientation" = "horizontal";
          "modules" = [ "pulseaudio" "pulseaudio#text" ];
        };
      };
    };
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, ''+userSettings.font+'';

          font-size: 20px;
      }

      window#waybar {
          background-color: rgba('' + config.lib.stylix.colors.base00-rgb-r + "," + config.lib.stylix.colors.base00-rgb-g + "," + config.lib.stylix.colors.base00-rgb-b + "," + ''0.55);
          border-radius: 8px;
          color: #'' + config.lib.stylix.colors.base07 + '';
          transition-property: background-color;
          transition-duration: .2s;
      }

      tooltip {
        color: #'' + config.lib.stylix.colors.base07 + '';
        background-color: rgba('' + config.lib.stylix.colors.base00-rgb-r + "," + config.lib.stylix.colors.base00-rgb-g + "," + config.lib.stylix.colors.base00-rgb-b + "," + ''0.9);
        border-style: solid;
        border-width: 3px;
        border-radius: 8px;
        border-color: #'' + config.lib.stylix.colors.base08 + '';
      }

      tooltip * {
        color: #'' + config.lib.stylix.colors.base07 + '';
        background-color: rgba('' + config.lib.stylix.colors.base00-rgb-r + "," + config.lib.stylix.colors.base00-rgb-g + "," + config.lib.stylix.colors.base00-rgb-b + "," + ''0.0);
      }

      window > box {
          border-radius: 8px;
          opacity: 0.94;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      button {
          border: none;
      }

      #custom-hyprprofile {
          color: #'' + config.lib.stylix.colors.base0D + '';
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
      }

      #workspaces button {
          padding: 0px 6px;
          background-color: transparent;
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #workspaces button:hover {
          color: #'' + config.lib.stylix.colors.base07 + '';
      }

      #workspaces button.active {
          color: #'' + config.lib.stylix.colors.base08 + '';
      }

      #workspaces button.focused {
          color: #'' + config.lib.stylix.colors.base0A + '';
      }

      #workspaces button.visible {
          color: #'' + config.lib.stylix.colors.base05 + '';
      }

      #workspaces button.urgent {
          color: #'' + config.lib.stylix.colors.base09 + '';
      }

      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #custom-hyprprofileicon,
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power,
      #mpd {
          padding: 0 3px;
          color: #'' + config.lib.stylix.colors.base07 + '';
          border: none;
          border-radius: 8px;
      }

      #custom-hyprprofileicon,
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power,
      #idle_inhibitor {
          background-color: transparent;
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #custom-hyprprofileicon:hover,
      #custom-quit:hover,
      #custom-lock:hover,
      #custom-reboot:hover,
      #custom-power:hover,
      #idle_inhibitor:hover {
          color: #'' + config.lib.stylix.colors.base07 + '';
      }

      #clock, #tray, #idle_inhibitor {
          padding: 0 5px;
      }

      #window,
      #workspaces {
          margin: 0 6px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          color: #'' + config.lib.stylix.colors.base0D + '';
      }

      #battery {
          color: #'' + config.lib.stylix.colors.base0B + '';
      }

      #battery.charging, #battery.plugged {
          color: #'' + config.lib.stylix.colors.base0C + '';
      }

      @keyframes blink {
          to {
              background-color: #'' + config.lib.stylix.colors.base07 + '';
              color: #'' + config.lib.stylix.colors.base00 + '';
          }
      }

      #battery.critical:not(.charging) {
          background-color: #'' + config.lib.stylix.colors.base08 + '';
          color: #'' + config.lib.stylix.colors.base07 + '';
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #'' + config.lib.stylix.colors.base00 + '';
      }

      #cpu {
          color: #'' + config.lib.stylix.colors.base0D + '';
      }

      #memory {
          color: #'' + config.lib.stylix.colors.base0E + '';
      }

      #disk {
          color: #'' + config.lib.stylix.colors.base0F + '';
      }

      #backlight {
          color: #'' + config.lib.stylix.colors.base0A + '';
      }

      label.numlock {
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      label.numlock.locked {
          color: #'' + config.lib.stylix.colors.base0F + '';
      }

      #pulseaudio {
          color: #'' + config.lib.stylix.colors.base0C + '';
      }

      #pulseaudio.muted {
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

      #idle_inhibitor {
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #idle_inhibitor.activated {
          color: #'' + config.lib.stylix.colors.base0F + '';
      }
      '';
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outer_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          font_color = "rgb(202, 211, 245)";
          placeholder_text = "Enter password ...";
        }
      ];

      label = [
        {
          text = "Hello 3c0m3x";
          font_size = 44;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 160";
        }
        {
          text = "$TIME";
          font_size = 32;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 75";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.hyprlock}";
        }
/*         {
          timeout = 305;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        } */
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.dunst = {
    enable = true;
    package = pkgs.dunst;
  };

  services.playerctld.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 6;
      TimeoutStopSec = 10;
    };
  };
}
