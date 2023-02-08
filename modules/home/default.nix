inputs@{ options, config, pkgs, lib, home-manager, ... }:

with lib;
with lib.internal;
let cfg = config.elements.home;
in
{
  options.elements.home = with types; {
    file = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    elements.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.elements.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.elements.home.configFile;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.elements.user.name} =
        mkAliasDefinitions options.elements.home.extraOptions;
    };
  };
}
