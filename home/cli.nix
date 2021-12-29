{ config, pkgs, inputs, ... }:

# minimal config, suitable for servers

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
        pinentry-program ${pkgs.pinentry.qt}/bin/pinentry
      '';
    };
  };

  programs = {
    git = {
      enable = true;
      delta.enable = true;
      ignores = [ "*~" "*.swp" "result" "dist" ];
      # signing = {
      #   key = "3AC82B48170331D3";
      #   signByDefault = true;
      # };
      userEmail = "github@sandy007.anonaddy.com";
      userName = "Astro (Naruto Uzumaki)";
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    ssh.enable = true;
  };
}
