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
                "full-screen-api.warning.timeout" = 0;
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
