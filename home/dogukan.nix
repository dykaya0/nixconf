{ config, pkgs, ...}:
let 
dotfiles = "${config.home.homeDirectory}/nixconf/dotfiles";
create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
configs = {
    hypr = "hypr";
    waybar = "waybar";
    nvim = "nvim";
    rofi = "rofi";
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
}
