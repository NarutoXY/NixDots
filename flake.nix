{
  description = "YλNC: Yet λnother NixOS configuration";

  inputs = {

    # UTILS
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "fu";
    };
    fu.url = "github:numtide/flake-utils";

    # CORE DEPS
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

		# ONLY ARCH DOESNT HAS USER REPO :KEK:
    nurpkgs = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # COLORS YAY
    nix-colors.url = "github:narutoxy/nix-colors";

    # NIX LSP
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # OVERLAY 
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, utils, nurpkgs, ... }@inputs:
    let
      extraSpecialArgs = {
        inherit inputs self nurpkgs home-manager;
        nix-colors = inputs.nix-colors.colorSchemes.catppuccin;
				overlays = [ inputs.neovim-nightly-overlay.overlay inputs.nurpkgs.overlay ];
      };
    in {
      # inherit self inputs;
      # System configurations
      # Accessible via 'nixos-rebuild --flake'
      nixosConfigurations = {
        lambda = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/lambda
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;
                useGlobalPkgs = false;
                useUserPackages = true;
                users.naruto = import ./home;
              };
            }
          ];
          # Pass our flake inputs into the config
          specialArgs = { inherit inputs; };
        };
      };

      lib = import ./lib { inherit (nixpkgs) lib; };
    };
}

# vim:set expandtab ft=nix ts=2 sw=2 noet:
