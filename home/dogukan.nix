{ config, pkgs, ...}:
let 
repo_name = "nixconf";
dotfiles = "${config.home.homeDirectory}/${repo_name}/dotfiles";
create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
configs = {
    hypr = "hypr";
    waybar = "waybar";
    nvim = "nvim";
    rofi = "rofi";
    tmux = "tmux";
};
in
{
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
        platformTheme.name = "gtk"; # follow gtk theme
        style.name = "adwaita-dark";
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
