{ config, pkgs, inputs, self, nix-colors, ... }:

# minimal config, suitable for servers

let
  inherit (self.lib) mapAttrs x0 x;
  font = "Victor Mono Medium";
  acolors = mapAttrs (n: v: x0 v) nix-colors.colors;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in 
{
  imports = [
    # shell config
    ./shell
    ./app.nix
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
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${pkgs.fd}/bin/fd --hidden --type f --exclude '.git' --exclude '.pnpm-store' --exclude 'node_modules'";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
      defaultOptions = [ 
      "--prompt='~ ' --pointer='▶' --marker='✗'" 
      "--layout=reverse" 
      "--multi" 
      "--sort"
      "--color=fg:-1,bg:-1,hl:${colors.base0D}"
      "--color=fg+:${colors.base06},bg+:${colors.base01},hl+:${colors.base0C}"
      "--color=info:${colors.base09},prompt:${colors.base08},pointer:${colors.base08}"
      "--color=marker:${colors.base0B},spinner:${colors.base0D},header:${colors.base0C}'"
      "--bind '?:toggle-preview'"
      "--bind 'ctrl-a:select-all'"
      "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
      "--height=80%" 
      "--preview-window=:hidden"
      "--info=inline"
      "--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
      ];
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --hidden --exclude '.git' --exclude '.pnpm-store' --exclude 'node_modules'";
      historyWidgetOptions = [ "--sort" ];

    };
    gpg.enable = true;
    ssh.enable = true;
  };
}
