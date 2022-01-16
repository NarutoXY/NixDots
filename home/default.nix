{ nixpkgs, pkgs, nurpkgs, inputs, overlays, nix-colors, self, ... }:

# graphical session configuration
# includes programs and services that work on both Wayland and X

let
  inherit (self.lib) mapAttrs x;
  colors = mapAttrs (n: v: x v) nix-colors.colors;
  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in {
  # nixpkgs config
  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };

  imports = [
    ./editors
    ./app.nix
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

    gtk3.extraConfig = {
      gtk-theme-name = "catppuccin";
    };
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
					"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
					"browser.newtabpage.activity-stream.showSponsored" = false;
					"browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
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
					"toolkit.telemetry.bhrPing.enabled" = false; # [FF57+] Background Hang Reporter
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
       };
      	isDefault = true;
      };
      extensions = with nur.repos.rycee.firefox-addons; [
				ublock-origin
				darkreader
	i-dont-care-about-cookies			stylus
				surfingkeys
				terms-of-service-didnt-read
				return-youtube-dislikes
				refined-github
				auto-tab-discard
				tree-style-tab
      ];
    };

    zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-darkcolor = "#${colors.base00}";
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.7)";
        default-fg = "#${colors.base06}";
      };
    };
  };
}

# vim:set expandtab ft=nix ts=2 sw=2 noet:
