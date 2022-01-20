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
        corner_radius = 8;
        font = "Operator Mono Medium 12";
        format = "<b>%s</b>\\n%b";
        width = 300;
        height = 200;
        horizontal_padding = 8;
        icon_position = "right";
        ignore_newline = "no";
        indicate_hidden = "yes";
        markup = "yes";
        max_icon_size = 96;
        transparency = 20;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        padding = 8;
        text_icon_padding = 3;
        frame_width = 3;
        separator_color = "auto";
        stack_duplicates = true;
        separator_height = 3;
        show_indicators = false;
        shrink = "no";
        word_wrap = "yes";
        sort = "yes";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_min_width = 200;
        progress_bar_max_width = 300;
      };
      fullscreen_delay_everything = { fullscreen = "delay"; };
      urgency_critical = {
        background = colors.base00;
        foreground = colors.base06;
        frame_color = colors.base08;
        timeout = 15;
      };
      urgency_low = {
        background = colors.base00;
        foreground = colors.base06;
        frame_color = colors.base09;
        timeout = 5;
      };
      urgency_normal = {
        background = colors.base00;
        foreground = colors.base07;
        frame_color = colors.base0C;
        timeout = 10;
      };
    };
  };
}

