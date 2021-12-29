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

    # DEVSHELL
    devshell.url = "github:numtide/devshell";

    # COLORS YAY
    nix-colors.url = "github:narutoxy/nix-colors";

    # NIX LSP
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "fu";
    };

    # PICOM
    picom = { url = "github:yshui/picom"; flake = false; };

    # OVERLAY 
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  };

  outputs = { self, nixpkgs, home-manager, utils, ... }@inputs:
    let
      extraSpecialArgs = {
        inherit inputs self;
        nix-colors = inputs.nix-colors.colorSchemes.rose-pine;
        overlays = [ inputs.neovim-nightly-overlay.overlay ];
      };
    in
    {
      #inherit self inputs;
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
                useGlobalPkgs = true;
                useUserPackages = true;
                users.naruto = import ./home;
              };
            }
          ];
          # Pass our flake inputs into the config
          specialArgs = { inherit inputs; };
        };
      };

      # # Home configurations
      # # Accessible via 'home-manager --flake'
      # homeConfigurations = {
      #   "naruto@lambda" = home-manager.lib.homeManagerConfiguration rec {
      #     inherit extraSpecialArgs;
      #     username = "naruto";
      #     homeDirectory = "/home/${username}";
      #     configuration = { };
      #     system = "x86_64-linux";
      #     pkgs = self.pkgs.${system}.nixpkgs;
      #     extraModules = [
      #       # Adds your overlay and packages to nixpkgs
      #       # { nixpkgs.overlays = self.overlays; }
      #       # Adds your custom home-manager modules
      #       ./home
      #     ];
      #     # Pass our flake inputs into the config
      #     # extraSpecialArgs = { inherit inputs; };
      #   };
      # };
      lib = import ./lib { inherit (nixpkgs) lib; };
    };
}

# vim:set expandtab ft=nix ts=2 sw=2 noet:
