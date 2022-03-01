{ config, pkgs, self, lib, nix-colors, ...}:

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in
{
  imports = [ ./rofi.nix ];

  # X specific programs
  home.packages = with pkgs; [
    # dunst # for dunstctl
    xorg.xinit
    playerctl
    xclip
    xorg.xprop
    xdotool
    xorg.xkill
    feh
    libnotify
    wmctrl
    betterlockscreen
  ];
  
  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 5;
      lockCmd = ''
        betterlockscreen -l
      '';
      xautolock = { extraOptions = [ "-corners ++++" ]; };
    };
    flameshot = {
      enable = true;
      settings = {
        General = {
          uiColor = colors.base02;
          contrastUiColor = colors.base01;
          drawColor = colors.base0D;
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };
  };
  
  # manage X session
  xsession = {
    enable = true;
    # to be able to use system-configured sessions alongside HM ones
    scriptPath = ".xsession";
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    preferStatusNotifierItems = true;
  };

  xresources.properties = {
    #! special
    "*.foreground" = colors.base05;
    "*.background" = colors.base00;

    # black
    "*.color0" = colors.base01;
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
    "Xft.antialias" = true;
    "Xft.hiniting" = true;
    "Xft.autohint" = false;
    "Xft.hintstyle" = "hintfull";
    "Xft.rgba" = "rgb";
    "Xft.lcdfilter" = "lcddefault";
  };

  home.file.".xinitrc".text = "source ~/.xsession";
}
