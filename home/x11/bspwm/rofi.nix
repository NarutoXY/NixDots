{ config, pkgs, nix-colors, self, ... }:

# rofi config

let
  inherit (self.lib) mapAttrs xrgba x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in
{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };

      extraConfig = {
        show-icons = true;
				modi = "window,drun,run";
        display-window = "";
        display-drun = "";
				sidebar-mode = false;
        drun-display-format = "{name}";
      };

      font = "SF Mono 9";
	  	theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in {
						"*" = {
							bg = mkLiteral "${colors.base00}";
							fg = mkLiteral "${colors.base05}";
							button = mkLiteral "${colors.base04}";
							};
						window = {
							transparency = "real";
							border-radius = mkLiteral "7px";
							width = mkLiteral "40%";
							y-offset = mkLiteral "10px";
							padding = mkLiteral "20px";
							location = mkLiteral "south";
							};
						prompt = {
								enabled = false;
							};
						entry = {
								placeholder = "Search";
								expand = true;
								padding = mkLiteral "5px 2% 5px 2%";
								background-color = mkLiteral "@button";
								placeholder-color = mkLiteral "@fg";
							};
						inputbar = {
								children = map mkLiteral [ "prompt", "entry" ];
								background-color = mkLiteral "@button";
								text-color = mkLiteral "@fg";
								expand = false;
								border-radius = mkLiteral "6px";
								padding = mkLiteral "8px";
							};
						listview = {
								columns = mkLiteral "1";
								lines = mkLiteral "8";
								cycle = false;
								dynamic = true;
								layout = mkLiteral "vertical";
							};
						mainbox = {
								children = map mkLiteral [ "inputbar", "listview" ];
								spacing = mkLiteral "2%";
								padding = mkLiteral "2% 1% 2% 1%";
							};
						element = {
								orientation = mkLiteral "vertical";
								border-radius = mkLiteral "0%";
								padding = mkLiteral "1.5% 0% 1.5% 1.5%";
							};

						element-text = {
								expand = true;
								vertical-align = mkLiteral "0.5";
								margin = mkLiteral "0.5% 3% 0% 3%";
								background-color = mkLiteral "inherit";
								text-color = mkLiteral "inherit";
							};
						"element selected" = {
								background-color = mkLiteral "@fg";
								text-color = mkLiteral "@bg";
								border-radius = mkLiteral "6px";
							};
					};
    };
  };
}
