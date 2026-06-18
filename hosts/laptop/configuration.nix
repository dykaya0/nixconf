{ ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/common.nix
        ../../modules/laptop.nix
    ];

    networking.hostName = "nixos-laptop";
}
