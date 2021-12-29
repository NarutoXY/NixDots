{ pkgs, inputs, overlays, nix-colors, self, ... }:

# graphical session configuration
# includes programs and services that work on both Wayland and X

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in

{
  # nixpkgs config
  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };

  imports = [
    ./app.nix
    ./cli.nix # base config
    ./terminal.nix
    ./x11/bspwm # x11 config
  ];

  gtk = {
    enable = true;

    font = {
      name = "Cantarell";
      package = pkgs.cantarell-fonts;
    };

    iconTheme = {
      name = "Zafiro-icons";
      package = pkgs.zafiro-icons;
    };

    gtk3.extraConfig = {
      gtk-theme-name = "tokyodark";
    };
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-beta-bin;
      profiles.naruto = { };
    };

    zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-darkcolor = "#${colors.base00}";
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.7)";
        default-fg = "#${colors.base06}";
      };
    };
  };
}

# vim:set expandtab ft=nix ts=2 sw=2 noet:
