{ config, pkgs, ...}:
let 
repo_name = "nixconf";
dotfiles = "${config.home.homeDirectory}/${repo_name}/dotfiles";
create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
configs = {
    ghostty = "ghostty";
    hypr = "hypr";
    nvim = "nvim";
    rofi = "rofi";
    tmux = "tmux";
    waybar = "waybar";
    kitty = "kitty";
};
in
{
    imports = [
        ../modules/home-manager/firefox.nix
    ];
    home.username = "dogukan";
    home.homeDirectory = "/home/dogukan";
    home.stateVersion = "26.05";

    programs.firefox.enable = true;
    programs.neovim.defaultEditor = true;

    xdg.configFile = builtins.mapAttrs
        (name: subpath: {
         source = create_symlink "${dotfiles}/${subpath}/";
         recursive = true;
         })
    configs;

    home.packages = with pkgs; [
        kitty
        gcc
        gnumake
        neovim
        ripgrep
        rofi
        tmux
        waybar
    ];

    # GTK setup
    gtk = {
        enable = true;

        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };

        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };

        cursorTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
            size = 24;
        };

        font = {
            name = "Inter";
            package = pkgs.inter;
            size = 11;
        };

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = true;
        };

        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = true;
        };
    };
    # QT setup
    qt = {
      enable = true;

      platformTheme.name = "gtk";

      style = {
        name = "adwaita";
        package = pkgs.adwaita-qt;
      };
    };

    # Cursor(system-wide)
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 18;
    };
}
