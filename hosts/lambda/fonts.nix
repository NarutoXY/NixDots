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
      (nerdfonts.override {
        fonts = [ "FiraCode" "JetBrainsMono" "VictorMono" ];
      })
    
      (pkgs.iosevka-bin.override { variant = "ss09"; })
      (pkgs.iosevka-bin.override { variant = "etoile"; })
      (pkgs.iosevka-bin.override { variant = "aile"; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "Iosevka Etoile" "Noto Color Emoji" ];
      sansSerif = [ "Iosevka Aile" "Noto Color Emoji" ];
      monospace = [ "Iosevka SS09" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
