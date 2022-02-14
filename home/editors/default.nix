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
  editorPkgs = with pkgs; [ neovim ];
  formatterPkgs = with pkgs; [ nodePackages.prettier ];
  lspPkgs = with pkgs; [
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
  ];
  cPkgs = with pkgs; [ gnumake gcc ];
  juliaPkgs = with pkgs; [ julia-stable-bin ];
in {
  ### THE MOST FAMOUS KID
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      vscodevim.vim
      esbenp.prettier-vscode
      golang.go
      dbaeumer.vscode-eslint
      ms-python.python
      ms-azuretools.vscode-docker
      # VisualStudioExptTeam.vscodeintellicode # Surprised its better than copilot
      # ritwickdey.LiveServer
      eamodio.gitlens
      pkief.material-icon-theme
      redhat.vscode-yaml
      github.vscode-pull-request-github
      # eg2.vscode-npm-script
      editorconfig.editorconfig
      # wayou.vscode-todo-highlight
      # hollowtree.vue-snippets
      # ritwickdey.live-sass
      bradlc.vscode-tailwindcss
      svelte.svelte-vscode
      # equinusocio.vsc-community-material-theme
      # rust-lang.rust
      codezombiech.gitignore
      # rebornix.ruby
      # WallabyJs.quokka-vscode
      # ms-vscode.js-debug-nightly
      # julialang.language-julia
      # kevinrose.vsc-python-indent
      # mgmcdermott.vscode-language-babel
      # christian-kohler.path-intellisense
    ];
    userSettings = {
      "update.channel" = "none";
      "[nix][typescript][javascript][vue][svelte][tsx][jsx]"."editor.tabSize" =
        2;
      "workbench.iconTheme" = "material-icon-theme";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 5000;
      "terminal.external.osxExec" = "st";
      "terminal.integrated.shell.osx" = "zsh";
      "editor.wordWrap" = "on";
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.minimap.enabled" = false;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = true;
      "editor.guides.bracketPairsHorizontal" = true;
      "editor.guides.highlightActiveBracketPair" = true;
      "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.fontFamily" = "Victor Mono SemiBold";
      "editor.fontLigatures" = true;
      "explorer.decorations.badges" = false;
      "editor.fontSize" = 16;
      "typescript.suggest.paths" = false;
      "javascript.suggest.paths" = false;
    };
  };

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

  home.packages = luaPkgs ++ webPkgs ++ nixPkgs ++ juliaPkgs ++ goPkgs ++ rustPkgs ++ pythonPkgs ++ gitPkgs
    ++ lspPkgs ++ editorPkgs ++ formatterPkgs ++ cPkgs;
}
