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
			character = {
				success_symbol = "[](bold green)";
				error_symbol = "[](bold red)";
			};
			scan_timeout = 100;
		};
	};
	
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
		};

  programs.zsh = {
    enable = true;
		enableCompletion = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
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
			${builtins.readFile ./mappings.zsh}
			${builtins.readFile ./options.zsh}
			${builtins.readFile ./compe-tweaks.zsh}
      ${builtins.readFile ./nix-completions.sh}
    '';
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/";
      ls = "exa -laHG --icons";
      top = "gotop";
      v = "nvim";
      nv = "nvim";
    };

    shellGlobalAliases = { exa = "exa --icons --git"; };
  };
}

# vim:set filetype=nix:
