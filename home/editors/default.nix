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
  rustPkgs = with pkgs; [ rustup rust-analyzer ];
  pythonPkgs = with pkgs; [ python310 python310Packages.pip pipenv pyright ];
  gitPkgs = with pkgs; [ github-cli hub ];
  editorPkgs = with pkgs; [ neovim-nightly ];
  formatterPkgs = with pkgs; [ nodePackages.prettier ];
  lspPkgs = with pkgs; [
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
  ];
  cPkgs = with pkgs; [ gnumake gcc ];
  javaPkgs = with pkgs; [ jdk ];
  juliaPkgs = with pkgs; [ julia-stable-bin ];
  haskellPkgs = with pkgs; [ ghc haskellPackages.ghcide ];
  otherPkgs = with pkgs; [ sqlite ];
in {
  ### GIT
  programs.git = {
    enable = true;
    delta.enable = true;
    extraConfig = { hub.protocol = "ssh"; };
    ignores = [ "*~" "target" ".node_modules" "*.log" "*.swp" "result" "dist" ];
    signing = {
      key = "BA2B56A17A1FC0FA";
      signByDefault = true;
    };
    userEmail = "github@sandy007.anonaddy.com";
    userName = "Astro (Naruto Uzumaki)";
  };

  ## HELIX
  # home.file.".config/helix/config.toml".source = ./helix.toml;
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine";
      lsp.display-messages = true;
      editor = {
        scrolloff = 5;
        line-number = "relative";
      };
    };
  };

  ## NEOVIM STUFF
  home.file.".config/nvim/sqlite_path".text =
    "${pkgs.sqlite.out}/lib/libsqlite3.so";

  home.packages = luaPkgs ++ webPkgs ++ nixPkgs ++ juliaPkgs ++ goPkgs
    ++ rustPkgs ++ pythonPkgs ++ gitPkgs ++ lspPkgs ++ editorPkgs
    ++ formatterPkgs ++ cPkgs ++ javaPkgs ++ haskellPkgs ++ otherPkgs;
}
