{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.archetypes.server;
in
{
  options.elements.archetypes.server = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the server archetype.";
  };

  config = mkIf cfg.enable {
    elements = {
      suites = {
        common-slim = enabled;
      };

      cli-apps = {
        tmux = enabled;
      };
    };
  };
}
