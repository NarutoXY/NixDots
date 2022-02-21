{ config, pkgs, ... }:

{
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
                  # Compe tweaks
      	          ${builtins.readFile ./compe-tweaks.zsh}
                  # Nix Completions
                  ${builtins.readFile ./nix-completions.sh}
             	    # Per directory history
                  ${builtins.readFile ./per-directory-history.zsh}
                  # SSH Agent
                  eval $(ssh-agent -s) > /dev/null
                  ssh-add ~/.ssh/github > /dev/null 2>&1
              '';
    shellAliases = {
      ls = "exa -laHG --icons --git";
      switch = "nixos-rebuild switch --flake ~/.config/nixpkgs";
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
