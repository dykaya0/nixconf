{ pkgs, lib, config, inputs, ... }:

{
  languages.rust = {
    enable = true;
  };

  processes.dev.exec = "cargo run";
}
