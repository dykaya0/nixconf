{ ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/common.nix
        ../../modules/laptop.nix
        ../../modules/firefox.nix
    ];

    networking.hostName = "nixos-laptop";
}
