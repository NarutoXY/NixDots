{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ##### SYSTEM ADMIN TOOLS ##### -----
    killall
    btop
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

    ##### FILE MANIPULATION TOOLS ##### -
    trash-cli
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
  
    ytmdesktop
  ];
}
