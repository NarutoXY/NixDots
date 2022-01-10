{ config, pkgs, lib, ... }:

{
  ### WELCOME THE COOLEST KID IN THE TOWN
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJS = true;
    withRuby = true;
    withPython3 = true;
    package = pkgs.neovim;
  };

  ### THE MOST FAMOUS KID
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      vscodevim.vim
      esbenp.prettier-vscode
      golang.go
      dbaeumer.vscode-eslint
      ms-python.python
      ms-azuretools.vscode-docker
      VisualStudioExptTeam.vscodeintellicode # Surprised its better than copilot
      ritwickdey.LiveServer
      eamodio.gitlens
      PKief.material-icon-theme
      redhat.vscode-yaml
      GitHub.vscode-pull-request-github
      eg2.vscode-npm-script
      EditorConfig.EditorConfig
      wayou.vscode-todo-highlight
      hollowtree.vue-snippets
      ritwickdey.live-sass
      bradlc.vscode-tailwindcss
      svelte.svelte-vscode
      Equinusocio.vsc-community-material-theme
      rust-lang.rust
      codezombiech.gitignore
      rebornix.Ruby
      WallabyJs.quokka-vscode
      ms-vscode.js-debug-nightly
      julialang.language-julia
      KevinRose.vsc-python-indent
      mgmcdermott.vscode-language-babel
      christian-kohler.path-intellisense
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
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
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
    ignores = [ "*~" "*.swp" "result" "dist" ];
    signing = {
      key = "BA2B56A17A1FC0FA";
      signByDefault = true;
    };
    userEmail = "github@sandy007.anonaddy.com";
    userName = "Astro (Naruto Uzumaki)";
  };

  ### LUA
  lua = with pkgs; [
    luajit
    stylua
    sumneko-lua-language-server
    luajitPackages.luacheck
    selene
  ];

  ### NODE JS
  node = with pkgs; [
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

  ### GOLANG
  go = with pkgs; [ go go-langserver ];

  ### RUST
  rust = with pkgs; [ rustc cargo ];

  ### PYTHON
  python = with pkgs; [
    python3
    python39Packages.pip
    pipenv
    python-language-server
  ];

  ### RUBY
  ruby = with pkgs; [ ruby gem ];

  ### GITHUB
  gh = with pkgs; [ github-cli ];

  ### OTHERS
  others = with pkgs; [ gnumake android-tools gcc julia-stable-bin ];

  ### OTHER LSPS
  lsp = with pkgs; [
    rnix-lsp
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
  ];

  ### FMT
  fmt = with pkgs; [ stylua nix-fmt nodePackages.prettier ];

}
