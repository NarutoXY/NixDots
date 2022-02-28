{ pkgs, config, inputs, ... }:

# nix tooling and common stuff

{
  home.packages = with pkgs; [
    nixpkgs-fmt
    # inputs.rnix-lsp.defaultPackage.x86_64-linux
    rnix-lsp
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = false;
    enableZshIntegration = false;
    enableBashIntegration = false;
    enableFishIntegration = false;
    settings = {
      add_newline = true;
      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        ahead = "⇡ $count ";
        behind = "⇣ $count ";
        diverged = " $count ";
        stashed = "📦 $count ";
        staged = "[ $count ](green)";
        renamed = "  $count ";
        untracked = "🤷 $count ";
        style = "bold red";
      };
      hg_branch.symbol = " ";
      git_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      nix_shell.symbol = " ";
      python.symbol = " ";
      directory.read_only = "  ";
      scan_timeout = 100;
      sudo.disabled = true;
      status.disabled = false;
      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vicmd_symbol = "[](bold green)";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
