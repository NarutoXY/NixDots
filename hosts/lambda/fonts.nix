{ config, pkgs, lib, ... }:

{
  fonts = {
    fonts = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      cantarell-fonts
      cascadia-code
      victor-mono

      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["SF Pro Display" "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "SF Pro Display" "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "SF Mono" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
