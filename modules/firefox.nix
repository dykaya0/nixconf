{ ... }:

let
lock-false = {
    Value = false;
    Status = "locked";
};
lock-true = {
    Value = true;
    Status = "locked";
};
in
{
    programs.firefox = {
        enable = true;
        languagePacks = [ "en-GB" ];

        /* ---- POLICIES ---- */
# Check about:policies#documentation for options.
        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            EnableTrackingProtection = {
                Value= true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = false;
            };
            DisablePocket = true;
            DisableFirefoxAccounts = true;
            DisableAccounts = true;
            DisableFirefoxScreenshots = true;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
                DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
                SearchBar = "unified"; # alternative: "separate"

                /* ---- EXTENSIONS ---- */
# Check about:support for extension/add-on ID strings.
# Valid strings for installation_mode are "allowed", "blocked",
# "force_installed" and "normal_installed".
                ExtensionSettings = {
                    "*".installation_mode = "allowed"; # block/allow all addons except the ones specified below
# uBlock Origin:
                        "uBlock0@raymondhill.net" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                            installation_mode = "force_installed";
                        };
# SponsorBlock:
                    "sponsorBlocker@ajay.app" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/file/4773757/latest.xpi";
                        installation_mode = "force_installed";
                    };
# GitHub Refined:
                    "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/file/4840557/latest.xpi";
                        installation_mode = "force_installed";
                    };
                };

            /* ---- PREFERENCES ---- */
# Check about:config for options.
            Preferences = { 
                "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
                "extensions.pocket.enabled" = lock-false;
                "extensions.screenshots.disabled" = lock-true;
                "browser.topsites.contile.enabled" = lock-false;
                "browser.formfill.enable" = lock-false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
                "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
                "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
                "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
                "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
                "browser.newtabpage.activity-stream.showSponsored" = lock-false;
                "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

                "sidebar.verticalTabs" = lock-true;
                "sidebar.verticalTabs.dragToPinPromo.dismissed" = lock-true;
                "sidebar.animation.duration-ms" = 100;
                "sidebar.animation.expand-on-hover.delay-duration-ms" = 120;
                "sidebar.animation.expand-on-hover.duration-ms" = 150;
                "full-screen-api.warning.timeout" = 0;
            };
        };
    };
}
