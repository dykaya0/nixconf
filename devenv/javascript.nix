{ pkgs, lib, config, inputs, ... }:

{
  env.GREET = "js";

  languages.javascript = {
    enable = true;
    pnpm.enable = true;
  };

  processes.dev.exec = "pnpm dev";
}
