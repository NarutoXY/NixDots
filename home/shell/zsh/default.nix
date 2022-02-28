{ config, pkgs, ... }:

{
  programs.zsh = {
    zplug = {
      enable = true;
      plugins = [
        {
          name = "mafredri/zsh-async";
        }
        {
          name = "sindresorhus/pure";
          tags = [ "use:pure.zsh" "as:theme" ];
        }
        {
          name = "chisui/zsh-nix-shell";
          tags = [ "defer:1" "on:'zsh-users/zsh-completions'" ];
        }
        {
          name = "zsh-users/zsh-syntax-highlighting";
          tags = [ "defer:3" "on:'zsh-users/zsh-autosuggestions'"];
        }
        {
          name = "zsh-users/zsh-autosuggestions";
          tags = [ "defer:2" "on:'zsh-users/zsh-completions'" ];
        }
        {
          name = "zsh-users/zsh-completions";
          tags = [ "defer:0" ];
        }
        {
          name = "spwhitt/nix-zsh-completions";
          tags = [ "defer:0" ];
        }
        {
          name = "zsh-users/zsh-history-substring-search";
          tags = [ "defer:3" "on:'zsh-users/zsh-syntax-highlighting'" ];
        }
        {
          name = "Aloxaf/fzf-tab";
          tags = [ "defer:1" "on:'zsh-users/zsh-completions'" ];
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
                  # Options
                  ${builtins.readFile ./options.zsh}
             	    # Per directory history
                  ${builtins.readFile ./per-directory-history.zsh}
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
