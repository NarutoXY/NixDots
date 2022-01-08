{ nix-colors, config, pkgs, self,  ... }:

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
in
{
  # notification daemon
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons";
      package = pkgs.zafiro-icons;
    };
    settings = {
      global = {
        alignment = "center";
        corner_radius = 5;
        follow = "mouse";
        font = "Lato 10";
        format = "<b>%s</b>\\n%b";
        frame_width = 2;
        geometry = "250x200-15+50";
        horizontal_padding = 8;
        icon_position = "left";
        ignore_newline = "no";
        indicate_hidden = "yes";
        markup = "yes";
        max_icon_size = 96;
        transparency = 20;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        padding = 8;
        plain_text = "no";
        separator_color = "auto";
        separator_height = 1;
        show_indicators = false;
        shrink = "no";
        word_wrap = "yes";
        sort = "yes";
      };
      fullscreen_delay_everything = { fullscreen = "delay"; };
      urgency_critical = {
        background = colors.base01;
        foreground = colors.base05;
        frame_color = colors.base08;
      };
      urgency_low = {
        background = colors.base01;
        foreground = colors.base05;
        frame_color = colors.base0A;
      };
      urgency_normal = {
        background = colors.base01;
        foreground = colors.base05;
        frame_color = colors.base0B;
      };
    };
  };
}

