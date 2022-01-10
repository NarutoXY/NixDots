{ pkgs, inputs, overlays, nix-colors, self, ... }:

# graphical session configuration
# includes programs and services that work on both Wayland and X

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;

in {
  # nixpkgs config
  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };

  imports = [
    ./editors
    ./app.nix
    ./cli.nix # base config
    ./terminal.nix
    ./x11/bspwm # x11 config
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Zafiro-icons";
      package = pkgs.zafiro-icons;
    };

    font = {
      name = "Lato";
      package = pkgs.lato;
    };

    gtk3.extraConfig = {
      gtk-theme-name = "catppuccin";
      gtk-font-name = "Sou";
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
