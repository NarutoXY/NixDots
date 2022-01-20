{ config, lib, pkgs, nix-colors, self, ... }:

# most of X configuration

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in {
  imports = [
    #./autorandr.nix
    ./dunst.nix
    # blur sucks and sucks a lot
    # ./picom.nix
    ./polybar
    ./rofi.nix
    ./sxhkd.nix
  ];

  # X specific programs
  home.packages = with pkgs; [
    dunst # for dunstctl
    playerctl
    xclip
    xorg.xprop
    xdotool
    xorg.xkill
    feh
    siduck76-st # hmm because it works on xorg
    libnotify
    wmctrl
  ];

  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          # userColors = [ colors.base01 colors.base05 colors.base09 colors.base08 colors.base0A colors.base0B colors.base0C "picker" ];
          uiColor = colors.base02;
          contrastUiColor = colors.base01;
          drawColor = colors.base0D;
        };
      };
    };
  };

  # manage X session
  xsession = {
    enable = true;
    # to be able to use system-configured sessions alongside HM ones
    scriptPath = ".xsession-hm";
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    preferStatusNotifierItems = true;

    windowManager.bspwm = {
      enable = true;
      package = pkgs.bspwm.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitHub {
          owner = "j-james";
          repo = "bspwm-rounded-corners";
          rev = "00e85df0505d2bfbd41234d1daf2f03c461b6a2b";
          sha256 = "Bw2Cju5bcFnHUSc4C85mc9Kyg2pt+X3H1bwQQKokszY=";
        };
      });
      rules = {
        "Firefox" = { desktop = "^2"; };
        "qutebrowser" = { desktop = "^2"; };
        "Vivaldi-stable" = { desktop = "^2"; };
        "Code" = { desktop = "^3"; };
        "mpv" = { desktop = "^4"; };
      };
      startupPrograms =
        [ "sh ~/.fehbg" "systemctl --user restart polybar.service" ];
      monitors = { VGA1 = [ "1" "2" "3" "4" "5" ]; };
      settings = {
        border_width = 2;
        window_gap = 10;

        active_border_color = colors.base0C;
        focused_border_color = colors.base0D;
        normal_border_color = colors.base02;
        presel_feedback_color = colors.base0B;

        split_ratio = 0.5;
        single_monocle = true;

        top_padding = 28;
        bottom_padding = 0;
      };
    };
  };

  xresources.properties = {
    #! special
    "*.foreground" = colors.base05;
    "*.background" = colors.base00;

    # black
    "*.color0" = colors.base00;
    "*.color8" = colors.base01;
    # red
    "*.color1" = colors.base08;
    "*.color9" = colors.base08;
    # green
    "*.color2" = colors.base0B;
    "*.color10" = colors.base0B;
    # yellow
    "*.color3" = colors.base0A;
    "*.color11" = colors.base0A;
    # blue
    "*.color4" = colors.base0D;
    "*.color12" = colors.base0D;
    # magenta
    "*.color5" = colors.base0E;
    "*.color13" = colors.base0E;
    # cyan
    "*.color6" = colors.base0C;
    "*.color14" = colors.base0C;
    # white
    "*.color7" = colors.base05;
    "*.color15" = colors.base05;

    # Xft
    "Xft.antialias" = 1;
    "Xft.hiniting" = 1;
    "Xft.autohint" = 0;
    "Xft.hintstyle" = "hintslight";
    "Xft.rgba" = "rgb";
    "Xft.lcdfilter" = "lcddefault";

    # ST
    "st.borderpx" = 15;
    "st.font" = "VictorMono Nerd Font:style:medium:pixelsize=15";
    "st.alpha" = "0.8";
  };
}
