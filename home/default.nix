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
		peek
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
        	"layers.acceleration.force-enabled" = true;
					"gfx.webrender.all" = true;
					"svg.context-properties.content.enabled" = true;
				};
        isDefault = true;
				userChrome = ''
/*==============================================================================================*

  +-----+-----+-----+-----+-----+-----+-----+
  | █▀▀ | ▄▀█ | █▀▀ | █▀▀ | ▄▀█ | █▀▄ | █▀▀ |
  | █▄▄ | █▀█ | ▄▄█ | █▄▄ | █▀█ | █▄▀ | ██▄ |
  +-----+-----+-----+-----+-----+-----+-----+


  Description:    Minimalist, Simple, Keyboard Centered and based on SimpleFox. 🦊
                  What you get is a really simple responsive one-line layout using the new Proton UI.

                  > SimpleFox: https://github.com/migueravila/SimpleFox

                  
  Author:         Andreas Grafen
                  (https://andreas.grafen.info)

                  
  Repository:     https://github.com/andreasgrafen/ag.proton


                  Thank you Nick, Abdallah and Benyamin for all the great suggestions for improvements! ♡
                  Nick:     https://github.com/nicksundermeyer)
                  Abdallah: https://github.com/HeiWiper)
                  Benyamin: https://github.com/benyaminl)

                  If you're looking for a **mouse-friendly** clone please check out Waterfall.
                  https://github.com/crambaud/waterfall

*==============================================================================================*/





/*---+---+---+---+---+---+
 | C | O | N | F | I | G |
 +---+---+---+---+---+---*/

/* Feel free to tweak the following
 * config settingsto your own liking. */


 :root {
    
    /*---+---+---+---+---+---+---+
     | C | O | L | O | U | R | S |
     +---+---+---+---+---+---+---*/
     
     
    /* Comment this block out if you want to keep the default theme colour. */
    /* This will also work with custom colours from color.firefox.com. */
  
    --window-colour:               ${colors.base00};
    --secondary-colour:            ${colors.base01};
    --inverted-colour:             ${colors.base05};

     
    /* Containter Tab Colours */
    --uc-identity-color-blue:      ${colors.base0D};
    --uc-identity-color-turquoise: ${colors.base0C};
    --uc-identity-color-green:     ${colors.base0B};
    --uc-identity-color-yellow:    ${colors.base0A};
    --uc-identity-color-orange:    ${colors.base09};
    --uc-identity-color-red:       ${colors.base08};
    --uc-identity-color-pink:      ${colors.base0E};
    --uc-identity-color-purple:    ${colors.base0E};
     
    
    /* URL colour in URL bar suggestions */
    --urlbar-popup-url-color: var(--uc-identity-color-purple) !important;
     
     
     
    /*---+---+---+---+---+---+---+
     | V | I | S | U | A | L | S |
     +---+---+---+---+---+---+---*/
    
    /* global border radius */
    --uc-border-radius: 0;
     
    /* dynamic url bar width settings */
    --uc-urlbar-width: clamp(200px, 40vw, 500px);

    /* dynamic tab width settings */
    --uc-active-tab-width:   clamp(100px, 20vw, 300px);
    --uc-inactive-tab-width: clamp( 50px, 15vw, 200px);

    /* if active always shows the tab close button */
    --show-tab-close-button: none; /* DEFAULT: -moz-inline-box; */ 

    /* if active only shows the tab close button on hover*/
    --show-tab-close-button-hover: none; /* DEFAULT: -moz-inline-box; */
     
    /* adds left and right margin to the container-tabs indicator */
    --container-tabs-indicator-margin: 10px;

}

    /*---+---+---+---+---+---+---+
     | B | U | T | T | O | N | S |
     +---+---+---+---+---+---+---*/

     #back-button,
     #forward-button { display: none !important; }

     /* bookmark icon */
     #star-button{ display: none !important; }

     /* zoom indicator */
     #urlbar-zoom-button { display: none !important; }

     /* Make button small as Possible, hidden out of sight */
     #PanelUI-button { margin-top: -5px; margin-bottom: 44px; }

     #PanelUI-menu-button {

        padding: 0px !important;
        max-height: 1px;

        list-style-image: none !important;

     }

     #PanelUI-menu-button .toolbarbutton-icon { width: 1px !important; }
     #PanelUI-menu-button .toolbarbutton-badge-stack { padding: 0px !important; }

     #reader-mode-button{ display: none !important; }

     /* tracking protection shield icon */
     #tracking-protection-icon-container { display: none !important; }

     /* #identity-box { display: none !important } /* hides encryption AND permission items */
     #identity-permission-box { display: none !important; } /* only hodes permission items */

     /* e.g. playing indicator (secondary - not icon) */
     .tab-secondary-label { display: none !important; }

     #pageActionButton { display: none !important; }
     #page-action-buttons { display: none !important; }

     #urlbar-go-button { display: none !important; }





/*=============================================================================================*/


/*---+---+---+---+---+---+
 | L | A | Y | O | U | T |
 +---+---+---+---+---+---*/

/* No need to change anything below this comment.
 * Just tweak it if you want to tweak the overall layout. c: */

:root {
    
    --uc-theme-colour:                          var(--window-colour,    var(--toolbar-bgcolor));
    --uc-hover-colour:                          var(--secondary-colour, rgba(0, 0, 0, 0.2));
    --uc-inverted-colour:                       var(--inverted-colour,  var(--toolbar-color));

    --button-bgcolor:                           var(--uc-theme-colour)    !important;
    --button-hover-bgcolor:                     var(--uc-hover-colour)    !important;
    --button-active-bgcolor:                    var(--uc-hover-colour)    !important;
    
    --toolbarbutton-border-radius:              var(--uc-border-radius)   !important;
    
    --tab-border-radius:                        var(--uc-border-radius)   !important;
    --lwt-text-color:                           var(--uc-inverted-colour) !important;
    --lwt-tab-text:                             var(--uc-inverted-colour) !important;

    --arrowpanel-border-radius:                 var(--uc-border-radius)   !important;
    
    --tab-block-margin: 2px !important;
    
}





window,
#main-window,
#toolbar-menubar,
#TabsToolbar,
#PersonalToolbar,
#navigator-toolbox,
#sidebar-box,
#nav-bar {

    -moz-appearance: none !important;
    
    border: none !important;
    box-shadow: none !important;
    background: var(--uc-theme-colour) !important;

}





/* grey out ccons inside the toolbar to make it
 * more aligned with the Black & White colour look */
#PersonalToolbar toolbarbutton:not(:hover),
#bookmarks-toolbar-button:not(:hover) { filter: grayscale(1) !important; }


/* remove window control buttons */
.titlebar-buttonbox-container { display: none !important; }


/* remove "padding" left and right from tabs */
.titlebar-spacer { display: none !important; }





/* remove gap after pinned tabs */
#tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
    > #tabbrowser-arrowscrollbox
    > .tabbrowser-tab[first-visible-unpinned-tab] { margin-inline-start: 0 !important; }


/* remove tab shadow */
.tabbrowser-tab
    >.tab-stack
    > .tab-background { box-shadow: none !important;  }


/* tab background */
.tabbrowser-tab
    > .tab-stack
    > .tab-background { background: var(--uc-theme-colour) !important; }


/* active tab background */
.tabbrowser-tab[selected]
    > .tab-stack
    > .tab-background { background: var(--uc-hover-colour) !important; }


/* multi tab selection */
#tabbrowser-tabs:not([noshadowfortests]) .tabbrowser-tab:is([visuallyselected=true], [multiselected]) > .tab-stack > .tab-background:-moz-lwtheme { background: var(--uc-hover-colour) !important; }


/* tab close button options */
.tabbrowser-tab:not([pinned]) .tab-close-button { display: var(--show-tab-close-button) !important; }
.tabbrowser-tab:not([pinned]):hover .tab-close-button { display: var(--show-tab-close-button-hover) !important }


/* adaptive tab width */
.tabbrowser-tab[selected][fadein]:not([pinned]) { max-width: var(--uc-active-tab-width) !important; }
.tabbrowser-tab[fadein]:not([selected]):not([pinned]) { max-width: var(--uc-inactive-tab-width) !important; }


/* container tabs indicator */
.tabbrowser-tab[usercontextid]
    > .tab-stack
    > .tab-background
    > .tab-context-line {
    
        margin: -1px var(--container-tabs-indicator-margin) 0 var(--container-tabs-indicator-margin) !important;

        border-radius: var(--tab-border-radius) !important;

}


/* show favicon when media is playing but tab is hovered */
.tab-icon-image:not([pinned]) { opacity: 1 !important; }


/* Makes the speaker icon to always appear if the tab is playing (not only on hover) */
.tab-icon-overlay:not([crashed]),
.tab-icon-overlay[pinned][crashed][selected] {

  top: 5px !important;
  z-index: 1 !important;

  padding: 1.5px !important;
  inset-inline-end: -8px !important;
  width: 16px !important; height: 16px !important;

  border-radius: 10px !important;

}


/* style and position speaker icon */
.tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {

  stroke: transparent !important;
  background: transparent !important;
  opacity: 1 !important; fill-opacity: 0.8 !important;

  color: currentColor !important;
    
  stroke: var(--uc-theme-colour) !important;
  background-color: var(--uc-theme-colour) !important;

}


/* change the colours of the speaker icon on active tab to match tab colours */
.tabbrowser-tab[selected] .tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {
        
  stroke: var(--uc-hover-colour) !important;
  background-color: var(--uc-hover-colour) !important;

}


.tab-icon-overlay:not([pinned], [sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) { margin-inline-end: 9.5px !important; }


.tabbrowser-tab:not([image]) .tab-icon-overlay:not([pinned], [sharing], [crashed]) {

  top: 0 !important;

  padding: 0 !important;
  margin-inline-end: 5.5px !important; 
  inset-inline-end: 0 !important;

}


.tab-icon-overlay:not([crashed])[soundplaying]:hover,
.tab-icon-overlay:not([crashed])[muted]:hover,
.tab-icon-overlay:not([crashed])[activemedia-blocked]:hover {
    
    color: currentColor !important;
    stroke: var(--uc-inverted-colour) !important;
    background-color: var(--uc-inverted-colour) !important;
    fill-opacity: 0.95 !important;
    
}


.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[soundplaying]:hover,
.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[muted]:hover,
.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[activemedia-blocked]:hover {
    
    color: currentColor !important;
    stroke: var(--uc-inverted-colour) !important;
    background-color: var(--uc-inverted-colour) !important;
    fill-opacity: 0.95 !important;
    
}


/* speaker icon colour fix */
#TabsToolbar .tab-icon-overlay:not([crashed])[soundplaying],
#TabsToolbar .tab-icon-overlay:not([crashed])[muted],
#TabsToolbar .tab-icon-overlay:not([crashed])[activemedia-blocked] { color: var(--uc-inverted-colour) !important; }


/* speaker icon colour fix on hover */
#TabsToolbar .tab-icon-overlay:not([crashed])[soundplaying]:hover,
#TabsToolbar .tab-icon-overlay:not([crashed])[muted]:hover,
#TabsToolbar .tab-icon-overlay:not([crashed])[activemedia-blocked]:hover { color: var(--uc-theme-colour) !important; }





#nav-bar {

    border:     none !important;
    box-shadow: none !important;
    background: transparent !important;

}


/* remove border below whole nav */
#navigator-toolbox { border-bottom: none !important; }


#urlbar,
#urlbar * {

    outline: none !important;
    box-shadow: none !important;

}


#urlbar-background { border: var(--uc-hover-colour) !important; }


#urlbar[focused="true"]
    > #urlbar-background,
#urlbar:not([open])
    > #urlbar-background { background: transparent !important; }


#urlbar[open]
    > #urlbar-background { background: var(--uc-theme-colour) !important; }


.urlbarView-row:hover
    > .urlbarView-row-inner,
.urlbarView-row[selected]
    > .urlbarView-row-inner { background: var(--uc-hover-colour) !important; }
    




/* transition to oneline */
@media (min-width: 1000px) { 
    

    /* move tabs bar over */
    #TabsToolbar { margin-left: var(--uc-urlbar-width) !important; }


    /* move entire nav bar  */
    #nav-bar { margin: calc((var(--urlbar-min-height) * -1) - 8px) calc(100vw - var(--uc-urlbar-width)) 0 0 !important; }


} /* end media query */





/* Container Tabs */
.identity-color-blue      { --identity-tab-color: var(--uc-identity-color-blue)      !important; --identity-icon-color: var(--uc-identity-color-blue)      !important; }
.identity-color-turquoise { --identity-tab-color: var(--uc-identity-color-turquoise) !important; --identity-icon-color: var(--uc-identity-color-turquoise) !important; }
.identity-color-green     { --identity-tab-color: var(--uc-identity-color-green)     !important; --identity-icon-color: var(--uc-identity-color-green)     !important; }
.identity-color-yellow    { --identity-tab-color: var(--uc-identity-color-yellow)    !important; --identity-icon-color: var(--uc-identity-color-yellow)    !important; }
.identity-color-orange    { --identity-tab-color: var(--uc-identity-color-orange)    !important; --identity-icon-color: var(--uc-identity-color-orange)    !important; }
.identity-color-red       { --identity-tab-color: var(--uc-identity-color-red)       !important; --identity-icon-color: var(--uc-identity-color-red)       !important; }
.identity-color-pink      { --identity-tab-color: var(--uc-identity-color-pink)      !important; --identity-icon-color: var(--uc-identity-color-pink)      !important; }
.identity-color-purple    { --identity-tab-color: var(--uc-identity-color-purple)    !important; --identity-icon-color: var(--uc-identity-color-purple)    !important; }
				'';
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
