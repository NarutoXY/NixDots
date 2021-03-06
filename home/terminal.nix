{ pkgs, nix-colors, self, ... }:

# terminals

let
  inherit (self.lib) mapAttrs x0 x;
  font = "Iosevka SS09";
  ifont = "Iosevka SS09";
  acolors = mapAttrs (n: v: x0 v) nix-colors.colors;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty-ligatures;
    settings = {
      env = { "TERM" = "xterm-256color"; };
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
      };

      scrolling.history = 10000;

      font = {
        normal.family = font;
        bold.family = ifont;
        italic.family = ifont;
        size = 13;
        use_thin_strokes = true;
        offset.y = -1;
        glyph_offset.y = -1;
      };
      cursor.style = "Block";
      draw_bold_text_with_bright_colors = false;
      colors = rec {
        primary = {
          background = acolors.base00;
          foreground = acolors.base05;
        };
        normal = {
          black = acolors.base02;
          red = acolors.base08;
          green = acolors.base0B;
          yellow = acolors.base0A;
          blue = acolors.base0D;
          magenta = acolors.base0E;
          cyan = acolors.base0C;
          white = acolors.base05;
        };
        bright = normal // {
          black = acolors.base03;
          white = acolors.base06;
        };
      };
      shell.program = "zsh";
    };
  };

  programs.kitty = {
    enable = true;
    font.name = font;
    font.size = 13;
    settings = {
      italic_font = ifont;
      bold_font = ifont;
      scrollback_lines = 10000;
      window_padding_width = 4;
      shell = "zsh";
      enable_audio_bell = "no";
      update_check_interval = 0;

      # colors
      foreground = colors.base05;
      background = colors.base00;
      # selection
      selection_background = colors.base02;
      selection_foreground = colors.base06;
      # cursor
      cursor = colors.base05;
      cursor_text_color = colors.base03;
      # black
      color0 = colors.base00;
      color8 = colors.base01;
      # red
      color1 = colors.base08;
      color9 = colors.base08;
      # green
      color2 = colors.base0B;
      color10 = colors.base0B;
      # yellow
      color3 = colors.base0A;
      color11 = colors.base0A;
      # blue
      color4 = colors.base0D;
      color12 = colors.base0D;
      # magenta
      color5 = colors.base0E;
      color13 = colors.base0E;
      # cyan
      color6 = colors.base0C;
      color14 = colors.base0C;
      # white
      color7 = colors.base05;
      color15 = colors.base05;
      # url
      url_color = colors.base0C;
      # tabs
      active_tab_foreground = colors.base05;
      active_tab_background = colors.base02;
      active_tab_font_style = "normal";
      inactive_tab_foreground = colors.base04;
      inactive_tab_background = colors.base01;
      inactive_tab_font_style = "normal";
    };
  };
}

# vim:set expandtab ft=nix ts=2 sw=2 noet:
