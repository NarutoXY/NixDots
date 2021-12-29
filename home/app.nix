{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ##### SYSTEM ADMIN TOOLS ##### -----
    killall
    gotop
    xdg-user-dirs

    ##### NETWORK TOOLS ##### -----------
    curl
    axel
    qutebrowser
    vivaldi
    vivaldi-widevine
    vivaldi-ffmpeg-codecs

    ##### FILE MANIPULATION TOOLS ##### -
    trash-cli
    xfceUnstable.thunar
    unzip

    ##### SHELLS ##### ------------------
    tmux

    ##### BSPWM ##### --------------------
    i3lock-color
    xclip
    eww

    ##### MULTIMEDIA ##### --------------
    mpv
    sxiv

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
    fzf
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
    # PYTHON
    python3
    python39Packages.pip
    pipenv
    # RUBY
    ruby
    gem
    #JULIA
    julia-stable-bin
    #SHELL
    shellcheck
  ];
}
