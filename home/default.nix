{ config, nixpkgs, pkgs, nurpkgs, inputs, overlays, nix-colors, self, ... }:

# graphical session configuration
# includes programs and services that work on both Wayland and X

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };
	
	# PACKAGES
	essentialPkgs = with pkgs; [
		dconf
		killall
		htop
	];

	networkPkgs = with pkgs; [
		curl
		axel
	];
	
	filePkgs = with pkgs; [
		unzip
		trash-cli
		gnome.nautilus
	];

	socialPkgs = with pkgs; [
		ytmdesktop
		youtube-dl
	];

in with inputs.nix-colors.lib { inherit pkgs; }; {
  # nixpkgs config
  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };

  imports = [
    ./editors
    ./cli.nix # base config
    ./terminal.nix
    ./x11/bspwm # x11 config
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Zafiro-icons";
      package = pkgs.zafiro-icons;
    };

    font = {
      name = "Victor Mono SemiBold";
      package = pkgs.victor-mono;
    };

    theme = {
      name = "${nix-colors.slug}";
      package = gtkThemeFromScheme { scheme = nix-colors; };
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-beta-bin;
      profiles.astro = {
        name = "astro";
        id = 0;
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "checkDefaultBrowser" = false;
          "browser.startup.page" = 3;
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" =
            false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false; # see [NOTE]
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false; # [FF55+]
          "toolkit.telemetry.shutdownPingSender.enabled" = false; # [FF55+]
          "toolkit.telemetry.updatePing.enabled" = false; # [FF56+]
          "toolkit.telemetry.bhrPing.enabled" =
            false; # [FF57+] Background Hang Reporter
          "toolkit.telemetry.firstShutdownPing.enabled" = false; # [FF57+]
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "breakpad.reportURL" = "";
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.fixup.alternate.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.formfill.enable" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.available" = "off";
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "dom.security.https_only_mode" = false;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "dom.disable_beforeunload" = false;
          "dom.disable_window_move_resize" = false;
          "dom.disable_open_during_load" = false;
          "beacon.enabled" = false;
          "network.cookie.thirdparty.sessionOnly" = true;
          "network.cookie.thirdparty.nonsecureSessionOnly" = true;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        isDefault = true;
      };
      extensions = with nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        i-dont-care-about-cookies
        stylus
        surfingkeys
        terms-of-service-didnt-read
        return-youtube-dislikes
        refined-github
        auto-tab-discard
        tree-style-tab
      ];
    };
    qutebrowser = {
      enable = true;
      aliases = {
        "wq" = "quit --save";
        "w" = "session-save";
        "q" = "quit";
      };
      searchEngines = { DEFAULT = "https://search.brave.com/search?q={}"; };
      settings = {
        colors = {
          # SOURCE: https://github.com/theova/base16-qutebrowser/
          completion.fg = "${colors.base05}";
          completion.odd.bg = "${colors.base01}";
          completion.even.bg = "${colors.base00}";
          completion.category.fg = "${colors.base0A}";
          completion.category.bg = "${colors.base00}";
          completion.category.border.top = "${colors.base00}";
          completion.category.border.bottom = "${colors.base00}";
          completion.item.selected.fg = "${colors.base05}";
          completion.item.selected.bg = "${colors.base02}";
          completion.item.selected.border.top = "${colors.base02}";
          completion.item.selected.border.bottom = "${colors.base02}";
          completion.item.selected.match.fg = "${colors.base0B}";
          completion.match.fg = "${colors.base0B}";
          completion.scrollbar.fg = "${colors.base05}";
          completion.scrollbar.bg = "${colors.base00}";
          contextmenu.disabled.bg = "${colors.base01}";
          contextmenu.disabled.fg = "${colors.base04}";
          contextmenu.menu.bg = "${colors.base00}";
          contextmenu.menu.fg = "${colors.base05}";
          contextmenu.selected.bg = "${colors.base02}";
          contextmenu.selected.fg = "${colors.base05}";
          downloads.bar.bg = "${colors.base00}";
          downloads.start.fg = "${colors.base00}";
          downloads.start.bg = "${colors.base0D}";
          downloads.stop.fg = "${colors.base00}";
          downloads.stop.bg = "${colors.base0C}";
          downloads.error.fg = "${colors.base08}";
          hints.fg = "${colors.base00}";
          hints.bg = "${colors.base0A}";
          hints.match.fg = "${colors.base05}";
          keyhint.fg = "${colors.base05}";
          keyhint.suffix.fg = "${colors.base05}";
          keyhint.bg = "${colors.base00}";
          messages.error.fg = "${colors.base00}";
          messages.error.bg = "${colors.base08}";
          messages.error.border = "${colors.base08}";
          messages.warning.fg = "${colors.base00}";
          messages.warning.bg = "${colors.base0E}";
          messages.warning.border = "${colors.base0E}";
          messages.info.fg = "${colors.base05}";
          messages.info.bg = "${colors.base00}";
          messages.info.border = "${colors.base00}";
          prompts.fg = "${colors.base05}";
          prompts.border = "${colors.base00}";
          prompts.bg = "${colors.base00}";
          prompts.selected.bg = "${colors.base02}";
          prompts.selected.fg = "${colors.base05}";
          statusbar.normal.fg = "${colors.base0B}";
          statusbar.normal.bg = "${colors.base00}";
          statusbar.insert.bg = "${colors.base00}";
          statusbar.insert.fg = "${colors.base0D}";
          statusbar.passthrough.bg = "${colors.base00}";
          statusbar.passthrough.fg = "${colors.base0C}";
          statusbar.private.fg = "${colors.base00}";
          statusbar.private.bg = "${colors.base01}";
          statusbar.command.fg = "${colors.base05}";
          statusbar.command.bg = "${colors.base00}";
          statusbar.command.private.fg = "${colors.base05}";
          statusbar.command.private.bg = "${colors.base00}";
          statusbar.caret.fg = "${colors.base00}";
          statusbar.caret.bg = "${colors.base0E}";
          statusbar.caret.selection.fg = "${colors.base00}";
          statusbar.caret.selection.bg = "${colors.base0D}";
          statusbar.progress.bg = "${colors.base0D}";
          statusbar.url.fg = "${colors.base05}";
          statusbar.url.error.fg = "${colors.base08}";
          statusbar.url.hover.fg = "${colors.base05}";
          statusbar.url.success.http.fg = "${colors.base0C}";
          statusbar.url.success.https.fg = "${colors.base0B}";
          statusbar.url.warn.fg = "${colors.base0E}";
          tabs.bar.bg = "${colors.base00}";
          tabs.indicator.start = "${colors.base0D}";
          tabs.indicator.stop = "${colors.base0C}";
          tabs.indicator.error = "${colors.base08}";
          tabs.odd.fg = "${colors.base05}";
          tabs.odd.bg = "${colors.base01}";
          tabs.even.fg = "${colors.base05}";
          tabs.even.bg = "${colors.base00}";
          tabs.pinned.even.bg = "${colors.base0C}";
          tabs.pinned.even.fg = "${colors.base07}";
          tabs.pinned.odd.bg = "${colors.base0B}";
          tabs.pinned.odd.fg = "${colors.base07}";
          tabs.pinned.selected.even.bg = "${colors.base02}";
          tabs.pinned.selected.even.fg = "${colors.base05}";
          tabs.pinned.selected.odd.bg = "${colors.base02}";
          tabs.pinned.selected.odd.fg = "${colors.base05}";
          tabs.selected.odd.fg = "${colors.base05}";
          tabs.selected.odd.bg = "${colors.base02}";
          tabs.selected.even.fg = "${colors.base05}";
          tabs.selected.even.bg = "${colors.base02}";
        };
        fonts = {
          default_family = "JetBrainsMono Nerd Font";
          default_size = "14px";
          web.family.fantasy = "JetBrainsMono Nerd Font";
        };
        tabs.background = true;
        content.blocking.adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://easylist-downloads.adblockplus.org/easylistdutch.txt"
          "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt"
          "https://www.i-dont-care-about-cookies.eu/abp/"
          "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
        ];

        scrolling.smooth = true;

        # DARK MODE
        # colors.webpage.preferred_color_schemes = "dark";

        # CHROMIUM FLAGS
        content.canvas_reading = false;
        content.prefers_reduced_motion = true;
        qt.args = [
          # "enable-gpu-rasterization"
          # "ignore-gpu-blocklist"
          "enable-accelerated-video-decode"
        ];
      };
      keyMappings = {
        "<Shift-Left>" = "back";
        "<Shift-Down>" = "tab-next";
        "<Shift-Up>" = "tab-prev";
        "<Shift-Right>" = "forward";
        "M" = "hint links spawn mpv {hint-url}";
        "Z" = "hint links spawn st -e youtube-dl {hint-url}";
        "xb" = "config-cycle statusbar.show always never";
        "xt" = "config-cycle tabs.show always never";
        "xx" =
          "config-cycle statusbar.show always never;; config-cycle tabs.show always never";
        "<Alt-C>" = "tab-close";
        "t" = "set-cmd-text -s :open -t";
        ";" = "set-cmd-text -s :";
      };
    };
    mpv = {
      enable = true;

    };
    zathura = {
      enable = true;
      options = {
        font = "JetBrainsMono Nerd Font";
        recolor-darkcolor = "${colors.base00}";
        recolor-lightcolor = "${colors.base05}";
        default-bg = "${colors.base00}";
        default-fg = "${colors.base01}";
        statusbar-bg = "${colors.base01}";
        statusbar-fg = "${colors.base04}";
        inputbar-bg = "${colors.base00}";
        inputbar-fg = "${colors.base02}";
        recolor = true;
      };
    };
  };

  home.packages = essentialPkgs ++ socialPkgs ++ networkPkgs ++ filePkgs;
}

# vim:set expandtab ft=nix ts=2 sw=2 noet:
