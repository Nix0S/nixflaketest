{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.elements.system.time;
in
{
  options.elements.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable { time.timeZone = "America/Chicago"; };
}
