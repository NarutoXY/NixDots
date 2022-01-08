{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ##### SYSTEM ADMIN TOOLS ##### -----
    killall
    gotop
    xdg-user-dirs
	
	###########################################
	##### DONT DELETE THIS PACKAGE PLEASE #####
	###########################################
	gnome3.dconf
	###########################################
	###########################################

    ##### NETWORK TOOLS ##### -----------
    curl
    axel
    qutebrowser
    vivaldi
    vivaldi-widevine
    vivaldi-ffmpeg-codecs

    ##### FILE MANIPULATION TOOLS ##### -
    trash-cli
    pcmanfm
    unzip

    ##### SHELLS ##### ------------------
    tmux

    ##### BSPWM ##### --------------------
    i3lock-color
    xclip
    eww

    ##### MULTIMEDIA ##### --------------
    mpv

    ##### CHEATSHEET ##### --------------
    tealdeer

    ##### RUST UTILS ##### --------------
    exa
    broot
    ripgrep
    bat
    hyperfine
    dua
    rm-improved

    ##### MISC UTILS ##### --------------
    glow

    ##### DEVELOP ##### -----------------
    # ANDROID
    android-tools
    # MAKE
    gnumake
    # VERSION CONTROL
    github-cli
    # THE ULTIMATE CODE EDITORS
    neovim
    vscode
    # GO
    go
    # LUA
    stylua
    luajit
    luarocks
    luajitPackages.luacheck
    sumneko-lua-language-server
    # C
    gcc
    # RUST
    cargo
    # WEB DEV
    nodejs
    nodePackages.pnpm
    jq
	  nodePackages.vscode-langservers-extracted
	  nodePackages."@tailwindcss/language-server"
    # nodePackages."@volar/server"
	  nodePackages.node2nix
    nodePackages.vim-language-server
	  nodePackages.yaml-language-server
	  nodePackages.bash-language-server
	  nodePackages.svelte-language-server
    nodePackages.typescript
	  nodePackages.typescript-language-server
    nodePackages.dockerfile-language-server-nodejs
	  go-langserver
	# ZIG
	zls
	zig
	# PYTHON
    python3
    python39Packages.pip
    pipenv
    python-language-server
	# RUBY
    ruby
    gem
    #JULIA
    julia-stable-bin
    #SHELL
    shellcheck
  ];
}
