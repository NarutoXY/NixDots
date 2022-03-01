{ config, lib, pkgs, nix-colors, self, ... }:

# most of X configuration

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in {
  imports = [
    ./polybar
    ./sxhkd.nix
    ../common/default.nix
  ];

  # manage BSPWM
  xsession.windowManager.bspwm = {
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
        [ "greenclip daemon" "sh ~/.fehbg" "systemctl --user restart polybar.service" ];
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

        border_radius = 10;
      };
    };

}
