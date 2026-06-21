{ ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/common.nix
        ../../modules/desktop.nix
    ];

    networking.hostName = "nixos";
}
