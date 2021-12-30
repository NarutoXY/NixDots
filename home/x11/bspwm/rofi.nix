{ config, pkgs, nix-colors, self, ... }:

# rofi config

let
  inherit (self.lib) mapAttrs xrgba x;
in
{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };

      extraConfig = {
        show-icons = true;
				modi = "window, drun, run";
        display-window = "";
        display-drun = "";
        drun-display-format = "{name}";
      };

      font = "SF Mono 9";
	  	theme = ./config.rasi;
    };
  };
}
