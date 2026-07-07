{ pkgs, lib, config, inputs, ... }:

{
    languages.rust = {
        enable = true;
        channel = "stable";
        lsp.enable = true;
        components = [ "rust-src" "clippy" "rustfmt" ];
    };

    processes.dev.exec = "cargo run";
}
