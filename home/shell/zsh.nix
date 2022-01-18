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
staged = ''[ $count ](green)'';
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
            ${builtins.readFile ./per-directory-history.zsh}
            ${builtins.readFile ./per-directory-history.zsh}
            ${builtins.readFile ./ssh-agent.zsh}
            source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh
    '';
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/";
      ls = "exa -laHG --icons";
      top = "gotop";
      v = "nvim";
      nv = "nvim";
      tmp = " cd $(mktemp -d)";
    };

    shellGlobalAliases = { exa = "exa --icons --git"; };
  };
}

# vim:set filetype=nix:
