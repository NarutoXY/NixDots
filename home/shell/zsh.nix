{ config, pkgs, ... }:

{
  home.packages = [ pkgs.pure-prompt ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = false;
    enableZshIntegration = false;
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
    zplug = {
      enable = true;
      plugins = [
        {
          name = "mafredri/zsh-async";
          tags = [ "from:github" ];
        }
        {
          name = "sindresorhus/pure";
          tags = [ "use:pure.zsh" "from:github" "as:theme" ];
        }
        {
          name = "zsh-users/zsh-history-substring-search";
          tags = [ "from:github" ];
        }
        {
          name = "jimhester/per-directory-history";
          tags =
            [ "from:github" "use:zsh-per-directory-history.zsh" ];
        }
        {
          name = "chisui/zsh-nix-shell";
          tags = [ "from:github" ];
        }
        {
          name = "zsh-users/zsh-syntax-highlighting";
          tags = [ "from:github" ];
        }
        {
          name = "zsh-users/zsh-autosuggestions";
          tags = [ "from:github" ];
        }
        {
          name = "zsh-users/zsh-completions";
          tags = [ "from:github" ];
        }
      ];
    };
    enable = true;
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

    initExtra = ''
      			# Mappings
            ${builtins.readFile ./mappings.zsh}
            # Options
            ${builtins.readFile ./options.zsh}
            # Nix Completions
            ${builtins.readFile ./nix-completions.sh}
            # SSH Agent
            eval $(ssh-agent -s) > /dev/null
            ssh-add ~/.ssh/github > /dev/null 2>&1
                      '';
    shellAliases = {
      ls = "exa -laHG --icons --git";
      switch = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs";
      top = "btop";
      v = "nvim";
      nv = "nvim";
      tmp = " cd $(mktemp -d)";

      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gca = "git commit --amend";
      gcm = "git commit -m";
      gco = "git checkout";
      gd = "git diff";
      gds = "git diff --staged";
      gp = "git push";
      gpl = "git pull";
      gl = "git log";
      gr = "git rebase";
      gs = "git status --short";
      gss = "git status";

      us = "systemctl --user";

      grep = "grep --color";
      ip = "ip --color";
      md = "mkdir -p";
      rm = "rip"; # I am used to rm but rip is :noice:
    };
  };
}
