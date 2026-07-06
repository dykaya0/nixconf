{ pkgs, lib, config, inputs, ... }:

{
  env.GREET = "rust";

  languages.rust = {
    enable = true;
  };

  processes.dev.exec = "cargo run";
}
