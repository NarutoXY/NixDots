{ config, pkgs, self, nix-colors, ... }:
let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;

  mprisScript = pkgs.callPackage ./mpris.nix { };
in {
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;

    config = {
      "bar/main" = {
        "tray-position" = "right";
        "monitor" = "VGA1";
        "width" = "100%";
        "height" = "28";
        "padding-left" = "1";
        "padding-right" = "0";

        "background" = "${colors.base01}";
        "foreground" = "${colors.base05}";
        "bottom" = false;
        "border-top-size" = 5;
        "border-bottom-size" = 5;
        "border-top-color" = "${colors.base01}";
        "border-bottom-color" = "${colors.base01}";
        "fixed-center" = true;
        "line-size" = 1;
        "wm-restack" = "bspwm";

        "modules-left" =
          "circleStart2 bspwm circleEnd";
        "modules-center" = "circleStart2 polywins circleEnd";
        "modules-right" =
          "circleStart2 date_i date circleEnd separator circleStart2 pulseaudio circleEnd separator separatorText separator circleStart2 powermenu circleEnd";
        "font-0" = "Victor Mono:style=Bold:pixelsize=9;3";
        "font-1" = "JetBrainsMono Nerd Font:size=14;4";
        "font-2" = "Material Design Icons:size=9;3";
        "font-3" = "unifont:fontformat=truetype:size=9;3";
      };
      "module/separator" = {
        "type" = "custom/text";
        "content" = " ";
      };
      "module/bspwm" = {

        "type" = "internal/bspwm";

        "pin-workspaces" = true;
        "strip-wsnumbers" = true;
        "index-sort" = true;

        "enable-click" = true;
        "enable-scroll" = true;

        "wrapping-scroll" = false;
        "reverse-scroll" = false;

        "ws-icon-0" = "I";
        "ws-icon-1" = "II";
        "ws-icon-2" = "III";
        "ws-icon-3" = "IV";
        "ws-icon-4" = "V";
        "ws-icon-5" = "VI";
        # "ws-icon-default" = "";

        "format" = "<label-state>";

        "label-focused" = "◆";
        # label-focused = %index%
        "label-focused-foreground" = "${colors.base0B}";
        "label-focused-background" = "${colors.base02}";
        "label-focused-padding" = 1;
        "label-focused-font" = 4;

        "label-occupied" = "◇";
        "label-occupied-foreground" = "${colors.base05}";
        "label-occupied-background" = "${colors.base02}";
        "label-occupied-padding" = 1;
        "label-occupied-font" = 4;

        "label-empty" = "◇";
        "label-empty-foreground" = "${colors.base04}";
        "label-empty-background" = "${colors.base02}";
        "label-empty-padding" = 1;
        "label-empty-font" = 4;

        "label-urgent" = "◇";
        "label-urgent-foreground" = "${colors.base08}";
        "label-urgent-background" = "${colors.base02}";
        "label-urgent-padding" = 1;
        "label-urgent-font" = 4;

        "label-mode" = "%mode%";
        "label-mode-padding" = 1;
        "label-mode-foreground" = "${colors.base05}";
        "label-mode-background" = "${colors.base02}";
      };
      "module/powermenu" = {
        "type" = "custom/text";

        "click-left" = "rofi -show power-menu -modi power-menu:~/.local/bin/rofi-power-menu";

        "content" = "";
        "content-background" = "${colors.base02}";
        "content-foreground" = "${colors.base08}";
        "content-font" = 1;
      };

      "module/date" = {
        "type" = "internal/date";

        "interval" = "1.0";

        "format" = "<label>";
        "format-background" = "${colors.base02}";
        "format-foreground" = "${colors.base0B}";
        "format-padding" = 1;

        # time = %H:%M // %a %d/%m
        "time" = "%H:%M";
        "time-alt" = "%b %d, %Y ~ %A";
        "label" = "%time% ";
      };
      "module/date_i" = {
        "type" = "internal/date";

        "interval" = "1.0";

        "format" = "<label>";
        "format-background" = "${colors.base02}";
        "format-foreground" = "${colors.base0C}";
        "format-padding" = 1;

        # time = %H:%M // %a %d/%m
        "time" = "";
        "time-alt" = "%b %d, %Y ~ %A";
        "label" = "%time%";
      };
      "module/dashboard" = {
        "type" = "custom/text";

        "click-right" = "rofi -show dmenu";

        "content" = " ";
        "content-background" = "${colors.base01}";
        "content-foreground" = "${colors.base05}";
      };
      "module/polywins" = {
        "type" = "custom/script";

        "exec" = "$HOME/.local/bin/polywins";

        "tail" = true;

        "format" = "<label>";

        "label" = "%output%";
        "label-background" = "${colors.base02}";
        "label-padding" = 1;
      };
      "module/pulseaudio" = {
        "type" = "internal/pulseaudio";
        "sink" = "";
        "use-ui-max" = false;
        "interval" = 5;
        "click-right" = "${pkgs.pavucontrol}/bin/pavucontrol";

        "format-volume" = "<ramp-volume> <label-volume>";
        "format-volume-foreground" = "${colors.base0D}";
        "label-muted" = "󰸈 ";
        "label-muted-foreground" = "${colors.base0D}";

        "ramp-volume-0" = "󰕿";
        "ramp-volume-1" = "󰖀";
        "ramp-volume-2" = "󰕾";
        "label-background" = "${colors.base02}";
        "label-muted-foreground" = "${colors.base05}";
      };
      "module/circleStart2" = {
        "type" = "custom/text";

        "content" = "";
        "content-foreground" = "${colors.base02}";
        "content-font" = 2;
      };
      "module/circleStart" = {
        "type" = "custom/text";

        "content" = "";
        "content-foreground" = "${colors.base01}";
        "content-font" = 2;
      };
      "module/circleEnd" = {
        "type" = "custom/text";

        "content" = "";
        "content-foreground" = "${colors.base02}";
        "content-font" = 2;
      };
      "module/separatorTriangle" = {
        "type" = "custom/text";

        "content" = "";
        "content-foreground" = "${colors.base01}";
        "content-background" = "${colors.base02}";
        "content-font" = 2;
      };
      "module/mpris" = {
        "type" = "custom/script";

        "exec" = "${mprisScript}/bin/mpris";
        "tail" = "true";

        "label-maxlen" = 100;

        "interval" = 1;
        "format" = "󰎆 <label>";
        "format-padding" = 2;
      };
      "module/separatorText" = {
        "type" = "custom/text";

        "content" = "•";
        "content-foreground" = "${colors.base03}";
        "content-padding" = 0;
        "content-font" = 2;
      };
      "module/separatorText2" = {
        "type" = "custom/text";

        "content" = "• ";
        "content-foreground" = "${colors.base02}";
        "content-padding" = 0;
      };
      "module/separatorIndent" = {
        "type" = "custom/text";

        "content" = " ";
        "content-foreground" = "${colors.base03}";
        "content-padding" = 0;
      };
    };

    script = ''
      # killall -q polybar
      # while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

      polybar main &
    '';
  };
}
