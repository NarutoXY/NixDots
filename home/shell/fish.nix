{ pkgs, config, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "exa -laHG --icons --git";
      rebuild = "nixos-rebuild switch --flake ~/.config/nixpkgs";
      top = "btop";
      v = "nvim";
      tmp = "cd (mktemp -d)";
      ".." = "cd ..";
    };

    shellAbbrs = {
      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gca = "git commit --amend";
      gcm = "git commit -m";
      gco = "git checkout";
      gd = "git diff";
      gds = "git diff --staged";
      gp = "git push";
      gpl = "git pull";
      gl = "git log";
      gr = "git rebase";
      gs = "git status --short";
      gss = "git status";

      us = "systemctl --user";

      grep = "grep --color";
      ip = "ip --color";
      md = "mkdir -p";
      rm = "rip"; # I am used to rm but rip is :noice:
    };
        interactiveShellInit =
      # Use vim bindings and cursors
      ''
        fish_vi_key_bindings
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block
      '' +
      # Use terminal colors
      ''
        set -U fish_color_autosuggestion      brblack
        set -U fish_color_cancel              -r
        set -U fish_color_command             brgreen
        set -U fish_color_comment             brmagenta
        set -U fish_color_cwd                 green
        set -U fish_color_cwd_root            red
        set -U fish_color_end                 brmagenta
        set -U fish_color_error               brred
        set -U fish_color_escape              brcyan
        set -U fish_color_history_current     --bold
        set -U fish_color_host                normal
        set -U fish_color_match               --background=brblue
        set -U fish_color_normal              normal
        set -U fish_color_operator            cyan
        set -U fish_color_param               normal
        set -U fish_color_quote               yellow
        set -U fish_color_redirection         bryellow
        set -U fish_color_search_match        'bryellow' '--background=brblack'
        set -U fish_color_selection           'white' '--bold' '--background=brblack'
        set -U fish_color_status              red
        set -U fish_color_user                brgreen
        set -U fish_color_valid_path          --underline
        set -U fish_pager_color_completion    normal
        set -U fish_pager_color_description   yellow
        set -U fish_pager_color_prefix        'white' '--bold' '--underline'
        set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      '';
    #plugins = [
    #  {
    #    name = "z";
    #    src = pkgs.fetchFromGitHub {
    #      owner = "jethrokuan";
    #      repo = "z";
    #      rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
    #      sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
    #    };
    #  }
    #  {
    #    name = "hydro";
    #    src = pkgs.fetchFromGitHub {
    #      repo = "hydro";
    #      owner = "jorgebucaran";
    #      rev = "5d06a596f75ce397d6c92eb47f05601ad5645710";
    #      sha256 = "1fg2wjv7qn9c5fjq27bfv593i2mwavz16r3yw76975f6n8xsx33l";
    #    };
    #  }
    #  {
    #    name = "fish-async-prompt";
    #    src = pkgs.fetchFromGitHub {
    #      repo = "fish-async-prompt";
    #      owner = "acomagu";
    #      rev = "40f30a4048b81f03fa871942dcb1671ea0fe7a53";
    #      sha256 = "13qhwbyqqlxild3arivyf1q2g1anzrpny7d67fq8p9yszwp0lb4n";
    #    };
    #  }
    #  {
    #    name = "autopair.fish";
    #    src = pkgs.fetchFromGitHub {
    #      repo = "autopair.fish";
    #      owner = "jorgebucaran";
    #      rev = "1222311994a0730e53d8e922a759eeda815fcb62";
    #      sha256 = "0qhj2w133c0cpn06jbdq2xynjhqchixfpdx8h14bk7wk2fj2qjks";
    #    };
    #  }
    #  {
    #    name = "sponge";
    #    src = pkgs.fetchFromGitHub {
    #      repo = "sponge";
    #      owner = "andreiborisov";
    #      rev = "0f3bf8f10b81b25d2b3bbb3d6ec86f77408c0908";
    #      sha256 = "1wxrawb36k81zd97ikws1yaal29bxyxl9qr3za98sdcprn64h7dn";
    #    };
    #  }
    #  {
    #    name = "gitnow";
    #    src = pkgs.fetchFromGitHub {
    #      repo = "gitnow";
    #      owner = "joseluisq";
    #      rev = "9a118d90bc0a07fb32fe3714efd30e52aab04d5e";
    #      sha256 = "1xl09x8jn0lfalrxgfnbnjbi4vjr5czkvmyzzwik689z69bpsa7q";
    #    };
    #  }
    #];
  };
}
