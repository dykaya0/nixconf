{ pkgs, lib, config, ... }: {
  options.myteam = {
    languages.rust.enable = lib.mkEnableOption "rust";
    services.database.enable = lib.mkEnableOption "database";
  };

  config = {
    profiles = {
      backend.module = {
        myteam.languages.rust.enable = true;
        myteam.services.database.enable = true;
      };
      frontend.module = {
        languages.javascript.enable = true;
      };
      fullstack.extends = [ "backend" "frontend" ];
    };
  };
}
