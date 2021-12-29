{ config, pkgs, nix-colors, self, ... }:

# most of X configuration

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in
{
  imports = [
    #./autorandr.nix
    ./dunst.nix
    #./picom.nix
    ./polybar
    ./rofi.nix
    ./sxhkd.nix
  ];

  # X specific programs
  home.packages = with pkgs; [
    dunst # for dunstctl
    maim
    playerctl
    xclip
    xdotool
    xorg.xkill
    xdragon # file drag n drop
  ];

  programs.feh.enable = true;

  services = {
    flameshot.enable = true;
  };

  # manage X session
  xsession = {
    enable = true;
    # to be able to use system-configured sessions alongside HM ones
    scriptPath = ".xsession-hm";
    pointerCursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
      size = 24;
    };

    preferStatusNotifierItems = true;

    windowManager.bspwm = {
      enable = true;
      rules = {
        "Firefox" = { desktop = "^2"; };
        "Vivaldi-stable" = { desktop = "^2"; };
        "Code" = { desktop = "^3"; };
      };
      startupPrograms = [
        "systemctl --user restart polybar"
        "sh ~/.fehbg"
        "eww daemon"
        "picom --config ~/.config/picom/picom.conf"
      ]; # Do not kill me please for these many startup Programs :pleading_face:
      monitors = {
        "VGA1" = [ "1" "2" "3" "4" ];
      };
      settings = {
        border_width = 2;
        window_gap = 25;

        active_border_color = colors.base08;
        focused_border_color = colors.base02;
        normal_border_color = colors.base0A;
        presel_feedback_color = colors.base0B;

        split_ratio = 0.5;
        borderless_monocle = true;
        gapless_monocle = true;
        single_monocle = true;

        top_padding = 35;
        bottom_padding = 0;
      };
    };
  };

  xresources.properties = {
    #! special
    "*.foreground" = colors.base06;
    "*.background" = colors.base00;

    # black
    "*.color0" = colors.base02;
    "*.color8" = colors.base03;
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
    "*.color7" = colors.base06;
    "*.color15" = colors.base07;
  };
}
