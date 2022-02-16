{ config, pkgs, lib, ... }:
let
  luaPkgs = with pkgs; [
    luajit
    stylua
    sumneko-lua-language-server
    luajitPackages.luacheck
    selene
  ];
  webPkgs = with pkgs; [
    nodejs
    nodePackages.pnpm
    jql
    nodePackages.eslint
    nodePackages.svelte-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.node2nix
    nodePackages."@tailwindcss/language-server"
    nodePackages.vscode-langservers-extracted
    nodePackages.vls
  ];
  nixPkgs = with pkgs; [ nixfmt rnix-lsp ];
  goPkgs = with pkgs; [ go gopls ];
  rustPkgs = with pkgs; [rustup rust-analyzer ];
  pythonPkgs = with pkgs; [ python311 python311Packages.pip pipenv pyright ];
  gitPkgs = with pkgs; [ github-cli hub ];
  editorPkgs = with pkgs; [ helix neovim ];
  formatterPkgs = with pkgs; [ nodePackages.prettier ];
  lspPkgs = with pkgs; [
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
  ];
  cPkgs = with pkgs; [ gnumake gcc ];
  juliaPkgs = with pkgs; [ julia-stable-bin ];
in {
  ### GIT
  programs.git = {
    enable = true;
    delta.enable = true;
    extraConfig = { 
			hub.protocol = "ssh";
    };
		ignores = [ "*~" "target" ".node_modules" "*.log" "*.swp" "result" "dist" ];
    signing = {
      key = "BA2B56A17A1FC0FA";
      signByDefault = true;
    };
    userEmail = "github@sandy007.anonaddy.com";
    userName = "Astro (Naruto Uzumaki)";
  };

  home.file.".config/helix/config.toml".source = ./helix.toml;

  home.packages = luaPkgs ++ webPkgs ++ nixPkgs ++ juliaPkgs ++ goPkgs ++ rustPkgs ++ pythonPkgs ++ gitPkgs
    ++ lspPkgs ++ editorPkgs ++ formatterPkgs ++ cPkgs;
}
