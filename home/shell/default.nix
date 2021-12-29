{ config, ... }:

{
  imports = [
    ./nix.nix
    ./zsh.nix
  ];

  # add locations to $PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
  # add environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    # make java apps work in tiling WMs
    _JAVA_AWT_WM_NONREPARENTING = 1;
    VISUAL = "code";
    TERMINAL = "kitty";
    SHELL = "zsh";
    XDG_DESKTOP_DIR = "$HOME/.desktop";
    XDG_DOWNLOAD_DIR = "$HOME/downloads";
    XDG_TEMPLATES_DIR = "$HOME/templates";
    XDG_PUBLICSHARE_DIR = "$HOME/projects";
    XDG_DOCUMENTS_DIR = "$HOME/documents";
    XDG_MUSIC_DIR = "$HOME/music";
    XDG_PICTURES_DIR = "$HOME/pics";
    XDG_VIDEOS_DIR = "$HOME/vids";
    XDG_USB_DIR = "$HOME/usb";
  };
}
