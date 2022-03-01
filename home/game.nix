{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ minecraft steam lutris minetest gamemode osu-lazer ];
}
