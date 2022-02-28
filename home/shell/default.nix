{ config, nix-colors, self, ... }:

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in {
  imports = [ ./common.nix ./zsh ./fish.nix ];

  # add locations to $PATH
  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
  # add environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    SHELL = "zsh";
    # make java apps work in tiling WMs
    _JAVA_AWT_WM_NONREPARENTING = 1;
    VISUAL = "nvim";
    TERMINAL = "alacritty";

    # XDG DIRS
    XDG_DESKTOP_DIR = "$HOME/.desktop";
    XDG_DOWNLOAD_DIR = "$HOME/downloads";
    XDG_TEMPLATES_DIR = "$HOME/templates";
    XDG_PUBLICSHARE_DIR = "$HOME/projects";
    XDG_DOCUMENTS_DIR = "$HOME/documents";
    XDG_MUSIC_DIR = "$HOME/music";
    XDG_PICTURES_DIR = "$HOME/pics";
    XDG_VIDEOS_DIR = "$HOME/vids";
    XDG_USB_DIR = "$HOME/usb";

    # ZSH SPECIFIC
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=${colors.base03},underline";
  };
}
