{ options, config, lib, pkgs, ... }:
with lib;
with lib.internal;
let cfg = config.elements.archetypes.workstation;
in
{
  options.elements.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    elements = {
      suites = {
        common = enabled;
        desktop = enabled;
        social = enabled;
      };

      tools = {
        appimage-run = enabled;
      };
    };
  };
}
