{ config, pkgs, ... }:

{
  services.picom = {
    package = pkgs.picom-next;
    enable = true;
    experimentalBackends = true;
    blur = true;
    blurExclude = [
      "class_g = 'slop'"
      "class_i = 'polybar'"
      "class_g = 'Firefox' && argb"
    ];
    fade = true;
    fadeDelta = 5;
    fadeSteps = [ "0.03" "0.03" ];
    backend = "glx";
    vSync = true;
    refreshRate = 60;
    shadow = false;
    shadowOffsets = [ (-12) (-12) ];
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "class_g = 'slop'"
      "class_g = 'Firefox' && argb"
      "class_g = 'Rofi'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
    activeOpacity = "1.0";
    inactiveOpacity = "1.0";
    opacityRule = [
      "10:class_g = 'Bspwm'"
      "80:class_g = 'URxvt'"
      "80:class_g = 'UXTerm'"
      "80:class_g = 'XTerm'"
      "80:class_g = 'Alacritty'"
      "80:class_g = 'St'"
      "80:class_g = 'Kitty'"
    ];
    menuOpacity = "0.99";
    noDNDShadow = true;
    noDockShadow = true;
    extraOptions = ''
      no-fading-openclose = false;
      no-fading-destroyed-argb = true;

      frame-opacity = 1;
      inactive-opacity-override = false;

      focus-exclude = [
      	"class_g = 'Cairo-clock'",
      	"class_g ?= 'rofi'",
      	"class_g ?= 'slop'",
      	"class_g ?= 'Steam'"
      ];

      blur: {
      	method = "dual_kawase";
        strength = 5.0;
      	deviation = 1.0;
      	kernel = "11x11gaussian";
      }

      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
    '';
  };
}
