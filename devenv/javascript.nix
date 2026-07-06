{ pkgs, lib, config, inputs, ... }:

{
  languages.javascript = {
    enable = true;
    lsp.enable = true;
    pnpm.enable = true;
  };

  processes.dev.exec = "pnpm dev";
}
