{ config, pkgs, ... }:

{
  home.packages = [ pkgs.pure-prompt ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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
      sudo.disabled = false;
      status.disabled = false;
      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vicmd_symbol = "[](bold green)";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "viins";
    autocd = true;
    dotDir = ".config/zsh";
    history = {
      size = 500000;
      save = 500000;
      extended = false;
      share = false;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    plugins = [
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
    ];

    initExtra = ''
      			# Mappings
      			${builtins.readFile ./mappings.zsh}
      			# Options
      			${builtins.readFile ./options.zsh}
                  # Nix Completions
                  ${builtins.readFile ./nix-completions.sh}
                  # Per Directory History
                  ${builtins.readFile ./per-directory-history.zsh}
                  # fzf-tab
                  source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh
                  # SSH Agent
                  eval $(ssh-agent -s) > /dev/null
                  ssh-add ~/.ssh/github > /dev/null 2>&1
          '';
    shellAliases = {
      ls = " exa -laHG --icons --git";
      top = "btop";
      v = "nvim";
      nv = "nvim";
      tmp = " cd $(mktemp -d)";
    };
  };
}

# vim:set filetype=nix:
