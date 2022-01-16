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
        "height" = "18";
        "padding-left" = "1";
        "padding-right" = "1";

        "background" = "${colors.base00}";
        "foreground" = "${colors.base05}";
        "bottom" = false;
        "border-top-size" = 5;
        "border-bottom-size" = 5;
        "border-top-color" = "${colors.base00}";
        "border-bottom-color" = "${colors.base00}";
        "fixed-center" = true;
        "line-size" = 1;
        "wm-restack" = "bspwm";

        "modules-left" =
          "round-left bspwm round-right";
        "modules-center" = "";
        "modules-right" =
          "round-left mpris pulseaudio round-right empty-space empty-space round-left wlan round-right empty-space empty-space round-left date round-right empty-space round-left powermenu round-right";
        "font-0" = "VictorMono Nerd Font:style=SemiBold:pixelsize=9;3";
        "font-1" = "VictorMono Nerd Font:size=14;4";
        "font-2" = "Material Design Icons:style=Bold:size=9;3";
        "font-3" = "unifont:fontformat=truetype:size=9;3";
      };
      "module/round-left" = {
        "type" = "custom/text";
        "content" = "%{T3}%{T-}";
        "content-foreground" = "${colors.base02}";
      };
      "module/round-right" = {
        "type" = "custom/text";
        "content" = "%{T3}%{T-}";
        "content-foreground" = "${colors.base02}";
      };
      "module/empty-space" = {
        "type" = "custom/text";
        "content" = " ";
      };
        "module/bspwm" = {

        "type" = "internal/bspwm";

        "pin-workspaces" = true;
        "strip-wsnumbers" = true;
        "inline-mode" = true;
        "index-sort" = true;

        "enable-click" = true;
        "enable-scroll" = true;

        "wrapping-scroll" = false;
        "reverse-scroll" = false;

        "ws-icon-0" = "1;I";
        "ws-icon-1" = "2;II";
        "ws-icon-2" = "3;III";
        "ws-icon-3" = "4;IV";
        "ws-icon-4" = "5;V";

        "format" = "<label-state>";

        "label-focused" = "%icon%";
        # label-focused = %index%
        "label-focused-foreground" = "${colors.base05}";
        "label-focused-background" = "${colors.base02}";
        "label-focused-padding" = 1;
        "label-focused-margin" = 0;

        "label-separator" = " ";
        "label-separator-background" = "${colors.base02}";

        "label-occupied" = " %icon%";
        "label-occupied-foreground" = "${colors.base04}";
        "label-occupied-background" = "${colors.base02}";
        "label-occupied-padding" = 1;

        "label-empty" = "%icon%";
        "label-empty-foreground" = "${colors.base03}";
        "label-empty-background" = "${colors.base02}";
        "label-empty-padding" = 1;
        "label-empty-margin" = 0;

        "label-urgent" = "%icon%";
        "label-urgent-foreground" = "${colors.base08}";
        "label-urgent-background" = "${colors.base02}";
        "label-urgent-padding" = 1;
      };
      "module/powermenu" = {
        "type" = "custom/text";

        "click-left" = "rofi -show power-menu -modi power-menu:~/.local/bin/rofi-power-menu";

        "content" = " ";
        "content-padding" = 1;
        "content-background" = "${colors.base02}";
        "content-foreground" = "${colors.base08}";
      };
      "module/date" = {
"type" = "internal/date";
"interval" = 60;

"format" = "<label>";
"format-background" = "${colors.base02}";
"format-foreground" = "${colors.base04}";

"date" = "󰥔 %H:%M%{F-}";
"time-alt" = "󰃭 %a, %b %d%{F-}";

"label" = "%date%%time%";
    };
    "module/wlan" = {
"type" = "internal/network";
"interface" = "enp2s0";
"interval" = "3.0";
"format-connected" =  "<label-connected>";
"label-connected" = "󰤪 " ;
"label-connected-foreground" = "${colors.base0B}";
"format-connected-background" = "${colors.base02}";
        };
      "module/polywins" = {
        "type" = "custom/script";

        "exec" = "$HOME/.local/bin/polywins";

        "tail" = true;

        "format" = "<label>";

        "label" = "%output%";
        "format-background" = "${colors.base02}";
        "label-padding" = 0;
      };
      "module/pulseaudio" = {
        "type" = "internal/pulseaudio";
        "sink" = "";
        "use-ui-max" = false;
        "interval" = 5;
        "click-right" = "${pkgs.pavucontrol}/bin/pavucontrol";

        "format-volume" = "<ramp-volume> <label-volume>";
        "format-volume-foreground" = "${colors.base0D}";
        "format-volume-background" = "${colors.base02}";
        "label-muted" = "󰸈 ";
        "label-muted-foreground" = "${colors.base08}";
        "label-muted-background" = "${colors.base02}";

        "ramp-volume-0" = "󰕿";
        "ramp-volume-1" = "󰖀 ";
        "ramp-volume-2" = "󰕾 ";
        "label-background" = "${colors.base02}";
      };
          
    "module/mpris" = {
        "type" = "custom/script";

        "exec" = "${mprisScript}/bin/mpris";
        "tail" = "true";

        "label-maxlen" = 100;

        "interval" = 1;
        "format" = "󰎆 <label>";
        "format-padding" = 1;
        "format-foreground" = "${colors.base0C}";
        "format-background" = "${colors.base02}";
      };
      "module/separatorText" = {
        "type" = "custom/text";

        "content" = "•";
        "content-foreground" = "${colors.base03}";
        "content-padding" = 0;
      };
    };

    script = ''
      # killall -q polybar
      # while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
      bspc monitor "VGA1" -d "1" "2" "3" "4" "5"
      polybar main &
    '';
  };
}
