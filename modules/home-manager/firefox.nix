{ pkgs, inputs, system, ... }:

{
    programs.firefox = {
        enable = true;
        profiles.dogukan = {

            search.engines = {
                "Nix Packages" = {
                    urls = [{
                        template = "https://search.nixos.org/packages";
                        params = [
                        { name = "type"; value = "packages"; }
                        { name = "query"; value = "{searchTerms}"; }
                        ];
                    }];

                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "@np" ];
                };
            };
            search.force = true;

            bookmarks = [
            {
                name = "Bookmarks Toolbar";
                toolbar = true;
                bookmarks = [
                {
                    name = "youtube";
                    url = "https://youtube.com";
                }
                {
                    name = "reddit";
                    url = "https://reddit.com";
                }
                {
                    name = "instagram";
                    url = "https://instagram.com";
                }
                {
                    name = "whatsapp";
                    url = "https://web.whatsapp.com";
                }
                {
                    name = "github";
                    url = "https://github.com";
                }
                {
                    name = "codeberg";
                    url = "https://codeberg.org";
                }
                {
                    name = "AI";
                    bookmarks = [
                    {
                        name = "ChatGPT";
                        url = "https://chatgpt.com";
                    }
                    {
                        name = "Gemini";
                        url = "https://gemini.google.com";
                    }
                    {
                        name = "Claude";
                        url = "https://claude.ai";
                    }
                    ];
                }
                ];
            }
            ];

            settings = {
                "dom.security.https_only_mode" = true;
                "browser.download.panel.shown" = true;
                "identity.fxaccounts.enabled" = false;
                "signon.rememberSignons" = false;
                "sidebar.verticalTabs" = true;
                "general.autoScroll" = true;
                "layout.css.prefers-color-scheme.content-override" = 0;
                "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                "full-screen-api.warning.timeout" = 0;
                "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
                "browser.toolbars.bookmarks.visibility" = "always";
                "browser.uiCustomization.state" = ''
                    {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action"],
                    "nav-bar":["reset-pbm-toolbar-button","back-button","forward-button","stop-reload-button","home-button","sidebar-button","urlbar-container","vertical-spacer","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","addon_darkreader_org-browser-action","unified-extensions-button","downloads-button"]
                    ,"toolbar-menubar":["menubar-items"],
                    "TabsToolbar":[],
                    "vertical-tabs":["tabbrowser-tabs"],
                    "PersonalToolbar":["import-button","personal-bookmarks"]},
                    "seen":["reset-pbm-toolbar-button","developer-button","screenshot-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","addon_darkreader_org-browser-action","sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action"],
                    "dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","unified-extensions-area","toolbar-menubar","PersonalToolbar"],
                    "currentVersion":24,
                    "newElementCount":4}
                '';
            };

            extensions.packages = with inputs.firefox-addons.packages.${system}; [
                bitwarden
                    ublock-origin
                    sponsorblock
                    darkreader
            ];

        };
    };
}
