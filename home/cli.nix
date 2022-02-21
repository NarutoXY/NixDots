{ config, pkgs, inputs, self, nix-colors, ... }:

# minimal config, suitable for servers

let
  inherit (self.lib) mapAttrs x0 x;
  font = "Victor Mono SemiBold";
  acolors = mapAttrs (n: v: x0 v) nix-colors.colors;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in {
  imports = [
    # shell config
    ./shell
  ];

  programs.home-manager.enable = true;
  home = {
    username = "naruto";
    homeDirectory = "/home/naruto";
    stateVersion = "20.09";
  };

  xdg.enable = true;

  services = {
    gpg-agent = {
      enable = true;
      extraConfig = ''
        pinentry-program ${pkgs.pinentry}/bin/pinentry
      '';
    };
  };

  programs = {
    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand =
        "${pkgs.fd}/bin/fd --hidden --type f --exclude '.git' --exclude '.pnpm-store' --exclude 'node_modules'";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
      defaultOptions = [
        "--layout=reverse"
        "--multi"
        "--color=fg:${colors.base05},bg:${colors.base00},current_bg:${colors.base01},info:${colors.base09}"
        "--bind '?:toggle-preview'"
        "--bind 'alt-a:select-all'"
        "--bind 'alt-d:deselect-all'"
        "--bind 'alt-e:execute(echo {+} | xargs -o nvim)'"
        "--height=80%"
        "--preview-window=:hidden"
        "--inline-info"
        "--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
      ];
      changeDirWidgetCommand =
        "${pkgs.fd}/bin/fd --type d --hidden --exclude '.git' --exclude '.pnpm-store' --exclude 'node_modules'";
    };
    gpg.enable = true;
    ssh.enable = true;

    exa = { enable = true; };
    bat = {
      enable = true;
      config = { theme = "TwoDark"; };
    };
    jq.enable = true;
  };

  home.packages = with pkgs; [
    haskellPackages.greenclip
    ripgrep
    tealdeer
    hyperfine
    btop
    rm-improved
    glow
    tree
  ];
}
