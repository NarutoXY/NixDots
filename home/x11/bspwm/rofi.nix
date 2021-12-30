{ config, pkgs, nix-colors, self, ... }:

# rofi config

let
  inherit (self.lib) mapAttrs xrgba x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
  rcolors = mapAttrs (n: v: xrgba v) nix-colors.colors;
in
{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };

      extraConfig = {
        show-icons = true;
				modi = "window, drun, run";
        display-window = "";
        display-drun = "";
        drun-display-format = "{icon} {name}";
      };

      font = "SF Mono 9";

      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            accent = mkLiteral "#${colors.base0A}";
            on = mkLiteral "#${colors.base0B}";
            off = mkLiteral "#${colors.base08}";
            foreground = mkLiteral "#${colors.base06}";
            background = mkLiteral "#${colors.base02}";
          };

          window = {
            transparency = "real";
            background-color = mkLiteral "${rcolors.base00}";
            border = mkLiteral "2px";
            border-color = mkLiteral "@accent";
            border-radius = mkLiteral "10px";
            height = mkLiteral "53%";
            width = mkLiteral "50%";
          };

          entry = {
            background-color = mkLiteral "#0000";
            text-color = mkLiteral "@foreground";
            placeholder = "Search...";
            placeholder-color = mkLiteral "#666";
            horizontal-align = mkLiteral "0.5";
            blink = true;
          };

          inputbar = {
            children = map mkLiteral [ "entry" ];
            background-color = mkLiteral "#0000";
            text-color = mkLiteral "@foreground";
          };

          listview = {
            background-color = mkLiteral "#0000";
            columns = 5;
            spacing = mkLiteral "1%";
            cycle = true;
            layout = mkLiteral "vertical";
          };

          mainbox = {
            background-color = mkLiteral "#0000";
            children = map mkLiteral [ "inputbar" "listview" ];
            spacing = mkLiteral "2%";
            padding = mkLiteral "1em";
          };

          element = {
            background-color = mkLiteral "#0000";
            text-color = mkLiteral "@foreground";
            orientation = mkLiteral "vertical";
            padding = mkLiteral "2.5% 0%";
          };

          element-icon.size = mkLiteral "64px";

          element-text = {
            horizontal-align = mkLiteral "0.5";
            vertical-algin = mkLiteral "0.5";
          };

          "element selected" = {
            background-color = mkLiteral "@accent";
            border-radius = mkLiteral "10px";
            text-color = mkLiteral "@background";
          };

          "element selected.urgent" = {
            background-color = mkLiteral "@off";
            text-color = mkLiteral "@background";
          };

          "element selected.active" = {
            background-color = mkLiteral "@on";
            color = mkLiteral "@foreground";
          };
        };
    };
  };
}
