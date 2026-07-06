{ pkgs, lib, config, inputs, ... }:

{
  languages.javascript = {
    enable = true;
    pnpm.enable = true;
  };

  processes.dev.exec = "pnpm dev";
}
