{ config, pkgs, ... }:

{
  home.packages = [ pkgs.pure-prompt ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    autocd = true;
    dirHashes = {
      dl = "$HOME/downloads/";
      docs = "$HOME/documents/";
      code = "$HOME/projects/";
      the = "$HOME/projects/themer/";
      dots = "$HOME/.config/nixpkgs/";
      pics = "$HOME/pics/";
      vids = "$HOME/vids/";
      nixpkgs = "$HOME/.config/nixpkgs/";
    };
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    initExtraBeforeCompInit = ''
      # p10k instant prompt
      local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        file = "p10k.zsh";
        name = "powerlevel10k-config";
        src = ./p10k.zsh; # Some directory containing your p10k.zsh file
      }
    ];

    initExtra = ''
      # autoloads
      autoload -U history-search-end

      # search history based on what's typed in the prompt

      # group functions
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end

      # bind functions to up and down arrow keys
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # case insensitive tab completion
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' list-colors '\'
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' verbose true
      _comp_options+=(globdots)

      ${builtins.readFile ./nix-completions.sh}
    '';
    shellAliases = {
      switch = "home-manager switch";
      rebuid = "sudo nixos-rebuild switch";
      ls = "exa -laHG --icons";
      top = "gotop";
      v = "nvim";
    };

    shellGlobalAliases = { exa = "exa --icons --git"; };
  };
}
