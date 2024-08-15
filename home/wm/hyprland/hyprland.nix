{ config, lib, pkgs, userSettings, ... }:

{
  imports = [
    ../../app/terminal/kitty.nix
    ../../app/terminal/alacritty.nix
    ../../app/browser/brave.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = WLR_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1
      env = GDK_BACKEND,wayland,x11,*
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = CLUTTER_BACKEND,wayland
      env = GDK_PIXBUF_MODULE_FILE,${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache

      exec-once = nm-applet
      exec-once = blueman-applet
      exec-once = waybar
      exec-once = hypridle
      exec-once = hyprpaper
      exec-once = dunst

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
        layout = dwindle
        border_size = 2
        resize_on_border = false
        gaps_in = 7
        gaps_out = 7
        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
       }
      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
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

       bind=SUPER,V,exec,wl-copy $(wl-paste | tr '\n' ' ')
       bind=SUPERSHIFT,T,exec,screenshot-ocr
       bind=CTRLALT,Delete,exec,hyprctl kill
       bind=SUPERSHIFT,K,exec,hyprctl kill

       bind=SUPER,RETURN,exec,alacritty
       bind=SUPER,A,exec,wofi --show drun
       bind=SUPER,Q,killactive
       bind=SUPERSHIFT,Q,exit
       bindm=SUPER,mouse:272,movewindow
       bindm=SUPER,mouse:273,resizewindow
       bind=SUPER,T,togglefloating

       ## App launchers

       bind=SUPER,B,exec,firefox
       bind=SUPER,E,exec,nautilus

       #bind=SHIFT,P,exec,grim -g "$(slurp -o)"
       bind=SUPER,P,exec,grim
       bind=CTRL,P,exec,grim -g "$(slurp)" - | wl-copy
       bind=SHIFTCTRL,P,exec,grim -g "$(slurp -o)" - | wl-copy
       bind=SUPERCTRL,P,exec,grim - | wl-copy


       bind=SUPERCTRL,S,exec,systemctl suspend
       bind=SUPERCTRL,L,exec,hyprlock

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

       ### Hotkeys ###

       bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10
       bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10
       bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
       bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t

       # Brightness control
       #bind=,XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl s 1%-
       #bind=,XF86MonBrightnessUP,exec,${pkgs.brightnessctl}/bin/brightnessctl s 1%+

      # Media control
       bind=,XF86AudioPlay,exec,playerctl play-pause # toggle between media play and pause
       bind=,XF86AudioPause,exec,playerctl play-pause # toggle between media play and pause
       bind=,XF86AudioNext,exec,playerctl next # media next
       bind=,XF86AudioPrev,exec,playerctl previous # media previous


       #bind=SUPER,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop
       #bind=SUPER,F,exec,pypr toggle ranger && hyprctl dispatch bringactivetotop
       #bind=SUPER,N,exec,pypr toggle numbat && hyprctl dispatch bringactivetotop
       #bind=SUPER,M,exec,pypr toggle music && hyprctl dispatch bringactivetotop
       #bind=SUPER,B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop
       #bind=SUPER,D,exec,hypr-element
       #bind=SUPER,code:172,exec,pypr toggle pavucontrol && hyprctl dispatch bringactivetotop
       #$scratchpadsize = size 80% 85%

       #$scratchpad = class:^(scratchpad)$
       #windowrulev2 = float,$scratchpad
       #windowrulev2 = $scratchpadsize,$scratchpad
       #windowrulev2 = workspace special silent,$scratchpad
       #windowrulev2 = center,$scratchpad

       #windowrulev2 = float,class:^(Element)$
       #windowrulev2 = size 85% 90%,class:^(Element)$
       #windowrulev2 = center,class:^(Element)$

       #windowrulev2 = float,class:^(lollypop)$
       #windowrulev2 = size 85% 90%,class:^(lollypop)$
       #windowrulev2 = center,class:^(lollypop)$

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

       #$miniframe = title:\*Minibuf.*
       #windowrulev2 = float,$miniframe
       #windowrulev2 = size 64% 50%,$miniframe
       #windowrulev2 = move 18% 25%,$miniframe
       #windowrulev2 = animation popin 1 20,$miniframe

       #windowrulev2 = float,class:^(pokefinder)$

       #windowrulev2 = opacity 0.80,title:ORUI

       #windowrulev2 = opacity 1.0,class:^(org.qutebrowser.qutebrowser),fullscreen:1
       #windowrulev2 = opacity 0.85,class:^(Element)$
       #windowrulev2 = opacity 0.85,class:^(lollypop)$
       windowrulev2 = opacity 1.0,class:^(Brave-browser),fullscreen:1
       windowrulev2 = opacity 1.0,class:^(librewolf),fullscreen:1
       windowrulev2 = opacity 1.0,class:^(firefox),fullscreen:1
       #windowrulev2 = opacity 0.85,title:^(My Local Dashboard Awesome Homepage - qutebrowser)$
       #windowrulev2 = opacity 0.85,title:\[.*\] - My Local Dashboard Awesome Homepage
       #windowrulev2 = opacity 0.85,class:^(org.keepassxc.KeePassXC)$
       windowrulev2 = opacity 0.85,class:^(org.gnome.Nautilus)$
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
       monitor=HDMI-A-1,3440x1440@100,0x0,1

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
    wlr-randr
    wtype
    ydotool
    wl-clipboard
    hyprland-protocols
    hyprpicker
    hyprpaper
    hypridle
    hyprlock
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
          background-color: transparent;
          border-radius: 8px;
          color: white;
          transition-property: background-color;
          transition-duration: .2s;
      }

      tooltip {
        color: white;
        background-color: black;
        border-style: solid;
        border-width: 3px;
        border-radius: 8px;
        border-color: white;
      }

      tooltip * {
        color: white;
        background-color: transparent;
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
          color: white;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
      }

      #workspaces button {
          padding: 0px 6px;
          background-color: transparent;
          color: white;
      }

      #workspaces button:hover {
          color: white;
      }

      #workspaces button.active {
          color: white;
      }

      #workspaces button.focused {
          color: white;
      }

      #workspaces button.visible {
          color: white;
      }

      #workspaces button.urgent {
          color: white;
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
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power,
      #mpd {
          padding: 0 3px;
          color: white;
          border: none;
          border-radius: 8px;
      }

      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power,
      #idle_inhibitor {
          background-color: transparent;
          color: white;
      }

      #custom-quit:hover,
      #custom-lock:hover,
      #custom-reboot:hover,
      #custom-power:hover,
      #idle_inhibitor:hover {
          color: white;
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
          color: white;
      }

      #battery {
          color: white;
      }

      #battery.charging, #battery.plugged {
          color: white;
      }

      @keyframes blink {
          to {
              background-color: transparent;
              color: white;
          }
      }

      #battery.critical:not(.charging) {
          background-color: transparent;
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: transparent;
      }

      #cpu {
          color: white;
          margin: 0 6px;
      }

      #memory {
          color: white;

      }

      #disk {
          color: white;
      }

      #backlight {
          color: white;
      }

      label.numlock {
          color: white;
      }

      label.numlock.locked {
          color: white;
      }

      #pulseaudio {
          color: white;

      }

      #pulseaudio.muted {
          color: white;

      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

      #idle_inhibitor {
          color: white;
      }

      #idle_inhibitor.activated {
          color: white;
      }
      '';
  };

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      monitor =
      #path = screenshot

      # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
      blur_passes = 4
      blur_size = 5
      noise = 0.0117
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
    }

    # doesn't work yet
    #image {
    #  monitor =
    #  path = /home/ecomex/Media/Pictures/Avatars/istockphoto-519165604-170667a.jpg  
    #  size = 150 # lesser side if not 1:1 ratio
    #  rounding = -1 # negative values mean circle
    #  border_size = 0
    #  rotate = 0 # degrees, counter-clockwise
    #  position = 0, 300
    #  halign = center
    #  valign = center
    #}

    input-field {
      monitor =
      size = 200, 50
      outline_thickness = 3
      dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb(151515)
      inner_color = rgb(200, 200, 200)
      font_color = rgb(10, 10, 10)
      fade_on_empty = false
      fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
      placeholder_text = <i>Enter Password...</i> # Text rendered in the input box when it's empty.
      hide_input = false
      rounding = -1 # -1 means complete rounding (circle/oval)
      check_color = rgb(204, 136, 34)
      fail_color = rgb(204, 34, 34)
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
      fail_transition = 300 # transition time in ms between normal outer_color and fail_color
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off
      swap_font_color = false # see below

      position = 0, -60
      halign = center
      valign = center
    }

    label {
      monitor =
      text = Hello, 3c0m3x
      color = rgba(200, 200, 200, 1.0)
      font_size = 25
      font_family = Noto Sans

      rotate = 0 # degrees, counter-clockwise

      position = 0, 160
      halign = center
      valign = center
    }
  '';

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
        timeout = 900;
        on-timeout = "hyprlock";
        }
        {
        timeout = 1200;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.dunst = {
    enable = true;
    package = pkgs.dunst;
  };

  services.playerctld.enable = true;
  programs.feh.enable = true;
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
